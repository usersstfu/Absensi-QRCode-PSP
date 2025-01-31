<?php

namespace App\Livewire\Admin;

use App\Livewire\Forms\UserForm;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Laravel\Jetstream\InteractsWithBanner;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\WithPagination;

class EmployeeComponent extends Component
{
    use WithPagination, InteractsWithBanner, WithFileUploads;

    public UserForm $form;
    public $deleteName = null;
    public $creating = false;
    public $editing = false;
    public $confirmingDeletion = false;
    public $selectedId = null;
    public $showDetail = null;
    public $confirmingUnblock = false;
    public $selectedUserId = null;

    # filter
    public ?string $division = null;
    public ?string $jobTitle = null;
    public ?string $education = null;
    public ?string $search = null;

    public function confirmUnblock($id)
    {
        $this->selectedUserId = $id;
        $this->confirmingUnblock = true;
    }

    public function unblockUser()
    {
        $user = User::find($this->selectedUserId);

        if (!$user) {
            $this->banner(__('Karyawan tidak ditemukan.'), 'danger');
            $this->confirmingUnblock = false;
            $this->selectedUserId = null;
            return;
        }

        if (!$user->is_blocked) {
            $this->banner(__('Karyawan sudah tidak diblokir.'), 'danger');
            $this->confirmingUnblock = false;
            $this->selectedUserId = null;
            return;
        }

        $user->update([
            'is_blocked' => false,
            'unblocked_at' => now(),
        ]);

        $this->banner(__('Blokir telah dibuka untuk :name.', ['name' => $user->name]));
        $this->confirmingUnblock = false;
        $this->selectedUserId = null;
    }

    public function show($id)
    {
        $this->form->setUser(User::find($id));
        $this->showDetail = true;
    }

    public function showCreating()
    {
        $this->form->resetErrorBag();
        $this->form->reset();
        $this->creating = true;
        $this->form->password = 'password';
    }

    public function create()
    {
        $this->form->store();
        $this->creating = false;
        $this->banner(__('Created successfully.'));
    }

    public function edit($id)
    {
        $this->form->resetErrorBag();
        $this->form->reset();
        $this->editing = true;
        /** @var User $user */
        $user = User::find($id);
        $this->form->setUser($user);
    }

    public function update()
    {
        $this->form->update();
        $this->editing = false;
        $this->banner(__('Updated successfully.'));
    }

    public function deleteProfilePhoto()
    {
        $this->form->deleteProfilePhoto();
    }

    public function confirmDeletion($id, $name)
    {
        $this->deleteName = $name;
        $this->confirmingDeletion = true;
        $this->selectedId = $id;
    }

    public function delete()
    {
        $user = User::find($this->selectedId);
        $this->form->setUser($user)->delete();
        $this->confirmingDeletion = false;
        $this->banner(__('Deleted successfully.'));
    }

    public function render()
    {
        $authUser = auth()->user();

        $users = User::where('group', 'user')
            ->when(!$authUser->isSuperadmin, function (Builder $query) use ($authUser) {
                $query->where('division_id', $authUser->division_id);
            })
            ->when($this->search, function (Builder $query) {
                return $query->where('name', 'like', '%' . $this->search . '%')
                    ->orWhere('nip', 'like', '%' . $this->search . '%')
                    ->orWhere('email', 'like', '%' . $this->search . '%')
                    ->orWhere('phone', 'like', '%' . $this->search . '%');
            })
            ->when($this->division, fn(Builder $query) => $query->where('division_id', $this->division))
            ->when($this->jobTitle, fn(Builder $query) => $query->where('job_title_id', $this->jobTitle))
            ->when($this->education, fn(Builder $query) => $query->where('education_id', $this->education))
            ->orderBy('name')
            ->paginate(20);

        return view('livewire.admin.employees', ['users' => $users]);
    }
}

<?php

namespace App\Livewire\Admin\MasterData;

use App\Livewire\Forms\UserForm;
use App\Models\User;
use Laravel\Jetstream\InteractsWithBanner;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\WithPagination;

class Admin extends Component
{
    use WithPagination, InteractsWithBanner, WithFileUploads;

    public UserForm $form;
    public $groups = [];
    public $deleteName = null;
    public $creating = false;
    public $editing = false;
    public $confirmingDeletion = false;
    public $selectedId = null;
    public $showDetail = null;
    public $address = 'N/A';
    public $city = 'N/A';
    protected $rules = [
        'form.name' => 'required|string|max:255',
        'form.email' => 'required|email|unique:users,email',
        'form.password' => 'required|string|min:5',
        'form.group' => 'required|in:admin,superadmin',
        'form.gender' => 'required|in:male,female',
        'form.phone' => 'nullable|string|max:15',
        'form.division_id' => 'nullable|exists:divisions,id',
    ];

    public function __construct()
    {
        $this->groups = User::$groups;
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
        $this->form->password = 'admin';
    }

    public function store()
    {
        $validated = $this->validate([
            'form.name' => 'required|string|max:255',
            'form.email' => 'required|email|unique:users,email',
            'form.password' => 'required|string|min:6',
            'form.group' => 'required|in:admin,superadmin',
            'form.gender' => 'required|in:male,female',
            'form.phone' => 'nullable|string|max:15',
            'form.address' => 'nullable|string|max:255',
            'form.city' => 'nullable|string|max:255',
            'form.division_id' => $this->form->group === 'admin' ? 'required|exists:divisions,id' : 'nullable',
        ]);

        User::create([
            'name' => $this->form->name,
            'email' => $this->form->email,
            'password' => bcrypt($this->form->password),
            'group' => $this->form->group,
            'gender' => $this->form->gender,
            'phone' => $this->form->phone ?? '',
            'address' => $this->form->address ?? 'N/A',
            'city' => $this->form->city ?? 'N/A',
            'division_id' => $this->form->group === 'admin' ? $this->form->division_id : null, // Hanya untuk admin
        ]);
    }

    public function create()
    {
        if ($this->form->group === 'admin') {
            $this->validate([
                'form.division_id' => 'required|exists:divisions,id',
            ]);
        }

        $this->store();

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
        $users = User::whereIn('group', ['admin', 'superadmin'])->orderBy('group', 'desc')->paginate(20);
        return view('livewire.admin.master-data.admin', ['users' => $users]);
    }
}

<?php

namespace App\Livewire\Admin\MasterData;

use App\Livewire\Forms\ShiftForm;
use App\Models\Shift;
use Laravel\Jetstream\InteractsWithBanner;
use Livewire\Component;

class ShiftComponent extends Component
{
    use InteractsWithBanner;

    public $form = [
        'name' => '',
        'start_time' => '',
        'end_time' => '',
        'division_id' => null,
        'work_days' => [],
    ];
    public $deleteName = null;
    public $creating = false;
    public $editing = false;
    public $confirmingDeletion = false;
    public $selectedId = null;

    protected $rules = [
        'form.name' => ['required', 'string', 'max:255'],
        'form.start_time' => ['required', 'date_format:H:i'],
        'form.end_time' => ['required', 'date_format:H:i', 'after:form.start_time'],
        'form.division_id' => ['required', 'exists:divisions,id'],
        'form.work_days' => ['required', 'array', 'min:1'],
    ];

    public function showCreating()
    {
        $this->resetErrorBag();
        $this->reset('form');
        $this->creating = true;
    }

    public function create()
    {
        $this->validate();
        
         $this->form['work_days'] = array_values(array_filter($this->form['work_days'] ?? []));

        Shift::create($this->form);

        $this->creating = false;
        $this->reset('form');
        $this->banner(__('Shift created successfully.'));
    }

    public function edit($id)
    {
        $this->resetErrorBag();
        $this->editing = true;

        $shift = Shift::findOrFail($id);

        $this->form = [
            'name' => $shift->name,
            'start_time' => $shift->start_time,
            'end_time' => $shift->end_time,
            'division_id' => $shift->division_id,
            'work_days' => $shift->work_days ?? [],
        ];

        $this->selectedId = $id;
    }

    public function update()
    {
        $this->validate();
        
         $this->form['work_days'] = array_values(array_filter($this->form['work_days'] ?? []));

        $shift = Shift::findOrFail($this->selectedId);

        $shift->update($this->form);

        $this->editing = false;
        $this->reset(['form', 'selectedId']);
        $this->banner(__('Shift updated successfully.'));
    }

    public function confirmDeletion($id, $name)
    {
        $this->deleteName = $name;
        $this->confirmingDeletion = true;
        $this->selectedId = $id;
    }

    public function delete()
    {
        $shift = Shift::findOrFail($this->selectedId);

        $shift->delete();

        $this->confirmingDeletion = false;
        $this->reset(['selectedId', 'deleteName']);
        $this->banner(__('Shift deleted successfully.'));
    }

    public function render()
    {
        $shifts = Shift::all();
        return view('livewire.admin.master-data.shift', ['shifts' => $shifts]);
    }
}

<?php

namespace App\Livewire\Admin;

use App\Livewire\Traits\AttendanceDetailTrait;
use App\Models\Attendance;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Carbon;
use Laravel\Jetstream\InteractsWithBanner;
use Livewire\Component;
use Livewire\WithPagination;

class AttendanceComponent extends Component
{
    use AttendanceDetailTrait;
    use WithPagination, InteractsWithBanner;

    // Filters
    public ?string $month = null;
    public ?string $week = null;
    public ?string $date = null;
    public ?string $division = null;
    public ?string $jobTitle = null;
    public ?string $search = null;
    public $availableDivisions;

    public bool $showApproveModal = false;
    public ?int $selectedAttendanceId = null;
    public string $approvalMessage = '';

    public function mount()
    {
        $this->date = date('Y-m-d');
        
        $authUser = auth()->user();

    if ($authUser->isSuperadmin) {
        $this->availableDivisions = \App\Models\Division::all();
    } else {
        $this->availableDivisions = \App\Models\Division::where('id', $authUser->division_id)->get();

        $this->division = $authUser->division_id;
    }
    }

    public function openApproveModal($attendanceId, $type)
{
    $attendance = Attendance::findOrFail($attendanceId);

    if ($attendance->status === 'dinas' && !auth()->user()->isSuperadmin) {
        $this->approvalMessage = 'Anda Tidak Memiliki Otoritas Untuk Menyetujui Pengajuan Perjalanan Dinas.';
        $this->showApproveModal = true;
        return;
    }

    $this->selectedAttendanceId = $attendanceId;

    $this->approvalMessage = match ($attendance->status) {
        'sick' => 'Apakah Anda Yakin Menyetujui Ijin Sakit Ini?',
        'excused' => 'Apakah Anda Yakin Menyetujui Izin ini?',
        'dinas' => 'Apakah Anda Yakin Menyetujui Perjalanan Dinas Ini?',
        default => 'Apakah Anda Yakin Menyetujui Pengajuan Ini?',
    };

    $this->showApproveModal = true;
}

    public function closeModal()
    {
        $this->reset(['showApproveModal', 'selectedAttendanceId', 'approvalMessage']);
    }

    public function approveAttendance()
{
    $attendance = Attendance::findOrFail($this->selectedAttendanceId);

    if ($attendance->status === 'dinas' && !auth()->user()->isSuperadmin) {
        session()->flash('error', 'Anda Tidak Memiliki Otoritas Untuk Menyetujui Pengajuan Perjalanan Dinas.');
        $this->closeModal();
        return;
    }

    $attendance->update(['approval_status' => 'approved']);

    session()->flash('success', 'Pengajuan berhasil disetujui.');
    $this->closeModal();
}


    public function reject()
    {
        $attendance = Attendance::findOrFail($this->selectedAttendanceId);

        $this->closeModal();

        $attendance->update(['approval_status' => 'rejected']);
        $attendance->delete();

        session()->flash('error', 'Pengajuan berhasil ditolak.');
    }

    public function updating($key): void
    {
        if (in_array($key, ['search', 'division', 'jobTitle'])) {
            $this->resetPage();
        } elseif ($key === 'month') {
            $this->resetPage();
            $this->week = null;
            $this->date = null;
        } elseif ($key === 'week') {
            $this->resetPage();
            $this->month = null;
            $this->date = null;
        } elseif ($key === 'date') {
            $this->resetPage();
            $this->month = null;
            $this->week = null;
        }
    }

    public function render()
    {
        $authUser = auth()->user();

        if ($this->date) {
            $dates = [Carbon::parse($this->date)];
        } elseif ($this->week) {
            $start = Carbon::parse($this->week)->startOfWeek();
            $end = Carbon::parse($this->week)->endOfWeek();
            $dates = $start->range($end)->toArray();
        } elseif ($this->month) {
            $start = Carbon::parse($this->month)->startOfMonth();
            $end = Carbon::parse($this->month)->endOfMonth();
            $dates = $start->range($end)->toArray();
        }

        $employees = User::where('group', 'user')
            ->when(!$authUser->isSuperadmin, function (Builder $query) use ($authUser) {
                return $query->where('division_id', $authUser->division_id);
            })
            ->when($this->search, function (Builder $query) {
                return $query->where('name', 'like', '%' . $this->search . '%')
                    ->orWhere('nip', 'like', '%' . $this->search . '%');
            })
            ->when($this->division, fn(Builder $query) => $query->where('division_id', $this->division))->when($this->division, function (Builder $query) {
    return $query->where('division_id', $this->division);
})
->when(!auth()->user()->isSuperadmin, function (Builder $query) {
    return $query->where('division_id', auth()->user()->division_id);
})
            ->when($this->jobTitle, fn(Builder $query) => $query->where('job_title_id', $this->jobTitle))
            ->paginate(20)->through(function (User $user) {
                $attendances = Attendance::filter(
                    userId: $user->id,
                    date: $this->date,
                    week: $this->week,
                    month: $this->month,
                )->get()->map(function (Attendance $attendance) {
                    $attendance->setAttribute('coordinates', $attendance->lat_lng);
                    $attendance->setAttribute('lat', $attendance->latitude);
                    $attendance->setAttribute('lng', $attendance->longitude);
                    $attendance->setAttribute('approval_status', $attendance->approval_status);
                    if ($attendance->attachment) {
                        $attendance->setAttribute('attachment', $attendance->attachment_url);
                    }
                    if ($attendance->shift) {
                        $attendance->setAttribute('shift', $attendance->shift->name);
                    }
                    return $attendance->getAttributes();
                })->toArray();

                $user->attendances = new Collection($attendances);

                return $user;
            });

        return view('livewire.admin.attendance', [
            'employees' => $employees,
            'dates' => $dates ?? [],
        ]);
    }
}

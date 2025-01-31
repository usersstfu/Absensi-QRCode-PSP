<?php

namespace App\Livewire\Admin;

use App\Livewire\Traits\AttendanceDetailTrait;
use App\Models\Attendance;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Livewire\Component;

class DashboardComponent extends Component
{
    use AttendanceDetailTrait;

    public function render()
    {
        $authUser = auth()->user();

        /** @var Collection<Attendance> */
        $attendances = Attendance::where('date', date('Y-m-d'))
            ->when(!$authUser->isSuperadmin, function ($query) use ($authUser) {
                // Filter berdasarkan divisi untuk admin biasa
                $query->whereHas('user', function ($userQuery) use ($authUser) {
                    $userQuery->where('division_id', $authUser->division_id);
                });
            })
            ->get();

        /** @var Collection<User> */
        $employeesQuery = User::where('group', 'user')
            ->when(!$authUser->isSuperadmin, function ($query) use ($authUser) {
                // Filter berdasarkan divisi untuk admin biasa
                $query->where('division_id', $authUser->division_id);
            });

        // Hitung jumlah total karyawan
        $employeesCount = $employeesQuery->count();

        // Paginasi data karyawan
        $employees = $employeesQuery->paginate(20)->through(function (User $user) use ($attendances) {
            $attendance = $attendances->firstWhere('user_id', $user->id);
            return $user->setAttribute('attendance', $attendance);
        });

        // Hitung jumlah absensi berdasarkan status
        $presentCount = $attendances->where('status', 'present')->count();
        $lateCount = $attendances->where('status', 'late')->count();
        $excusedCount = $attendances->where('status', 'excused')->count();
        $sickCount = $attendances->where('status', 'sick')->count();
        $businessTripCount = $attendances->where('status', 'dinas')->count();
        $absentCount = $employeesCount - ($presentCount + $lateCount + $excusedCount + $sickCount + $businessTripCount);

        return view('livewire.admin.dashboard', [
            'employees' => $employees,
            'employeesCount' => $employeesCount,
            'presentCount' => $presentCount,
            'lateCount' => $lateCount,
            'excusedCount' => $excusedCount,
            'sickCount' => $sickCount,
            'absentCount' => $absentCount,
            'businessTripCount' => $businessTripCount,
        ]);
    }
}

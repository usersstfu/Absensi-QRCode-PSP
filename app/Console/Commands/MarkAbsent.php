<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Attendance;
use App\Models\User;
use App\Models\Shift;
use App\Models\Holiday;
use Illuminate\Support\Carbon;

class MarkAbsent extends Command
{
    protected $signature = 'attendance:mark-absent';
    protected $description = 'Mark users as absent if they did not scan or submit any leave requests for today and block users with 5 or more warnings.';

    public function handle()
    {
        $date = Carbon::today()->format('Y-m-d');

        $isHoliday = Holiday::where('date', $date)->exists();

        if ($isHoliday) {
            $this->info("Hari ini ($date) adalah hari libur nasional. Tidak ada absensi yang diproses.");
            return;
        }

        $users = User::where('group', 'user')->get();

        foreach ($users as $user) {
            $shift = Shift::where('division_id', $user->division_id)->first();

            if (!$shift) {
                $this->warn("Shift tidak ditemukan untuk user ID {$user->id}. Skip.");
                continue;
            }

            $today = Carbon::now()->locale('id')->isoFormat('dddd');

            if (!in_array($today, $shift->work_days ?? [])) {
                $this->info("Hari ini ($today) bukan hari kerja untuk user ID {$user->id}. Skip.");
                continue;
            }

            $attendanceExists = Attendance::where('user_id', $user->id)
                ->where('date', $date)
                ->exists();

            if (!$attendanceExists) {
                $hasLeaveRequest = Attendance::where('user_id', $user->id)
                    ->where('date', $date)
                    ->whereIn('status', ['excused', 'sick'])
                    ->exists();

                if (!$hasLeaveRequest) {
                    Attendance::create([
                        'user_id' => $user->id,
                        'date' => $date,
                        'status' => 'absent',
                        'note' => 'Tidak Hadir Untuk Hari Ini',
                    ]);

                    $this->info("User ID {$user->id} ditandai sebagai absen.");
                }
            }

            $this->checkAndBlockUser($user);
        }

        $this->info('Proses selesai: Semua pengguna tanpa scan atau cuti telah ditandai.');
    }

    /**
     * Periksa apakah user harus diblokir berdasarkan jumlah absen/terlambat.
     */
    protected function checkAndBlockUser($user)
    {
        $now = Carbon::now();
        $unblockedAt = $user->unblocked_at ?? '2000-01-01 00:00:00';

        $lateCount = Attendance::where('user_id', $user->id)
            ->where('status', 'late')
            ->where('date', '>=', $unblockedAt)
            ->whereMonth('date', $now->month)
            ->count();

        $absentCount = Attendance::where('user_id', $user->id)
            ->where('status', 'absent')
            ->where('date', '>=', $unblockedAt)
            ->whereMonth('date', $now->month)
            ->count();

        $totalWarnings = $lateCount + $absentCount;

        if ($totalWarnings >= 5 && !$user->is_blocked) {
            $user->update(['is_blocked' => true]);
            $this->info("User ID {$user->id} telah diblokir karena 5 atau lebih absen/telat.");
        }
    }
}


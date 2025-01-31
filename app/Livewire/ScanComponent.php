<?php

namespace App\Livewire;

use App\ExtendedCarbon;
use App\Models\Attendance;
use App\Models\Barcode;
use App\Models\Shift;
use Illuminate\Support\Facades\Auth;
use Livewire\Component;
use Ballen\Distical\Calculator as DistanceCalculator;
use Ballen\Distical\Entities\LatLong;
use Illuminate\Support\Carbon;

class ScanComponent extends Component
{
    public ?array $approvalStatusData = null;
    public ?Attendance $attendance = null;
    public $shift_id = null;
    public $shifts = null;
    public ?array $currentLiveCoords = null;
    public string $successMsg = '';
    public array $warningMsg = [];
    public bool $isAbsence = false;
    public array $rejectedDates = [];
    public ?string $requestNote = null;
    public bool $showModal = false;
    public bool $showCheckOutModal = false;
    public bool $cannotSubmit = false;
    public string $errorMsg = '';

    public function confirmCheckOut()
    {
        if (!$this->attendance || $this->attendance->status !== 'request' || $this->attendance->approval_status !== 'approved' || !$this->attendance->time_in) {
            session()->flash('error', 'Data absensi tidak valid untuk absen keluar.');
            $this->showCheckOutModal = true;
            return;
        }

        $timezone = Auth::user()->division->timezone ?? 'Asia/Jakarta';
        $now = Carbon::now($timezone);

        $shift = Shift::find($this->attendance->shift_id);
        if (!$shift) {
            session()->flash('error', 'Shift tidak ditemukan.');
            $this->showCheckOutModal = true;
            return;
        }

        $shiftEndTime = Carbon::createFromTimeString($shift->end_time, $timezone);

        if ($now->lessThan($shiftEndTime)) {
            session()->flash('error', 'Belum Waktunya Untuk Absen Keluar. Harap Sesuaikan Dengan Jam Keluar Shift.');
            $this->showCheckOutModal = true;
            return;
        }

        $this->showCheckOutModal = true;
    }

    public function cancelCheckOut()
    {
        $this->showCheckOutModal = false;
    }

    public function checkOut()
    {
        if (!$this->attendance || $this->attendance->status !== 'request' || $this->attendance->approval_status !== 'approved' || !$this->attendance->time_in) {
            session()->flash('error', 'Tidak dapat memproses absen keluar.');
            $this->showCheckOutModal = false;
            return;
        }

        $timezone = Auth::user()->division->timezone ?? 'Asia/Jakarta';
        $now = Carbon::now($timezone);

        $shift = Shift::find($this->attendance->shift_id);
        if (!$shift) {
            session()->flash('error', 'Shift tidak ditemukan.');
            $this->showCheckOutModal = false;
            return;
        }

        $shiftEndTime = Carbon::createFromTimeString($shift->end_time, $timezone);
        if ($now->lessThan($shiftEndTime)) {
            session()->flash('error', 'Belum Waktunya Untuk Absen Keluar. Harap Sesuaikan Dengan Jam Keluar Shift.');
            $this->showCheckOutModal = false;
            return;
        }

        $status = $this->attendance->is_late ? 'late' : 'present';
        $this->attendance->update([
            'time_out' => $now->toTimeString(),
            'status' => $status,
        ]);

        $this->showCheckOutModal = false;

        session()->flash('success', 'Absen Keluar Berhasil Dicatat.');
    }

    public function openModal()
    {
        $this->resetErrorBag();

        if ($this->attendance) {
            if ($this->attendance->status === 'request') {
                $this->cannotSubmit = true;
                $this->errorMsg = 'Anda Sudah Melakukan Absensi Dari Jauh. Silakan Absen Keluar Jika Sudah Mencapai Waktu Akhir Shift.';
            } else {
                $this->cannotSubmit = true;
                $this->errorMsg = 'Anda Sudah Melakukan Absensi Hari Ini. Anda Tidak Dapat Mengajukan Absensi Dari Jauh';
            }
        } else {
            $this->cannotSubmit = false;
        }

        $this->showModal = true;
    }

    public function closeModal()
    {
        $this->showModal = false;
        $this->reset(['cannotSubmit', 'errorMsg']);
    }

    public function submitRequest()
    {
        $this->validate([
            'shift_id' => 'required',
            'requestNote' => 'required|string|max:255',
        ]);

        $this->requestPermission($this->requestNote);

        $this->attendance = Attendance::where('user_id', Auth::id())->where('date', now()->format('Y-m-d'))->first();

        $this->showModal = false;

        session()->flash('success', 'Permintaan absensi berhasil diajukan.');
    }

    public function translateStatus($status)
    {
        $translations = [
            'present' => 'Hadir',
            'absent' => 'Tidak Hadir',
            'sick' => 'Sakit',
            'excused' => 'Izin',
            'dinas' => 'Perjalanan Dinas',
            'request' => 'Absen Dari Jauh',
        ];

        return $translations[$status] ?? $status;
    }

    public function scan(string $barcode)
    {
        $user = Auth::user();

        $this->checkWarnings($user);

        if ($user->is_blocked) {
            return __('Anda Tidak Dapat Absen Karena Telah Diblokir. Hubungi Supervisor Untuk Membuka Blokir.');
        }

        if (is_null($this->currentLiveCoords) || count($this->currentLiveCoords) < 2) {
            return __('Lokasi Anda tidak dapat dideteksi. Mohon aktifkan GPS.');
        }

        if (is_null($this->shift_id)) {
            throw new \Exception('Shift belum dipilih. Mohon pilih shift terlebih dahulu.');
        }

        /** @var Barcode */
        $barcode = Barcode::where('value', $barcode)->first();

        if (!Auth::check() || !$barcode) {
            return __('Barcode tidak valid.');
        }

        $shift = Shift::find($this->shift_id);
        if (!$shift || $barcode->division_id !== $shift->division_id) {
            return __('Barcode tidak sesuai dengan shift atau divisi Anda.');
        }

        $currentDay = Carbon::now($shift->division->timezone)->isoFormat('dddd');
        if (!in_array($currentDay, $shift->work_days)) {
            return __('Barcode hanya dapat digunakan pada hari kerja shift.');
        }

        $barcodeLocation = new LatLong($barcode->latLng['lat'], $barcode->latLng['lng']);
        $userLocation = new LatLong($this->currentLiveCoords[0], $this->currentLiveCoords[1]);

        $distance = $this->calculateDistance($userLocation, $barcodeLocation);
        if ($distance > $barcode->radius) {
            return __('Lokasi Anda di luar radius yang diizinkan.') . " ($distance m / Max: $barcode->radius m)";
        }

        $existingAttendance = Attendance::where('user_id', $user->id)
            ->whereDate('date', Carbon::today()->toDateString())
            ->where('barcode_id', $barcode->id)
            ->first();

        if (!$existingAttendance) {
            $attendance = $this->createAttendance($barcode);
            $this->successMsg = __('Absen Masuk Berhasil. Semangat bekerja!');
        } else {
            $timezone = $shift->division->timezone ?? 'Asia/Jakarta';
            $currentTime = Carbon::now($timezone);
            $shiftEndTime = Carbon::createFromTimeString($shift->end_time, $timezone);

            if ($currentTime->lessThan($shiftEndTime)) {
                return __('Absen keluar hanya dapat dilakukan setelah jam ') . $shiftEndTime->format('H:i:s');
            }

            $existingAttendance->update(['time_out' => now()->toTimeString()]);
            $this->successMsg = __('Absen Keluar Berhasil. Hati-hati di jalan.');
            $attendance = $existingAttendance;
        }

        if ($attendance) {
            $this->setAttendance($attendance->fresh());
            Attendance::clearUserAttendanceCache($user, Carbon::parse($attendance->date));

            if (!in_array($attendance->status, ['excused', 'sick', 'dinas', 'request'])) {
                $this->approvalStatusData = null;
            }

            return true;
        }

        return __('Terjadi kesalahan saat memproses absen.');
    }

    public function getShiftById($shiftId)
    {
        $shift = Shift::find($shiftId);

        if (!$shift) {
            \Log::error("Shift dengan ID $shiftId tidak ditemukan.");
            throw new \Exception('Shift tidak ditemukan.');
        }

        return $shift;
    }

    protected function checkWarnings($user)
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

        if ($totalWarnings === 3) {
            $this->warningMsg = [
                'type' => 'warning',
                'message' => __('Peringatan: Anda telah memiliki 3 keterlambatan atau Tidak Hadir!'),
            ];
        } elseif ($totalWarnings === 4) {
            $this->warningMsg = [
                'type' => 'danger',
                'message' => __('Peringatan Terakhir: Anda telah memiliki 4 keterlambatan atau Tidak Hadir. Sekali Lagi Anda Akan Terblokir'),
            ];
        } else {
            $this->warningMsg = [];
        }

        if ($totalWarnings >= 5 && !$user->is_blocked) {
            $user->update(['is_blocked' => true]);
        }
    }

    public function calculateDistance(LatLong $a, LatLong $b)
    {
        $distanceCalculator = new DistanceCalculator($a, $b);
        $distanceInMeter = floor($distanceCalculator->get()->asKilometres() * 1000);
        return $distanceInMeter;
    }

    /** @return Attendance */
    public function createAttendance(Barcode $barcode)
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();

        $userDivision = $user->division;
        $shifts = $userDivision?->shifts;

        if (!$shifts || !$shifts->contains('id', $this->shift_id)) {
            throw new \Exception('Shift Anda tidak sesuai dengan divisi.');
        }

        $shift = $shifts->firstWhere('id', $this->shift_id);

        $timezone = $userDivision->timezone;
        $now = Carbon::now($timezone);

        $status = $now->lt(Carbon::createFromTimeString($shift->start_time, $timezone)) ? 'present' : 'late';

        $attendanceData = [
            'user_id' => $user->id,
            'barcode_id' => $barcode->id,
            'date' => $now->format('Y-m-d'),
            'time_in' => $now->format('H:i:s'),
            'time_out' => null,
            'shift_id' => $shift->id,
            'latitude' => doubleval($this->currentLiveCoords[0]),
            'longitude' => doubleval($this->currentLiveCoords[1]),
            'status' => $status,
            'note' => null,
            'attachment' => null,
        ];

        if (in_array($status, ['excused', 'sick', 'dinas', 'request'])) {
            $attendanceData['approval_status'] = 'pending';
        }

        $attendance = Attendance::create($attendanceData);

        if ($attendance) {
            $lateCount = Attendance::where('user_id', $user->id)
                ->where('status', 'late')
                ->whereMonth('date', $now->month)
                ->count();

            $absentCount = Attendance::where('user_id', $user->id)
                ->where('status', 'absent')
                ->whereMonth('date', $now->month)
                ->count();

            $totalWarnings = $lateCount + $absentCount;

            if ($totalWarnings >= 5) {
                $user->update(['is_blocked' => true]);
            }
        }

        return $attendance;
    }

    protected function setAttendance(Attendance $attendance)
    {
        $this->attendance = $attendance;
        $this->shift_id = $attendance->shift_id;
        $this->isAbsence = !in_array($attendance->status, ['present', 'late', 'request']);
        $this->currentLiveCoords = [$attendance->latitude, $attendance->longitude];
    }

    public function requestPermission(string $note)
    {
        if (is_null($this->currentLiveCoords) || count($this->currentLiveCoords) < 2) {
            session()->flash('error', 'Lokasi Anda tidak dapat dideteksi. Mohon aktifkan GPS.');
            return;
        }

        if (is_null($this->shift_id)) {
            session()->flash('error', 'Pilih shift terlebih dahulu.');
            return;
        }

        $shift = Shift::find($this->shift_id);
        if (!$shift) {
            session()->flash('error', 'Shift yang dipilih tidak valid.');
            return;
        }

        $timezone = Auth::user()->division->timezone ?? 'Asia/Jakarta';
        $now = Carbon::now($timezone);

        $shiftStartTime = Carbon::createFromTimeString($shift->start_time, $timezone);
        $isLate = $now->greaterThan($shiftStartTime);

        Attendance::create([
            'user_id' => Auth::id(),
            'date' => $now->toDateString(),
            'time_in' => $now->toTimeString(),
            'status' => 'request',
            'is_late' => $isLate,
            'approval_status' => 'pending',
            'request_note' => $note,
            'latitude' => $this->currentLiveCoords[0],
            'longitude' => $this->currentLiveCoords[1],
            'shift_id' => $this->shift_id,
        ]);

        session()->flash('success', 'Permintaan absensi Anda telah dikirim untuk persetujuan.');
    }

    public function getAttendance()
    {
        if (is_null($this->attendance)) {
            return null;
        }
        return [
            'time_in' => $this->attendance?->time_in,
            'time_out' => $this->attendance?->time_out,
            'shift_id' => $this->attendance?->shift_id,
        ];
    }

    public function mount()
    {
        $user = Auth::user();
        $userDivision = $user->division;

        if ($userDivision) {
            $this->shifts = $userDivision->shifts;

            if ($this->shifts->isEmpty()) {
                throw new \Exception('Shift untuk divisi Anda tidak ditemukan.');
            }

            $this->shift_id = $this->shift_id ?? $this->shifts->first()?->id;
        } else {
            throw new \Exception('Divisi Anda tidak ditemukan.');
        }

        $this->rejectedDates = Attendance::withTrashed()
            ->where('user_id', $user->id)
            ->where('approval_status', 'rejected')
            ->pluck('date')
            ->toArray();

        $attendance = Attendance::where('user_id', $user->id)
            ->where('date', date('Y-m-d'))
            ->first();

        if ($attendance) {
            $this->setAttendance($attendance);

            if (in_array($attendance->status, ['excused', 'sick', 'dinas', 'request'])) {
                $this->approvalStatusData = [
                    'status' => $attendance->status,
                    'approval_status' => $attendance->approval_status,
                    'note' => $attendance->note,
                ];
            }
        } else {
            $closest = ExtendedCarbon::now()->closestFromDateArray($this->shifts->pluck('start_time')->toArray());
            $this->shift_id = $this->shifts->firstWhere('start_time', $closest?->format('H:i:s'))?->id ?? $this->shift_id;
            $this->approvalStatusData = null;
            $this->listeners = ['openRequestModal', 'closeRequestModal'];
        }

        $this->checkWarnings($user);
    }

    public function render()
    {
        return view('livewire.scan', [
            'warningMsg' => $this->warningMsg,
            'rejectedDates' => $this->rejectedDates,
        ]);
        if ($attendance?->status === 'request') {
            return [
                'time_in' => $attendance->time_in,
                'latitude' => $attendance->latitude,
                'longitude' => $attendance->longitude,
            ];
        }
    }
}

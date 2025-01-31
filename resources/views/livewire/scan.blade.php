<div class="w-full">
    @php
        use Illuminate\Support\Carbon;
    @endphp
    @pushOnce('styles')
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
            integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    @endpushOnce
    @pushOnce('scripts')
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
            integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
        <script>
            let currentMap = document.getElementById('currentMap');
            let map = document.getElementById('map');

            setTimeout(() => {
                toggleMap();
                toggleCurrentMap();
            }, 1000);

            function toggleCurrentMap() {
                const mapIsVisible = currentMap.style.display === "none";
                currentMap.style.display = mapIsVisible ? "block" : "none";
                document.querySelector('#toggleCurrentMap').innerHTML = mapIsVisible ?
                    `<x-heroicon-s-chevron-up class="mr-2 h-5 w-5" />` :
                    `<x-heroicon-s-chevron-down class="mr-2 h-5 w-5" />`;
            }

            function toggleMap() {
                const mapIsVisible = map.style.display === "none";
                map.style.display = mapIsVisible ? "block" : "none";
            }
        </script>
    @endpushOnce

    @if (!$isAbsence)
        <script src="{{ url('/assets/js/html5-qrcode.min.js') }}"></script>
    @endif

    @if (auth()->check() && (auth()->user()->is_blocked ?? false))
        <div class="text-red-500 font-bold text-center p-4 bg-red-100 rounded">
            Anda Telah Diblokir Dari Sistem Absensi. Hubungi Supervisor Anda Untuk Membuka Blokir.
        </div>
    @elseif (auth()->check())
        <div class="flex flex-col gap-4 md:flex-row">
            @if (!$isAbsence)
                <div class="flex flex-col gap-4">
                    <div>
                        <p class="text-sm font-medium text-gray-700 mb-2">Pilih Shift Anda :</p>
                        <x-select id="shift" class="mt-1 block w-full" wire:model="shift_id"
                            disabled="{{ !is_null($attendance) }}">
                            <option value="">{{ __('Select Shift') }}</option>
                            @foreach ($shifts as $shift)
                                <option value="{{ $shift->id }}" {{ $shift->id == $shift_id ? 'selected' : '' }}>
                                    {{ $shift->name . ' | ' . $shift->start_time . ' - ' . $shift->end_time }}
                                </option>
                            @endforeach
                        </x-select>
                        @error('shift_id')
                            <x-input-error for="shift" class="mt-2" message={{ $message }} />
                        @enderror
                    </div>
                    <div class="flex justify-center outline outline-gray-100 dark:outline-slate-700" wire:ignore>
                        <div id="scanner"
                            class="min-h-72 sm:min-h-96 w-72 rounded-sm outline-dashed outline-slate-500 sm:w-96">
                        </div>
                    </div>
                </div>
            @endif
            <div class="w-full">
                <h4 id="scanner-error" class="mb-3 text-lg font-semibold text-red-500 dark:text-red-400 sm:text-xl"
                    wire:ignore>
                </h4>
                <h4 id="scanner-result"
                    class="mb-3 hidden text-lg font-semibold text-green-500 dark:text-green-400 sm:text-xl">
                    {{ $successMsg }}
                </h4>
                <h4 id="latlng" class="mb-3 text-lg font-semibold text-gray-600 dark:text-gray-100 sm:text-xl">
                    {{ __('Date') . ': ' . now()->format('d/m/Y') }}<br>

                    @if (!is_null($currentLiveCoords))
                        <div class="flex justify-between">
                            <a href="{{ \App\Helpers::getGoogleMapsUrl($currentLiveCoords[0], $currentLiveCoords[1]) }}"
                                target="_blank" class="underline hover:text-blue-400">
                                {{ __('Your location') . ': ' . $currentLiveCoords[0] . ', ' . $currentLiveCoords[1] }}
                            </a>
                            <button class="text-nowrap h-6" onclick="toggleCurrentMap()" id="toggleCurrentMap">
                                <x-heroicon-s-chevron-down class="mr-2 h-5 w-5" />
                            </button>
                        </div>
                    @else
                        {{ __('Your location') . ': -, -' }}
                    @endif
                    <div class="my-6 h-72 w-full md:h-96" id="currentMap" wire:ignore></div>
                </h4>
                <div class="grid grid-cols-2 gap-3 md:grid-cols-1 lg:grid-cols-2 xl:grid-cols-3">
                    <div
                        class="{{ $attendance?->status === 'late' ? 'bg-red-200 dark:bg-red-900' : 'bg-blue-200 dark:bg-blue-900' }} 
        flex items-center justify-between rounded-md px-4 py-2 text-gray-800 dark:text-white dark:shadow-gray-700">
                        <div>
                            <h4 class="text-lg font-semibold md:text-xl">Absen Masuk</h4>
                            <div class="flex flex-col sm:flex-row">
                                <span>
                                    @if (is_null($attendance))
                                        Belum Absen
                                    @elseif ($attendance->status === 'request')
                                        Absen dari Jauh -
                                        Waktu:
                                        {{ $attendance->time_in ? Carbon::parse($attendance->time_in)->format('H:i:s') : 'N/A' }}
                                        @if ($attendance->is_late)
                                            - Terlambat: Ya
                                        @endif
                                    @elseif (in_array($attendance->status, ['present', 'late']))
                                        Hadir -
                                        Waktu:
                                        {{ $attendance->time_in ? Carbon::parse($attendance->time_in)->format('H:i:s') : 'N/A' }}
                                        @if ($attendance->status === 'late')
                                            - Terlambat: Ya
                                        @endif
                                    @elseif (in_array($attendance->status, ['excused', 'sick', 'dinas']))
                                        {{ $this->translateStatus($attendance->status) }}
                                    @endif
                                </span>
                            </div>
                        </div>
                        <x-heroicon-o-arrows-pointing-in class="h-5 w-5" />
                    </div>
                    <div
                        class="flex items-center justify-between rounded-md bg-orange-200 px-4 py-2 text-gray-800 dark:bg-orange-900 dark:text-white dark:shadow-gray-700">
                        <div>
                            <h4 class="text-lg font-semibold md:text-xl">Absen Keluar</h4>
                            <div class="flex flex-col sm:flex-row">
                                <span>
                                    @if (is_null($attendance))
                                        Belum Absen
                                    @elseif (in_array($attendance->status, ['excused', 'sick', 'dinas']))
                                        {{ $this->translateStatus($attendance->status) }}
                                    @elseif (in_array($attendance->status, ['present', 'late']))
                                        Hadir -
                                        Waktu :
                                        {{ $attendance->time_out ? Carbon::parse($attendance->time_out)->format('H:i:s') : 'Belum Absen' }}
                                    @else
                                        Belum Absen
                                    @endif
                                </span>
                            </div>
                        </div>
                        <x-heroicon-o-arrows-pointing-out class="h-5 w-5" />
                    </div>
                    <button
                        class="col-span-2 flex items-center justify-between rounded-md bg-purple-200 px-4 py-2 text-gray-800 dark:bg-purple-900 dark:text-white dark:shadow-gray-700 md:col-span-1 lg:col-span-2 xl:col-span-1"
                        {{ is_null($attendance?->latitude) || is_null($attendance?->longitude) ? 'disabled' : 'onclick=toggleMap()' }}
                        id="toggleMap">
                        <div>
                            <h4 class="text-lg font-semibold md:text-xl">Koordinat Absen</h4>
                            @if (is_null($attendance?->latitude) || is_null($attendance?->longitude))
                                Belum Absen
                            @else
                                <a href="{{ \App\Helpers::getGoogleMapsUrl($attendance->latitude, $attendance->longitude) }}"
                                    target="_blank" class="underline hover:text-blue-400">
                                    {{ $attendance->latitude }}, {{ $attendance->longitude }}
                                </a>
                            @endif
                        </div>
                        <x-heroicon-o-map-pin class="h-6 w-6" />
                    </button>
                </div>

                <div class="my-6 h-52 w-full md:h-64" id="map" wire:ignore></div>

                <hr class="my-4">

                <div class="grid grid-cols-2 gap-3 md:grid-cols-2 lg:grid-cols-3" wire:ignore>
                    <a href="{{ route('apply-leave') }}">
                        <div
                            class="flex flex-col-reverse items-center justify-center gap-2 rounded-md bg-amber-500 px-4 py-2 text-center font-medium text-white shadow-md shadow-gray-400 transition duration-100 hover:bg-amber-600 dark:shadow-gray-700 md:flex-row md:gap-3">
                            Ajukan Izin
                            <x-heroicon-o-envelope-open class="h-6 w-6 text-white" />
                        </div>
                    </a>
                    <button
                        class="bg-green-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-green-600 transition duration-200 flex items-center gap-2 items-center justify-center"
                        wire:click="openModal">
                        Ajukan Absensi
                        <x-heroicon-o-document-text class="h-6 w-6 text-white" />
                    </button>
                    <a href="{{ route('attendance-history') }}">
                        <div
                            class="flex flex-col-reverse items-center justify-center gap-2 rounded-md bg-blue-500 px-4 py-2 text-center font-medium text-white shadow-md shadow-gray-400 hover:bg-blue-600 dark:shadow-gray-700 md:flex-row md:gap-3">
                            Riwayat Absen
                            <x-heroicon-o-clock class="h-6 w-6 text-white" />
                        </div>
                    </a>
                </div>
                @if (
                    $attendance &&
                        $attendance->status === 'request' &&
                        $attendance->approval_status === 'approved' &&
                        $attendance->time_in)
                    <div class="mt-6">
                        <button
                            class="flex items-center justify-center gap-2 px-4 py-2 w-full md:w-auto text-white bg-green-500 rounded-md shadow-md hover:bg-green-600 transition"
                            wire:click="confirmCheckOut">
                            Absen Keluar
                            <x-heroicon-o-check-circle class="h-6 w-6 text-white" />
                        </button>
                        <p class="mt-3 text-sm text-gray-600 text-center">
                            <span class="font-semibold text-gray-800">Khusus Absen Dari Jauh.</span> Pastikan Anda
                            Mengklik Tombol Ini Untuk Mencatat Absen Keluar. Harap Sesuaikan Dengan Waktu Keluar Shift
                            Anda.
                        </p>
                    </div>
                @endif
                @if (!empty($warningMsg))
                    <div class="mt-5"
                        style="
        background-color: {{ $warningMsg['type'] === 'warning' ? '#FEF3C7' : '#FEE2E2' }};
        color: {{ $warningMsg['type'] === 'warning' ? '#92400E' : '#B91C1C' }};
        border: 1px solid {{ $warningMsg['type'] === 'warning' ? '#FACC15' : '#FCA5A5' }};
        padding: 1rem;
        font-weight: bold;
        text-align: center;
        border-radius: 0.5rem;
        box-shadow: 0px 4px 6px -1px rgba(0, 0, 0, 0.1);
    ">
                        {{ $warningMsg['message'] }}
                    </div>
                @endif
                @if (!empty($approvalStatusData))
                    <div class="mt-5 p-4 rounded text-center"
                        style="
        background-color: {{ $approvalStatusData['approval_status'] === 'approved' ? '#D1FAE5' : ($approvalStatusData['approval_status'] === 'pending' ? '#FEF3C7' : '#FEE2E2') }};
        color: {{ $approvalStatusData['approval_status'] === 'approved' ? '#065F46' : ($approvalStatusData['approval_status'] === 'pending' ? '#92400E' : '#B91C1C') }};
        border: 1px solid {{ $approvalStatusData['approval_status'] === 'approved' ? '#10B981' : ($approvalStatusData['approval_status'] === 'pending' ? '#FBBF24' : '#FCA5A5') }};
    ">
                        @if ($approvalStatusData['approval_status'] === 'approved')
                            <p><strong>Status Verifikasi:</strong> Pengajuan Anda Telah <span
                                    class="font-bold">Disetujui</span>.</p>
                        @elseif ($approvalStatusData['approval_status'] === 'pending')
                            <p><strong>Status Verifikasi:</strong> Pengajuan Anda Sedang Menunggu <span
                                    class="font-bold">Persetujuan Atasan</span>.</p>
                        @endif
                    </div>
                @endif
                @if (!empty($rejectedDates))
                    @foreach ($rejectedDates as $rejectedDate)
                        <div class="mt-5 text-red-500 font-bold text-center p-4 bg-red-100 rounded">
                            Izin Anda pada tanggal {{ Carbon::parse($rejectedDate)->format('d/m/Y') }} telah
                            <span class="font-bold">Ditolak</span>.
                        </div>
                    @endforeach
                @endif
            </div>
        </div>
    @else
        <div class="text-red-500 font-bold text-center p-4 bg-red-100 rounded">
            Anda harus login untuk mengakses halaman ini.
        </div>
    @endif
    @if ($showModal)
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-gray-900 bg-opacity-75 backdrop-blur-sm p-6">
            <div
                class="bg-white border-2 border-gray-300 rounded-lg shadow-xl p-6 w-11/12 max-w-md sm:max-w-lg mx-auto relative max-h-[90vh] overflow-auto">
                <h2 class="text-2xl font-semibold mb-6 text-gray-800 text-center">Ajukan Absensi</h2>
                @if ($cannotSubmit)
                    <div class="mb-4 p-4 bg-yellow-100 text-yellow-700 rounded-md shadow">
                        {{ $errorMsg }}
                    </div>
                    <div class="flex justify-end mt-4">
                        <button class="px-4 py-2 rounded-lg bg-gray-100 text-gray-700 hover:bg-gray-200 transition"
                            wire:click="closeModal">
                            OK
                        </button>
                    </div>
                @else
                    <form wire:submit.prevent="submitRequest">
                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Nama</label>
                            <input type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100"
                                value="{{ auth()->user()->name }}" disabled>
                        </div>
                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal</label>
                            <input type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100"
                                value="{{ now()->format('d/m/Y') }}" disabled>
                        </div>
                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Shift</label>
                            <select
                                class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-green-500 focus:border-green-500"
                                wire:model="shift_id">
                                <option value="">{{ __('Pilih Shift') }}</option>
                                @foreach ($shifts as $shift)
                                    <option value="{{ $shift->id }}">{{ $shift->name }}
                                        ({{ $shift->start_time }} -
                                        {{ $shift->end_time }})
                                    </option>
                                @endforeach
                            </select>
                            @error('shift_id')
                                <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                            @enderror
                        </div>
                        <div class="mb-6">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Catatan</label>
                            <p class="text-sm text-red-600 mt-2">
                                Silakan Jelaskan Alasan Anda Mengajukan Absensi Dari Jarak Jauh. Permohonan Anda Akan
                                Ditinjau Dan Harus Mendapat Persetujuan Dari Supervisor.
                            </p>
                            <textarea class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-green-500 focus:border-green-500"
                                rows="3" wire:model.defer="requestNote"></textarea>
                            @error('requestNote')
                                <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                            @enderror
                        </div>
                        <div class="flex justify-end gap-4 mt-2">
                            <button type="button"
                                class="px-4 py-2 rounded-lg border border-gray-300 bg-gray-100 text-gray-700 hover:bg-gray-200 transition"
                                wire:click="closeModal">
                                Batal
                            </button>
                            <button type="submit"
                                class="px-4 py-2 rounded-lg bg-green-500 text-white hover:bg-green-600 transition">
                                Ajukan
                            </button>
                        </div>
                    </form>
                @endif
                <button type="button" class="absolute top-4 right-4 text-gray-600 hover:text-gray-900"
                    wire:click="closeModal">
                    <x-heroicon-o-exclamation-circle class="h-6 w-6" />
                </button>
            </div>
        </div>
    @endif

    @if ($showCheckOutModal)
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-gray-900 bg-opacity-75 backdrop-blur-sm">
            <div
                class="bg-white border-2 border-gray-300 rounded-lg shadow-xl p-6 w-11/12 max-w-md sm:max-w-lg mx-4 relative">
                <h2 class="text-2xl font-semibold mb-6 text-gray-800 text-center">Konfirmasi Absen Keluar</h2>

                @if (session()->has('error'))
                    <p class="text-red-500 text-center mb-4">{{ session('error') }}</p>
                    <div class="flex justify-center mt-4">
                        <button type="button"
                            class="px-4 py-2 rounded-lg bg-gray-300 text-gray-800 hover:bg-gray-400 transition"
                            wire:click="cancelCheckOut">
                            OK
                        </button>
                    </div>
                @else
                    <p class="text-center mb-4">Apakah Anda yakin ingin absen keluar?</p>
                    <div class="flex justify-end gap-4 mt-2">
                        <button type="button"
                            class="px-4 py-2 rounded-lg border border-gray-300 bg-gray-100 text-gray-700 hover:bg-gray-200 transition"
                            wire:click="cancelCheckOut">
                            Tidak
                        </button>
                        <button type="button"
                            class="px-4 py-2 rounded-lg bg-green-500 text-white hover:bg-green-600 transition"
                            wire:click="checkOut">
                            Ya
                        </button>
                    </div>
                @endif
                <button type="button" class="absolute top-4 right-4 text-gray-600 hover:text-gray-900"
                    wire:click="cancelCheckOut">
                </button>
            </div>
        </div>
    @endif
</div>

@script
    <script>
        const errorMsg = document.querySelector('#scanner-error');
        getLocation();

        async function getLocation() {
            if (navigator.geolocation) {
                const map = L.map('currentMap');
                L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    maxZoom: 21,
                }).addTo(map);
                navigator.geolocation.watchPosition((position) => {
                    console.log(position);
                    $wire.$set('currentLiveCoords', [position.coords.latitude, position.coords.longitude]);
                    map.setView([
                        Number(position.coords.latitude),
                        Number(position.coords.longitude),
                    ], 13);
                    L.marker([position.coords.latitude, position.coords.longitude]).addTo(map);
                }, (err) => {
                    console.error(`ERROR(${err.code}): ${err.message}`);
                    alert('{{ __('Please enable your location') }}');
                });
            } else {
                document.querySelector('#scanner-error').innerHTML = "Gagal mendeteksi lokasi";
            }
        }

        if (!$wire.isAbsence) {
            const scanner = new Html5Qrcode('scanner');

            const config = {
                formatsToSupport: [Html5QrcodeSupportedFormats.QR_CODE],
                fps: 15,
                aspectRatio: 1,
                qrbox: {
                    width: 280,
                    height: 280
                },
                supportedScanTypes: [Html5QrcodeScanType.SCAN_TYPE_CAMERA]
            };

            async function startScanning() {
                if (scanner.getState() === Html5QrcodeScannerState.PAUSED) {
                    return scanner.resume();
                }
                await scanner.start({
                        facingMode: "environment"
                    },
                    config,
                    onScanSuccess,
                );
            }

            async function onScanSuccess(decodedText, decodedResult) {
                console.log(`Code matched = ${decodedText}`, decodedResult);

                if (scanner.getState() === Html5QrcodeScannerState.SCANNING) {
                    scanner.pause(true);
                }

                if (!(await checkTime())) {
                    await startScanning();
                    return;
                }

                const result = await $wire.scan(decodedText);

                if (result === true) {
                    return onAttendanceSuccess();
                } else if (typeof result === 'string') {
                    errorMsg.innerHTML = result;
                }

                setTimeout(async () => {
                    await startScanning();
                }, 500);
            }

            async function checkTime() {
                const attendance = await $wire.getAttendance();

                if (attendance) {
                    if (!attendance.shift_id) {
                        console.error("Shift ID tidak ditemukan dalam data attendance.");
                        alert("Terjadi kesalahan: Shift ID tidak valid.");
                        return false;
                    }

                    const currentTime = new Date().valueOf();
                    const shiftEndTime = new Date();
                    const shift = await $wire.getShiftById(attendance.shift_id);

                    if (!shift) {
                        console.error("Shift tidak ditemukan.");
                        alert("Terjadi kesalahan: Shift tidak ditemukan.");
                        return false;
                    }

                    // Parse waktu `end_time` shift
                    const [hours, minutes, seconds] = shift.end_time.split(':').map(Number);
                    shiftEndTime.setHours(hours, minutes, seconds);

                    if (currentTime < shiftEndTime.getTime()) {
                        alert(
                            `Absen Keluar Hanya Dapat Dilakukan Setelah Jam ${shift.end_time}. Saat Ini Belum Waktunya Absen Keluar.`
                        );
                        return false;
                    }
                }

                return true;
            }


            function onAttendanceSuccess() {
                scanner.stop();
                errorMsg.innerHTML = '';
                document.querySelector('#scanner-result').classList.remove('hidden');
            }

            const observer = new MutationObserver((mutationList, observer) => {
                const classes = ['text-white', 'bg-blue-500', 'dark:bg-blue-400', 'rounded-md', 'px-3', 'py-1'];
                for (const mutation of mutationList) {
                    if (mutation.type === 'childList') {
                        const startBtn = document.querySelector('#html5-qrcode-button-camera-start');
                        const stopBtn = document.querySelector('#html5-qrcode-button-camera-stop');
                        const fileBtn = document.querySelector('#html5-qrcode-button-file-selection');
                        const permissionBtn = document.querySelector('#html5-qrcode-button-camera-permission');

                        if (startBtn) {
                            startBtn.classList.add(...classes);
                            stopBtn.classList.add(...classes, 'bg-red-500');
                            fileBtn.classList.add(...classes);
                        }

                        if (permissionBtn)
                            permissionBtn.classList.add(...classes);
                    }
                }
            });

            observer.observe(document.querySelector('#scanner'), {
                childList: true,
                subtree: true,
            });

            const shift = document.querySelector('#shift');
            const msg = 'Pilih shift terlebih dahulu';
            let isRendered = false;
            setTimeout(() => {
                if (!shift.value) {
                    errorMsg.innerHTML = msg;
                } else {
                    startScanning();
                    isRendered = true;
                }
            }, 1000);
            shift.addEventListener('change', () => {
                if (!isRendered) {
                    startScanning();
                    isRendered = true;
                    errorMsg.innerHTML = '';
                }
                if (!shift.value) {
                    scanner.pause(true);
                    errorMsg.innerHTML = msg;
                } else if (scanner.getState() === Html5QrcodeScannerState.PAUSED) {
                    scanner.resume();
                    errorMsg.innerHTML = '';
                }
            });

            const map = L.map('map').setView([
                Number({{ $attendance?->latitude }}),
                Number({{ $attendance?->longitude }}),
            ], 13);
            L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 21,
            }).addTo(map);
            L.marker([
                Number({{ $attendance?->latitude }}),
                Number({{ $attendance?->longitude }}),
            ]).addTo(map);
        }
    </script>
@endscript

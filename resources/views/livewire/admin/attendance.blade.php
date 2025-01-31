@php
    use Illuminate\Support\Carbon;
    $m = Carbon::parse($month);
    $showUserDetail = !$month || $week || $date; // is week or day filter
    $isPerDayFilter = isset($date);
@endphp
<div>
    @pushOnce('styles')
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
            integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    @endpushOnce
    <h3 class="col-span-2 mb-4 text-lg font-semibold leading-tight text-gray-800 dark:text-gray-200">
        Data Absensi
    </h3>
    <div class="mb-1 text-sm dark:text-white">Filter:</div>
    <div class="mb-4 grid grid-cols-2 flex-wrap items-center gap-5 md:gap-8 lg:flex">
        <div class="flex flex-col gap-3 lg:flex-row lg:items-center">
            <x-label for="month_filter" value="Per Bulan"></x-label>
            <x-input type="month" name="month_filter" id="month_filter" wire:model.live="month" />
        </div>
        <div class="flex flex-col gap-3 lg:flex-row lg:items-center">
            <x-label for="week_filter" value="Per Minggu"></x-label>
            <x-input type="week" name="week_filter" id="week_filter" wire:model.live="week" />
        </div>
        <div class="col-span-2 flex flex-col gap-3 lg:flex-row lg:items-center">
            <x-label for="day_filter" value="Per Hari"></x-label>
            <x-input type="date" name="day_filter" id="day_filter" wire:model.live="date" />
        </div>
        <x-select id="division" wire:model.live="division">
    <option value="">{{ __('Select Division') }}</option>
    @foreach ($availableDivisions as $_division)
        <option value="{{ $_division->id }}" {{ $_division->id == $division ? 'selected' : '' }}>
            {{ $_division->name }}
        </option>
    @endforeach
</x-select>
        <x-select id="jobTitle" wire:model.live="jobTitle">
            <option value="">{{ __('Select Job Title') }}</option>
            @foreach (App\Models\JobTitle::all() as $_jobTitle)
                <option value="{{ $_jobTitle->id }}" {{ $_jobTitle->id == $jobTitle ? 'selected' : '' }}>
                    {{ $_jobTitle->name }}
                </option>
            @endforeach
        </x-select>
        <div class="col-span-2 flex items-center gap-2 lg:w-96">
            <x-input type="text" class="w-full" name="search" id="seacrh" wire:model="search"
                placeholder="{{ __('Search') }}" />
            <x-button type="button" wire:click="$refresh" wire:loading.attr="disabled">{{ __('Search') }}</x-button>
            @if ($search)
                <x-secondary-button type="button" wire:click="$set('search', '')" wire:loading.attr="disabled">
                    {{ __('Reset') }}
                </x-secondary-button>
            @endif
        </div>
        <div class="lg:hidden"></div>
        <x-secondary-button
            href="{{ route('admin.attendances.report', ['month' => $month, 'week' => $week, 'date' => $date, 'division' => $division, 'jobTitle' => $jobTitle]) }}"
            class="flex justify-center gap-2">
            Cetak Laporan
            <x-heroicon-o-printer class="h-5 w-5" />
        </x-secondary-button>
    </div>
    <div class="overflow-x-scroll">
        <table class="w-full divide-y divide-gray-200 dark:divide-gray-700">
            <thead class="bg-gray-50 dark:bg-gray-900">
                <tr>
                    <th scope="col" class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                        {{ $showUserDetail ? __('Name') : __('Name') . '/' . __('Date') }}
                    </th>
                    @if ($showUserDetail)
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('NIP') }}
                        </th>
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('Division') }}
                        </th>
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('Job Title') }}
                        </th>
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('Approval Status') }}
                        </th>
                        @if ($isPerDayFilter)
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                                {{ __('Shift') }}
                            </th>
                        @endif
                    @endif
                    @foreach ($dates as $date)
                        @php
                            if (!$isPerDayFilter && $date->isSunday()) {
                                $textClass = 'text-red-500 dark:text-red-300';
                            } elseif (!$isPerDayFilter && $date->isFriday()) {
                                $textClass = 'text-green-500 dark:text-green-300';
                            } else {
                                $textClass = 'text-gray-500 dark:text-gray-300';
                            }
                        @endphp
                        <th scope="col"
                            class="{{ $textClass }} text-nowrap border border-gray-300 px-1 py-3 text-center text-xs font-medium dark:border-gray-600">
                            @if ($isPerDayFilter)
                                Status
                            @else
                                {{ $date->format('d/m') }}
                            @endif
                        </th>
                    @endforeach
                    @if ($isPerDayFilter)
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('Time In') }}
                        </th>
                        <th scope="col"
                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300">
                            {{ __('Time Out') }}
                        </th>
                    @endif
                    @if (!$isPerDayFilter)
                        @foreach (['H', 'T', 'I', 'S', 'A', 'D'] as $_st)
                            <th scope="col"
                                class="text-nowrap border border-gray-300 px-1 py-3 text-center text-xs font-medium text-gray-500 dark:border-gray-600 dark:text-gray-300">
                                {{ $_st }}
                            </th>
                        @endforeach
                    @endif
                    @if ($isPerDayFilter)
                        <th scope="col" class="relative">
                            <span class="sr-only">Actions</span>
                        </th>
                    @endif
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 bg-white dark:divide-gray-700 dark:bg-gray-800">
                @php
                    $class = 'cursor-pointer px-4 py-3 text-sm font-medium text-gray-900 dark:text-white';
                @endphp
                @foreach ($employees as $employee)
                    @php
                        $attendances = $employee->attendances;
                    @endphp
                    <tr wire:key="{{ $employee->id }}" class="group">
                        <td
                            class="{{ $class }} text-nowrap group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                            {{ $employee->name }}
                        </td>
                        @if ($showUserDetail)
                            <td class="{{ $class }} group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                {{ $employee->nip }}
                            </td>
                            <td
                                class="{{ $class }} text-nowrap group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                {{ $employee->division?->name ?? '-' }}
                            </td>
                            <td
                                class="{{ $class }} text-nowrap group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                {{ $employee->jobTitle?->name ?? '-' }}
                            </td>
                            <td class="text-center align-middle font-medium text-gray-900 dark:text-white">
    @if (!empty($attendances) && isset($attendances->first()['approval_status']))
        @switch($attendances->first()['approval_status'])
            @case('pending')
                <x-warning-button wire:click="openApproveModal({{ $attendances->first()['id'] }}, '{{ $attendances->first()['status'] }}')">
                    Pending
                </x-warning-button>
            @break
            @case('approved')
                <x-success-button>
                    Approved
                </x-success-button>
            @break
            @case('rejected')
                <x-danger-button>
                    Rejected
                </x-danger-button>
            @break
            @default
                <x-secondary-button>
                    N/A
                </x-secondary-button>
        @endswitch
    @else
        <x-secondary-button>
            N/A
        </x-secondary-button>
    @endif
</td>
                            @if ($isPerDayFilter)
                                @php
                                    $attendance = $employee->attendances->isEmpty()
                                        ? null
                                        : $employee->attendances->first();
                                    $timeIn = $attendance ? $attendance['time_in'] : null;
                                    $timeOut = $attendance ? $attendance['time_out'] : null;
                                @endphp
                                <td
                                    class="{{ $class }} text-nowrap group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                    {{ $attendance['shift'] ?? '-' }}
                                </td>
                            @endif
                        @endif
                        {{-- Absensi --}}
                        @php
                            $presentCount = 0;
                            $lateCount = 0;
                            $excusedCount = 0;
                            $sickCount = 0;
                            $absentCount = 0;
                            $dinasCount = 0;
                        @endphp
                        @foreach ($dates as $date)
                            @php
                                $isWeekend = $date->isWeekend();
                                $attendance = $attendances->firstWhere(
                                    fn($v, $k) => $v['date'] === $date->format('Y-m-d'),
                                );
                                $status = ($attendance ?? [
                                    'status' => $isWeekend || !$date->isPast() ? '-' : 'absent',
                                ])['status'];
                                switch ($status) {
                                    case 'present':
                                        $shortStatus = 'H';
                                        $bgColor =
                                            'bg-green-200 dark:bg-green-800 hover:bg-green-300 dark:hover:bg-green-700 border border-green-300 dark:border-green-600';
                                        $presentCount++;
                                        break;
                                    case 'late':
                                        $shortStatus = 'T';
                                        $bgColor =
                                            'bg-amber-200 dark:bg-amber-800 hover:bg-amber-300 dark:hover:bg-amber-700 border border-amber-300 dark:border-amber-600';
                                        $lateCount++;
                                        break;
                                    case 'excused':
                                        $shortStatus = 'I';
                                        $bgColor =
                                            'bg-blue-200 dark:bg-blue-800 hover:bg-blue-300 dark:hover:bg-blue-700 border border-blue-300 dark:border-blue-600';
                                        $excusedCount++;
                                        break;
                                    case 'sick':
                                        $shortStatus = 'S';
                                        $bgColor =
                                            'hover:bg-gray-100 dark:hover:bg-gray-700 border border-gray-300 dark:border-gray-600';
                                        $sickCount++;
                                        break;
                                    case 'absent':
                                        $shortStatus = 'A';
                                        $bgColor =
                                            'bg-red-200 dark:bg-red-800 hover:bg-red-300 dark:hover:bg-red-700 border border-red-300 dark:border-red-600';
                                        $absentCount++;
                                        break;
                                    case 'dinas': 
                                        $shortStatus = 'D';
                                        $bgColor =
                                            'bg-purple-200 dark:bg-purple-800 hover:bg-purple-300 dark:hover:bg-purple-700 border border-purple-300 dark:border-purple-600';
                                        $dinasCount++;
                                        break;
                                    default:
                                        $shortStatus = '-';
                                        $bgColor =
                                            'hover:bg-gray-100 dark:hover:bg-gray-700 border border-gray-300 dark:border-gray-600';
                                        break;
                                }
                            @endphp
                            @if (!$isPerDayFilter && $attendance && ($attendance['attachment'] || $attendance['note'] || $attendance['coordinates']))
                                <td
                                    class="{{ $bgColor }} cursor-pointer text-center text-sm font-medium text-gray-900 dark:text-white">
                                    <button class="w-full px-1 py-3" wire:click="show({{ $attendance['id'] }})"
                                        onclick="setLocation({{ $attendance['lat'] ?? 0 }}, {{ $attendance['lng'] ?? 0 }})">
                                        {{ $isPerDayFilter ? __($status) : $shortStatus }}
                                    </button>
                                </td>
                            @else
                                <td
                                    class="{{ $bgColor }} text-nowrap cursor-pointer px-1 py-3 text-center text-sm font-medium text-gray-900 dark:text-white">
                                    {{ $isPerDayFilter ? __($status) : $shortStatus }}
                                </td>
                            @endif
                        @endforeach
                        @if ($isPerDayFilter)
                            <td class="{{ $class }} group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                {{ $timeIn ?? '-' }}
                            </td>
                            <td class="{{ $class }} group-hover:bg-gray-100 dark:group-hover:bg-gray-700">
                                {{ $timeOut ?? '-' }}
                            </td>
                        @endif
                        @if (!$isPerDayFilter)
                            @foreach ([$presentCount, $lateCount, $excusedCount, $sickCount, $absentCount, $dinasCount] as $statusCount)
                                <td
                                    class="cursor-pointer border border-gray-300 px-1 py-3 text-center text-sm font-medium text-gray-900 group-hover:bg-gray-100 dark:border-gray-600 dark:text-white dark:group-hover:bg-gray-700">
                                    {{ $statusCount }}
                                </td>
                            @endforeach
                        @endif
                        @if ($isPerDayFilter)
                            @php
                                $attendance = $employee->attendances->isEmpty()
                                    ? null
                                    : $employee->attendances->first();
                            @endphp
                            <td
                                class="cursor-pointer text-center text-sm font-medium text-gray-900 group-hover:bg-gray-100 dark:text-white dark:group-hover:bg-gray-700">
                                <div class="flex items-center justify-center gap-3">
                                    @if ($attendance && ($attendance['attachment'] || $attendance['note'] || $attendance['coordinates']))
                                        <x-button type="button" wire:click="show({{ $attendance['id'] }})"
                                            onclick="setLocation({{ $attendance['lat'] ?? 0 }}, {{ $attendance['lng'] ?? 0 }})">
                                            {{ __('Detail') }}
                                        </x-button>
                                    @else
                                        -
                                    @endif
                                </div>
                            </td>
                        @endif
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    @if ($employees->isEmpty())
        <div class="my-2 text-center text-sm font-medium text-gray-900 dark:text-gray-100">
            Tidak ada data
        </div>
    @endif
    <div class="mt-3">
        {{ $employees->links() }}
    </div>

    <div>
        <x-modal wire:model="showApproveModal">
            <div class="p-6">
                <h2 class="text-lg font-bold text-gray-800 dark:text-white">
                    {{ $approvalMessage }}
                </h2>
                <div class="flex justify-end mt-4 gap-4">
    @if (str_contains($approvalMessage, 'Tidak Memiliki Otoritas'))
        <x-secondary-button wire:click="closeModal" wire:loading.attr="disabled">
           Ya
        </x-secondary-button>
    @else
        {{-- Jika pengguna memiliki wewenang untuk menyetujui/menolak --}}
        <x-secondary-button wire:click="reject" wire:loading.attr="disabled">
            Tidak
        </x-secondary-button>
        <x-button wire:click="approveAttendance" wire:loading.attr="disabled">
            Ya
        </x-button>
    @endif
</div>
            </div>
        </x-modal>
    </div>

    <x-attendance-detail-modal :current-attendance="$currentAttendance" />
    @stack('attendance-detail-scripts')
</div>

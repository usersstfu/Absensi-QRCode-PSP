<x-app-layout>
  @pushOnce('styles')
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
  @endpushOnce

  <x-slot name="header">
    <h2 class="text-xl font-semibold leading-tight text-gray-800 dark:text-gray-200">
      {{ __('New Barcode') }}
    </h2>
  </x-slot>

  <div class="py-12">
    <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
      <div class="overflow-hidden bg-white shadow-xl dark:bg-gray-800 sm:rounded-lg">
        <div class="p-6 lg:p-8">
          <form action="{{ route('admin.barcodes.store') }}" method="post">
            @csrf

            <div class="flex flex-col gap-4 md:flex-row md:items-start md:gap-3">
              <div class="w-full">
                <x-label for="name">Nama Barcode</x-label>
                <x-input name="name" id="name" class="mt-1 block w-full" type="text" :value="old('name')"
                  placeholder="Barcode Baru" />
                @error('name')
                  <x-input-error for="name" class="mt-2" message="{{ $message }}" />
                @enderror
              </div>
              <div class="w-full">
                <x-label for="value">Value Barcode</x-label>
                @livewire('admin.barcode-value-input-component')
              </div>
            </div>

            <div class="mt-4 flex gap-3">
              <div class="w-full">
                <x-label for="radius">Radius Valid Absen</x-label>
                <x-input name="radius" id="radius" class="mt-1 block w-full" type="number" :value="old('radius')"
                  placeholder="50 (meter)" />
                @error('radius')
                  <x-input-error for="radius" class="mt-2" message="{{ $message }}" />
                @enderror
              </div>
              <div class="w-full">
              </div>
            </div>

            <div class="mt-5">
              <h3 class="text-lg font-semibold dark:text-gray-400">{{ __('Coordinate') }}</h3>

              <div class="grid grid-cols-1 gap-3 md:grid-cols-2">
                <div class="w-full">
                  <x-label for="lat">Latitude</x-label>
                  <x-input name="lat" id="lat" class="mt-1 block w-full" type="text" :value="old('lat')"
                    placeholder="cth: -6.12345" />
                  @error('lat')
                    <x-input-error for="lat" class="mt-2" message="{{ $message }}" />
                  @enderror
                </div>
                <div class="w-full">
                  <x-label for="lng">Longitude</x-label>
                  <x-input name="lng" id="lng" class="mt-1 block w-full" type="text" :value="old('lng')"
                    placeholder="cth: 6.12345" />
                  @error('lng')
                    <x-input-error for="lng" class="mt-2" message="{{ $message }}" />
                  @enderror
                </div>
              </div>
              
              <div class="mt-4">
    <x-label for="division_id">Divisi</x-label>
    <select name="division_id" id="division_id" class="form-select mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50" onchange="loadShifts(this.value)">
        <option value="" disabled selected>Pilih Divisi</option>
        @foreach ($divisions as $division)
            <option value="{{ $division->id }}" {{ old('division_id', $barcode->division_id ?? '') == $division->id ? 'selected' : '' }}>
                {{ $division->name }}
            </option>
        @endforeach
    </select>
    @error('division_id')
        <x-input-error for="division_id" class="mt-2" message="{{ $message }}" />
    @enderror
</div>

<div class="mt-4">
    <x-label for="shift_id">Shift</x-label>
    <select id="shift_id" name="shift_id" class="form-select mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50">
        <option value="">Pilih Shift</option>
    </select>
    @error('shift_id')
        <x-input-error for="shift_id" class="mt-2" message="{{ $message }}" />
    @enderror
</div>

              <div class="flex flex-col items-start gap-3 md:flex-row">
                <x-button type="button" onclick="toggleMap()" class="text-nowrap mt-4">
                  <x-heroicon-s-map-pin class="mr-2 h-5 w-5" /> Tampilkan/Sembunyikan Peta
                </x-button>

                <div id="map" class="my-6 h-72 w-full md:h-96"></div>
              </div>

              <div class="mb-3 mt-4 flex items-center justify-end">
                <x-button class="ms-4">
                  {{ __('Save') }}
                </x-button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  @pushOnce('scripts')
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
      integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script>
      window.addEventListener("load", function() {
        window.initializeMap({
          onUpdate: (lat, lng) => {
            document.getElementById('lat').value = lat;
            document.getElementById('lng').value = lng;
          },
          location: @if (old('lat') && old('lng'))
            [Number({{ old('lat') }}), Number({{ old('lng') }})]
          @else
            undefined
          @endif
        });
      });

      let map = document.getElementById('map');

      function toggleMap() {
        map.style.display = map.style.display === "none" ? "block" : "none";
      }
    </script>
    <script>
    function loadShifts(divisionId) {
    const shiftSelect = document.getElementById('shift_id');
    shiftSelect.innerHTML = '<option value="">Memuat...</option>';
    shiftSelect.disabled = true;

    if (!divisionId) {
        shiftSelect.innerHTML = '<option value="">Pilih Divisi Terlebih Dahulu</option>';
        return;
    }

    fetch(`/admin/barcodes/get-shifts?division_id=${divisionId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error fetching shifts');
            }
            return response.json();
        })
        .then(data => {
            shiftSelect.innerHTML = '<option value="">Pilih Shift</option>';
            if (data.length === 0) {
                shiftSelect.innerHTML = '<option value="">Tidak Ada Shift</option>';
                return;
            }
            data.forEach(shift => {
                const option = document.createElement('option');
                option.value = shift.id;
                option.text = `${shift.name} (${shift.work_days.join(', ')})`;
                shiftSelect.appendChild(option);
            });
            shiftSelect.disabled = false;
        })
        .catch(error => {
            console.error('Error fetching shifts:', error);
            shiftSelect.innerHTML = '<option value="">Error Memuat Shift</option>';
        });
}
</script>
  @endPushOnce
</x-app-layout>

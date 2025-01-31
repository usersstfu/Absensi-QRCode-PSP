<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Holiday;
use Illuminate\Support\Facades\Http;

class FetchHolidays extends Command
{
    protected $signature = 'fetch:holidays';
    protected $description = 'Fetch public holidays from DayOff API and store them in the database';

    public function handle()
    {
        $year = now()->year; // Tahun saat ini
        $response = Http::get("https://dayoffapi.vercel.app/api?year={$year}");

        if ($response->successful()) {
            $holidays = $response->json();

            foreach ($holidays as $holiday) {
                Holiday::updateOrCreate(
                    ['date' => $holiday['tanggal']],
                    ['name' => $holiday['keterangan']]
                );
            }

            $this->info('Holidays fetched and stored successfully.');
        } else {
            $this->error('Failed to fetch holidays.');
            $this->error('Response Status: ' . $response->status());
            $this->error('Response Body: ' . $response->body());
        }
    }
}




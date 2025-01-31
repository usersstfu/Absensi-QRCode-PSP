<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('face_attendances', function (Blueprint $table) {
            $table->id();
            $table->string('user_name'); // Nama pengguna
            $table->string('latitude')->nullable(); // Latitude lokasi absensi
            $table->string('longitude')->nullable(); // Longitude lokasi absensi
            $table->text('photo')->nullable(); // Foto wajah dalam format base64
            $table->dateTime('time_in'); // Waktu absensi masuk
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendances');
    }
};

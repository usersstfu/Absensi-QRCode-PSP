<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\FaceAttendance;

class FaceAttendanceController extends Controller
/*************  ✨ Codeium Command ⭐  *************/
    /**
     * Menampilkan halaman absensi wajah
     *
     * @return \Illuminate\Http\Response
     */
/******  c2257dfd-22b3-479b-81ed-f34f51134935  *******/{
    // Halaman utama absensi
    public function index()
    {
        return view('face-attendance.index');
    }

    // Menyimpan absensi
    public function store(Request $request)
    {
        $request->validate([
            'user_name' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'photo' => 'required',
        ]);

        FaceAttendance::create([
            'user_name' => $request->user_name,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
            'photo' => $request->photo,
            'time_in' => now(),
        ]);

        return response()->json(['message' => 'Absensi berhasil disimpan.']);
    }
}

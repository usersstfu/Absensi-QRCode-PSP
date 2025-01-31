<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Absensi Deteksi Wajah</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
</head>
<body>
    <h2>Absensi dengan Wajah dan Lokasi</h2>

    <!-- Input Nama -->
    <label for="user_name">Nama:</label>
    <input type="text" id="user_name" placeholder="Masukkan Nama" required><br><br>

    <!-- Kamera -->
    <h3>Kamera</h3>
    <video id="video" width="640" height="480" autoplay muted></video>
    <canvas id="canvas" style="display:none;"></canvas>

    <!-- Lokasi -->
    <h3>Lokasi Anda</h3>
    <div id="map" style="height: 400px;"></div>
    <p id="location-info">Mendeteksi lokasi...</p>

    <!-- Tombol Submit -->
    <button id="submit">Submit Absensi</button>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // Kamera
        const video = document.getElementById('video');
        navigator.mediaDevices.getUserMedia({ video: true })
            .then((stream) => video.srcObject = stream)
            .catch((err) => console.error("Error accessing webcam: ", err));

        // Lokasi dan Peta
        let latitude = '';
        let longitude = '';
        const map = L.map('map').setView([0, 0], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

        navigator.geolocation.getCurrentPosition((position) => {
            latitude = position.coords.latitude;
            longitude = position.coords.longitude;

            document.getElementById('location-info').innerText = `Latitude: ${latitude}, Longitude: ${longitude}`;
            map.setView([latitude, longitude], 13);
            L.marker([latitude, longitude]).addTo(map);
        });

        // Submit Absensi
        document.getElementById('submit').addEventListener('click', async () => {
            const user_name = document.getElementById('user_name').value;

            if (!user_name || !latitude || !longitude) {
                alert("Nama dan lokasi wajib diisi!");
                return;
            }

            // Mengambil snapshot dari kamera
            const canvas = document.getElementById('canvas');
            const context = canvas.getContext('2d');
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            const photo = canvas.toDataURL('image/png');

            const response = await fetch("{{ route('face-attendance.store') }}", {
                method: "POST",
                headers: {
                    'X-CSRF-TOKEN': '{{ csrf_token() }}',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    user_name: user_name,
                    latitude: latitude,
                    longitude: longitude,
                    photo: photo
                })
            });

            const result = await response.json();
            alert(result.message);
        });
    </script>
</body>
</html>

# Penjelasan Singkat Tiap Widget

## Aplikasi: Foto & Notifikasi

---

## `main.dart`

### `WidgetsFlutterBinding.ensureInitialized()`
Memastikan binding Flutter sudah siap sebelum memanggil kode async di `main()`. Wajib dipanggil sebelum inisialisasi plugin seperti `flutter_local_notifications`.

### `FlutterLocalNotificationsPlugin`
Instance global plugin notifikasi. Diinisialisasi sekali di `main()` dengan pengaturan Android (`AndroidInitializationSettings`) dan iOS (`DarwinInitializationSettings`), lalu digunakan di seluruh aplikasi.

### `MaterialApp`
Widget root yang menyediakan navigasi, tema, dan konfigurasi dasar aplikasi Material Design. Parameter penting:
- `title` → nama aplikasi
- `theme` → tema warna menggunakan `ColorScheme.fromSeed`
- `home` → halaman pertama yang ditampilkan

---

## `home_page.dart`

### `StatefulWidget` & `State`
`HomePage` adalah `StatefulWidget` karena perlu menyimpan dan memperbarui state (foto yang dipilih). `_HomePageState` menyimpan variabel `_selectedImage` yang berubah saat foto dipilih.

### `Scaffold`
Kerangka halaman Material Design yang menyediakan struktur dasar: `AppBar` di atas dan `body` di tengah.

### `AppBar`
Bilah judul di bagian atas layar. Menampilkan teks "Foto & Notifikasi" dengan warna dari tema aplikasi.

### `SingleChildScrollView`
Membungkus konten agar bisa di-scroll ketika konten melebihi tinggi layar (misalnya saat keyboard muncul).

### `Column`
Menyusun widget-widget secara vertikal (dari atas ke bawah). Digunakan sebagai layout utama halaman.

### `ElevatedButton.icon` (Tombol Kamera)
Tombol dengan ikon kamera (`Icons.camera_alt`) dan label "Buka Kamera". Saat ditekan, memanggil `_pickFromCamera()` yang membuka kamera perangkat via `ImagePicker`.

### `ElevatedButton.icon` (Tombol Galeri)
Tombol dengan ikon galeri (`Icons.photo_library`) dan label "Pilih dari Galeri". Saat ditekan, memanggil `_pickFromGallery()` yang membuka galeri foto perangkat.

### `ImagePicker`
Package `image_picker` yang menyediakan akses ke kamera (`ImageSource.camera`) dan galeri (`ImageSource.gallery`). Mengembalikan `XFile` berisi path file foto.

### `Image.file`
Menampilkan gambar dari file lokal di perangkat menggunakan path yang didapat dari `ImagePicker`. Parameter `fit: BoxFit.cover` memastikan gambar mengisi area tanpa distorsi.

### `Card`
Widget yang memberikan efek bayangan (elevation) dan sudut membulat pada gambar pratinjau. `clipBehavior: Clip.antiAlias` memastikan gambar mengikuti bentuk card.

### `Container` (Placeholder)
Ditampilkan saat belum ada foto dipilih. Berisi ikon dan teks petunjuk dengan border abu-abu sebagai area kosong.

### `TextButton.icon` (Hapus Foto)
Tombol teks dengan ikon hapus. Saat ditekan, mengatur `_selectedImage = null` sehingga foto dihapus dari tampilan.

### `Divider`
Garis horizontal tipis sebagai pemisah visual antara tombol dan area pratinjau foto.

### `ScaffoldMessenger.showSnackBar`
Menampilkan pesan singkat di bagian bawah layar (SnackBar) ketika izin ditolak.

---

## Notifikasi (`flutter_local_notifications`)

### `AndroidNotificationDetails`
Konfigurasi notifikasi untuk Android:
- `channelId` → ID unik channel notifikasi
- `channelName` → nama channel yang tampil di pengaturan HP
- `importance` & `priority` → menentukan seberapa mencolok notifikasi

### `flutterLocalNotificationsPlugin.show()`
Menampilkan notifikasi segera dengan ID, judul, isi, dan detail platform. Dipanggil setelah foto berhasil diambil/dipilih.

---

## Izin (`permission_handler`)

### `Permission.camera.request()`
Meminta izin akses kamera ke pengguna. Wajib di Android 6.0+ sebelum membuka kamera.

### `Permission.photos.request()`
Meminta izin membaca foto di galeri. Untuk Android 13+ menggunakan `READ_MEDIA_IMAGES`, versi lama menggunakan `READ_EXTERNAL_STORAGE`.

---

## Alur Aplikasi

```
Pengguna tekan tombol
        ↓
Minta izin (kamera/galeri)
        ↓
Buka kamera / galeri via ImagePicker
        ↓
Pengguna ambil/pilih foto
        ↓
setState() → tampilkan foto di layar
        ↓
Tampilkan notifikasi lokal
```

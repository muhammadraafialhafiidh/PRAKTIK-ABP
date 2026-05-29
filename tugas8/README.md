# Tugas Praktikum — Notifikasi & API Perangkat Keras

Aplikasi Flutter sederhana yang mendemonstrasikan penggunaan **Camera API**, **Image Picker**, dan **Local Notifications**.

## Fitur

| Fitur | Deskripsi |
|-------|-----------|
| 📷 Buka Kamera | Mengambil foto langsung dari kamera perangkat |
| 🖼️ Pilih dari Galeri | Memilih foto yang sudah ada di galeri |
| 🔔 Notifikasi Lokal | Notifikasi muncul otomatis setelah foto berhasil diambil/dipilih |
| 🗑️ Hapus Foto | Menghapus foto dari tampilan |

## Teknologi

- **Flutter** 3.x
- [`image_picker`](https://pub.dev/packages/image_picker) ^1.1.2 — akses kamera & galeri
- [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) ^18.0.1 — notifikasi lokal
- [`permission_handler`](https://pub.dev/packages/permission_handler) ^11.3.1 — manajemen izin runtime

## Cara Menjalankan

```bash
# Clone repo
git clone <url-repo>

# Masuk ke folder project
cd foto_notifikasi

# Install dependencies
flutter pub get

# Jalankan di emulator/device
flutter run
```

## Struktur File

```
lib/
├── main.dart        # Entry point, inisialisasi notifikasi
└── home_page.dart   # Halaman utama (kamera, galeri, pratinjau foto)
```

## Penjelasan Widget

Lihat file [PENJELASAN_WIDGET.md](PENJELASAN_WIDGET.md) untuk penjelasan lengkap setiap widget yang digunakan.

## Screenshot

> Lihat folder `screenshots/` untuk hasil tampilan aplikasi.

## Izin yang Dibutuhkan

| Izin | Kegunaan |
|------|----------|
| `CAMERA` | Membuka kamera perangkat |
| `READ_MEDIA_IMAGES` | Membaca foto di galeri (Android 13+) |
| `READ_EXTERNAL_STORAGE` | Membaca penyimpanan (Android < 13) |
| `POST_NOTIFICATIONS` | Menampilkan notifikasi (Android 13+) |

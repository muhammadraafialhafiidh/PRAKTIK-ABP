import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart' show flutterLocalNotificationsPlugin;

/// [HomePage] adalah halaman utama aplikasi.
///
/// Menampilkan:
/// - Dua tombol untuk mengambil foto (kamera) dan memilih dari galeri.
/// - Pratinjau foto yang sudah diambil/dipilih.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Menyimpan path file foto yang dipilih/diambil.
  /// Null berarti belum ada foto.
  File? _selectedImage;

  /// Instance [ImagePicker] untuk mengakses kamera dan galeri.
  final ImagePicker _picker = ImagePicker();

  // ── Notifikasi ─────────────────────────────────────────────────────────────

  /// Menampilkan notifikasi lokal setelah foto berhasil diproses.
  ///
  /// [source] menentukan teks sumber foto ("Kamera" atau "Galeri").
  Future<void> _showNotification(String source) async {
    // Detail notifikasi untuk Android
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'foto_channel',          // channel ID (unik per aplikasi)
      'Foto Notifikasi',       // nama channel yang tampil di pengaturan HP
      channelDescription: 'Notifikasi setelah foto diambil atau dipilih',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails notifDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,                                    // ID notifikasi
      '📸 Foto Berhasil!',                  // judul notifikasi
      'Foto dari $source telah berhasil ditampilkan.', // isi notifikasi
      notifDetails,
    );
  }

  // ── Izin ───────────────────────────────────────────────────────────────────

  /// Meminta izin kamera dan penyimpanan sebelum mengakses perangkat keras.
  /// Mengembalikan [true] jika semua izin diberikan.
  Future<bool> _requestPermissions({required bool isCamera}) async {
    if (isCamera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        _showSnackBar('Izin kamera ditolak.');
        return false;
      }
    } else {
      // Android 13+ menggunakan Permission.photos, versi lama pakai storage
      PermissionStatus status = await Permission.photos.request();
      if (status.isPermanentlyDenied) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted) {
        _showSnackBar('Izin galeri ditolak.');
        return false;
      }
    }
    return true;
  }

  // ── Ambil Foto dari Kamera ─────────────────────────────────────────────────

  /// Membuka kamera perangkat menggunakan [ImagePicker].
  /// Setelah foto diambil, memperbarui state dan menampilkan notifikasi.
  Future<void> _pickFromCamera() async {
    final granted = await _requestPermissions(isCamera: true);
    if (!granted) return;

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,   // buka kamera langsung
      imageQuality: 85,             // kompresi ringan untuk hemat memori
    );

    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
      await _showNotification('Kamera');
    }
  }

  // ── Pilih Foto dari Galeri ─────────────────────────────────────────────────

  /// Membuka galeri perangkat menggunakan [ImagePicker].
  /// Setelah foto dipilih, memperbarui state dan menampilkan notifikasi.
  Future<void> _pickFromGallery() async {
    final granted = await _requestPermissions(isCamera: false);
    if (!granted) return;

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,  // buka galeri
      imageQuality: 85,
    );

    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
      await _showNotification('Galeri');
    }
  }

  // ── Helper ─────────────────────────────────────────────────────────────────

  /// Menampilkan [SnackBar] dengan pesan singkat.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      // Widget bilah judul di bagian atas layar.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Foto & Notifikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // ── Body ────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        // [SingleChildScrollView] agar konten bisa di-scroll
        // ketika keyboard muncul atau layar kecil.
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Judul Seksi ──────────────────────────────────────────────
            const Text(
              'Pilih Sumber Foto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // ── Tombol Kamera ────────────────────────────────────────────
            // [ElevatedButton.icon] menampilkan tombol dengan ikon dan label.
            ElevatedButton.icon(
              onPressed: _pickFromCamera,
              icon: const Icon(Icons.camera_alt, size: 22),
              label: const Text(
                'Buka Kamera',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // ── Tombol Galeri ────────────────────────────────────────────
            ElevatedButton.icon(
              onPressed: _pickFromGallery,
              icon: const Icon(Icons.photo_library, size: 22),
              label: const Text(
                'Pilih dari Galeri',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ── Divider ──────────────────────────────────────────────────
            const Divider(thickness: 1.2),
            const SizedBox(height: 16),

            // ── Pratinjau Foto ───────────────────────────────────────────
            // Menampilkan foto jika sudah dipilih, atau placeholder jika belum.
            _selectedImage != null
                ? _buildImagePreview()
                : _buildPlaceholder(),
          ],
        ),
      ),
    );
  }

  // ── Widget Pratinjau Foto ──────────────────────────────────────────────────

  /// Menampilkan foto yang sudah dipilih dalam [Card] dengan sudut membulat.
  Widget _buildImagePreview() {
    return Column(
      children: [
        const Text(
          'Foto Terpilih',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        // [Card] memberikan efek bayangan dan sudut membulat pada gambar.
        Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias, // agar gambar mengikuti bentuk Card
          child: Image.file(
            _selectedImage!,
            // [Image.file] menampilkan gambar dari path file lokal.
            fit: BoxFit.cover,
            width: double.infinity,
            height: 320,
          ),
        ),
        const SizedBox(height: 10),
        // Tombol hapus foto
        TextButton.icon(
          onPressed: () => setState(() => _selectedImage = null),
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          label: const Text(
            'Hapus Foto',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  // ── Widget Placeholder ─────────────────────────────────────────────────────

  /// Ditampilkan saat belum ada foto yang dipilih.
  /// Menggunakan [Container] dengan border putus-putus sebagai area kosong.
  Widget _buildPlaceholder() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.5,
          // Simulasi border putus-putus dengan warna abu
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'Belum ada foto dipilih',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            'Gunakan tombol di atas untuk mengambil foto',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

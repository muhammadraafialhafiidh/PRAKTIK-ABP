import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home_page.dart';

/// Instance global plugin notifikasi lokal.
/// Dibuat di sini agar bisa diakses dari halaman manapun.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // Pastikan binding Flutter sudah siap sebelum inisialisasi plugin
  WidgetsFlutterBinding.ensureInitialized();

  // ── Inisialisasi flutter_local_notifications ──────────────────────────────
  // Pengaturan untuk Android: nama ikon notifikasi (harus ada di drawable)
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Pengaturan untuk iOS/macOS
  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  runApp(const MyApp());
}

/// Widget root aplikasi.
/// Menggunakan [MaterialApp] sebagai entry point navigasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foto & Notifikasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

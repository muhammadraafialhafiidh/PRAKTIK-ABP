import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // 1. Meminta Izin (khususnya untuk iOS, untuk Android 13+ juga membutuhkan izin runtime yang dikelola oleh package ini)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }

    // 2. Mendapatkan Token Device untuk Testing Notifikasi
    try {
      String? token = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print("====================================");
        print("FCM DEVICE TOKEN:");
        print(token);
        print("====================================");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting token: $e");
      }
    }

    // 3. Menangkap pesan saat aplikasi berjalan di Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.notification?.title}');
        }
      }
    });
  }
}

// Handler untuk pesan saat aplikasi berada di Background / Terminated
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Jika ingin inisialisasi Firebase di sini pastikan memanggil Firebase.initializeApp() sebelumnya.
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

# Laporan Implementasi Flutter To-Do List dengan Provider dan FCM

**Nama:** [Nama Anda]  
**NIM:** [NIM Anda]  
**Mata Kuliah:** [Mata Kuliah Anda]  

## 1. Deskripsi Aplikasi
Aplikasi ini adalah sebuah aplikasi Flutter sederhana yang berfungsi sebagai To-Do List. Aplikasi ini menerapkan state management `Provider` untuk mengelola daftar tugas (menambah tugas baru dan menghapus seluruh tugas) dan terintegrasi dengan **Firebase Cloud Messaging (FCM)** untuk menerima push notification.

## 2. Screenshot Aplikasi

### A. Tampilan Daftar Tugas
*(Silakan ganti teks ini dengan screenshot halaman utama yang berisi daftar tugas. Anda bisa menggunakan sintaks markdown: `![Tampilan Daftar Tugas](path_ke_gambar)`)*

### B. Proses Penambahan Tugas
*(Silakan ganti teks ini dengan screenshot saat dialog/form penambahan tugas sedang terbuka)*

### C. Notifikasi yang Berhasil Diterima
*(Silakan ganti teks ini dengan screenshot notifikasi yang masuk dari Firebase Console / Postman ke emulator atau device Anda)*

## 3. Penjelasan Implementasi

- **Provider**: Digunakan `TaskProvider` yang menge-extend `ChangeNotifier`. Terdapat List `<String>` yang menyimpan data tugas. Saat fungsi `addTask` atau `clearTasks` dipanggil, `notifyListeners()` akan dipicu untuk memperbarui UI yang dibungkus oleh `Consumer<TaskProvider>`.
- **FCM**: Menggunakan package `firebase_messaging`. Aplikasi meminta izin notifikasi, mengambil *Device Token* yang kemudian dicetak ke console, dan memiliki listener `FirebaseMessaging.onMessage` untuk menangkap notifikasi saat aplikasi berada di *foreground*. Handler background juga telah didefinisikan.

---
*Catatan: Source code lengkap terdapat di folder `lib/`.*

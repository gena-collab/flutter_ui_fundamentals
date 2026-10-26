
# Course Data Manager

Aplikasi Flutter untuk mengelola data mata kuliah (course) dengan fitur melihat, menambahkan, mengubah, menghapus, melihat detail, dan menandai mata kuliah favorit.

## Fitur Utama

- Menampilkan daftar mata kuliah.
- Menambahkan data mata kuliah.
- Mengubah data mata kuliah.
- Menghapus data mata kuliah.
- Melihat detail mata kuliah.
- Menandai mata kuliah sebagai favorit.
- Menampilkan pesan kesalahan ketika terjadi masalah jaringan atau backend.

## Teknologi yang Digunakan

- Flutter dan Dart untuk pengembangan aplikasi.
- Supabase sebagai backend dan database.
- REST API melalui layanan HTTP untuk latihan integrasi API.
- Git dan GitHub untuk version control.

## Cara Menjalankan

1. Instal Flutter SDK dan siapkan Android Studio atau perangkat yang kompatibel.
2. Clone repository ini.
3. Buka folder project di VS Code.
4. Jalankan `flutter pub get`.
5. Pastikan konfigurasi Supabase tersedia secara lokal dan tidak berisi credential rahasia yang diunggah ke repository.
6. Jalankan `flutter run`.

## Arsitektur Singkat

- `lib/models/`: model data mata kuliah.
- `lib/services/`: layanan akses data dan komunikasi dengan backend.
- `lib/`: tampilan dan logika aplikasi Flutter.
- `test/`: pengujian aplikasi.

Aplikasi memisahkan model data dan layanan backend agar pengelolaan data lebih mudah dipelihara. Akses database tetap mengikuti konfigurasi izin dan kebijakan Row Level Security (RLS) di Supabase.

## Keamanan

- Tidak menyimpan `service_role key` di source code aplikasi.
- Tidak mengunggah password atau credential rahasia ke GitHub.
- Menggunakan RLS untuk membatasi akses database.
- Validasi UI tidak menggantikan validasi dan otorisasi backend.

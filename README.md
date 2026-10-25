# Course Explorer

## Struktur Arsitektur

- `models/`: menyimpan model data mata kuliah.
- `services/`: mengambil dan membaca data mata kuliah dari JSON.
- `repositories/`: menjadi perantara antara Service dan Provider.
- `providers/`: mengelola state, loading, error, dan data mata kuliah.
- `screens/`: menampilkan halaman Home, Courses, Favorites, dan Profile.
- `widgets/`: menyimpan komponen UI yang digunakan kembali.
- `assets/data/`: menyimpan data mata kuliah dalam format JSON.

## Arah Dependency

Screen/Widget → Provider → Repository → Service/Data Source.

UI tidak membaca JSON secara langsung. Provider mengelola state tanpa menyimpan `BuildContext` sebagai state.



## Tahap 1 — Membaca REST Endpoint

### Tujuan
Memahami cara membaca data dari REST API menggunakan HTTP GET.

### Endpoint yang digunakan
- Base URL: https://course-api-pearl.vercel.app
- Endpoint: /courses
- Method: GET
- URL lengkap: https://course-api-pearl.vercel.app/courses

### Hasil Pengujian
Request berhasil dijalankan melalui Postman Web dengan status 200 OK. Respons yang diterima berupa JSON berisi daftar course.

### Struktur Data
Setiap course memiliki field:
- id: identitas course
- code: kode course
- title: nama course
- credits: jumlah kredit
- status: status course

### Kesimpulan
Pada tahap ini, saya memahami bahwa REST API dapat digunakan untuk mengambil data dari server menggunakan method GET. Data yang diterima berbentuk JSON dan dapat digunakan sebagai sumber data pada aplikasi Flutter.

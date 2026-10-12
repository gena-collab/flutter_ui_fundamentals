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
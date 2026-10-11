
import 'package:flutter/foundation.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseState extends ChangeNotifier {
  // Menyimpan kode mata kuliah yang menjadi favorit.
  final Set<String> _favorites = {};

  // Mengakses daftar mata kuliah favorit.
  Set<String> get favorites => Set.unmodifiable(_favorites);

  // Menghitung jumlah mata kuliah favorit.
  int get favoriteCount => _favorites.length;

  // Mengecek status favorit mata kuliah.
  bool isFavorite(String code) {
    return _favorites.contains(code);
  }

  // Mengubah status favorit dan memperbarui semua listener.
  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }

    notifyListeners();
  }
}

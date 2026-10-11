
import 'package:flutter/foundation.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseState extends ChangeNotifier {
  // Menyimpan kode mata kuliah yang menjadi favorit.
  final Set<String> favorites = {};

  // Mengecek apakah mata kuliah termasuk favorit.
  bool isFavorite(String id) {
    return favorites.contains(id);
  }

  // Mengubah status favorit dan memberi tahu listener.
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }
}

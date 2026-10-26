
import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  List<Course> _courses = [];
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isUpdating = false;
  bool _isDeleting = false;
  String? _error;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isUpdating => _isUpdating;
  bool get isDeleting => _isDeleting;
  String? get error => _error;

  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (e) {
      _error = 'Gagal memuat data mata kuliah: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Course> createCourse(Course course) async {
    if (_isSaving) {
      throw Exception('Course sedang disimpan.');
    }

    _isSaving = true;
    notifyListeners();

    try {
      final createdCourse =
          await repository.createCourse(course);

      await loadCourses();

      if (_error != null) {
        throw Exception(
          'Course tersimpan, tetapi daftar gagal dimuat ulang.',
        );
      }

      return createdCourse;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCourse(int id, Course course) async {
    if (_isUpdating) {
      throw Exception('Course sedang diperbarui.');
    }

    _isUpdating = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);
      await loadCourses();

      if (_error != null) {
        throw Exception(
          'Course diperbarui, tetapi daftar gagal dimuat ulang.',
        );
      }
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<void> deleteCourse(int id) async {
    if (_isDeleting) {
      throw Exception('Course sedang dihapus.');
    }

    _isDeleting = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);
      await loadCourses();

      if (_error != null) {
        throw Exception(
          'Course terhapus, tetapi daftar gagal dimuat ulang.',
        );
      }
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }
}

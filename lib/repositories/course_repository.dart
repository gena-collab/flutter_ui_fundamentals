
import '../models/course.dart';
import '../services/course_service.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseRepository {
  final CourseService service;

  CourseRepository(this.service);

  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}

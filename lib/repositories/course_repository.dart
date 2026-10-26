import '../models/course.dart';
import '../services/course_api_service.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseRepository {
  final CourseApiService service;

  CourseRepository(this.service);

  Future<List<Course>> getCourses() {
    return service.getCourses();
  }

  Future<Course> createCourse(Course course) {
    return service.createCourse(course);
  }
}

import '../models/course.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

abstract class CourseDataSource {
  Future<List<Course>> getCourses();

  Future<Course> createCourse(Course course);

  Future<void> updateCourse(int id, Course course);

  Future<void> deleteCourse(int id);
}

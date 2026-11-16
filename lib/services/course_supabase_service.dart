
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    // owner_id otomatis diisi menggunakan auth.uid()
    // melalui default value pada database.
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(
      Map<String, dynamic>.from(row),
    );
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    final rows = await supabase
        .from('courses')
        .update(course.toJson())
        .eq('id', id)
        .select();

    if (rows.isEmpty) {
      throw Exception(
        'Mata kuliah tidak dapat diperbarui. '
        'Data bukan milikmu atau akses ditolak oleh RLS.',
      );
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final rows = await supabase
        .from('courses')
        .delete()
        .eq('id', id)
        .select();

    if (rows.isEmpty) {
      throw Exception(
        'Mata kuliah tidak dapat dihapus. '
        'Data bukan milikmu atau akses ditolak oleh RLS.',
      );
    }
  }
}

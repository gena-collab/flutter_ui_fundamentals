import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';


// Nama: Gena Anggarani
// NIM: 2415051038

const String apiUrl =
    'https://course-api-pearl.vercel.app/courses';
    
class CourseService {
  Future<List<Course>> loadCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) {
        debugPrint('Jumlah course: ${data.length}');

        return data
            .map(
              (item) => Course.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }

      throw Exception('Format JSON tidak sesuai harapan');
    }

    throw Exception('HTTP ${response.statusCode}');
  }
}

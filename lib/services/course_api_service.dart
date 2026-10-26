
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseApiService implements CourseDataSource {
  CourseApiService(this.baseUrl);

  final String baseUrl;

  static const Duration _timeout = Duration(seconds: 15);

  Exception _httpError(int statusCode, String action) {
    switch (statusCode) {
      case 400:
        return Exception(
          '$action: permintaan tidak valid (HTTP 400).',
        );
      case 401:
        return Exception(
          '$action: autentikasi diperlukan (HTTP 401).',
        );
      case 403:
        return Exception(
          '$action: akses ditolak (HTTP 403).',
        );
      case 404:
        return Exception(
          '$action: endpoint atau data tidak ditemukan (HTTP 404). '
          'Periksa URL API.',
        );
      case 409:
        return Exception(
          '$action: terjadi konflik atau data duplikat (HTTP 409).',
        );
      case 422:
        return Exception(
          '$action: data tidak memenuhi validasi (HTTP 422).',
        );
      default:
        if (statusCode >= 500) {
          return Exception(
            '$action: server bermasalah (HTTP $statusCode). '
            'Silakan coba lagi.',
          );
        }
        return Exception(
          '$action: permintaan gagal (HTTP $statusCode).',
        );
    }
  }

  Exception _networkError(Object error) {
    if (error is TimeoutException) {
      return Exception(
        'Permintaan terlalu lama. Periksa koneksi dan coba lagi.',
      );
    }

    if (error is SocketException ||
        error is http.ClientException) {
      return Exception(
        'Koneksi jaringan gagal. Periksa internet dan coba lagi.',
      );
    }

    if (error is FormatException || error is TypeError) {
      return Exception(
        'Format data dari server tidak sesuai. '
        'Periksa struktur JSON dan model Course.',
      );
    }

    return Exception(
      'Terjadi kesalahan saat mengakses API: $error',
    );
  }

  bool _isHttpError(Object error) {
    return error is Exception &&
        error.toString().startsWith('Exception: Gagal');
  }

  @override
  Future<List<Course>> getCourses() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/courses'))
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw _httpError(
          response.statusCode,
          'Gagal mengambil course',
        );
      }

      final data = jsonDecode(response.body) as List<dynamic>;

      return data
          .map(
            (item) => Course.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      if (_isHttpError(e)) {
        rethrow;
      }
      throw _networkError(e);
    }
  }

  @override
  Future<Course> createCourse(Course course) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/courses'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(course.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw _httpError(
          response.statusCode,
          'Gagal membuat course',
        );
      }

      return Course.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } catch (e) {
      if (_isHttpError(e)) {
        rethrow;
      }
      throw _networkError(e);
    }
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/courses/$id'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(course.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw _httpError(
          response.statusCode,
          'Gagal memperbarui course',
        );
      }
    } catch (e) {
      if (_isHttpError(e)) {
        rethrow;
      }
      throw _networkError(e);
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('$baseUrl/courses/$id'))
          .timeout(_timeout);

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw _httpError(
          response.statusCode,
          'Gagal menghapus course',
        );
      }
    } catch (e) {
      if (_isHttpError(e)) {
        rethrow;
      }
      throw _networkError(e);
    }
  }
}

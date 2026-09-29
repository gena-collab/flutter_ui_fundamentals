import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadStudentData() async {
  final String jsonString =
      await rootBundle.loadString('assets/data/student_data.json');

  return jsonDecode(jsonString) as Map<String, dynamic>;
}
import 'package:flutter/material.dart';

class Course {
  final String code;
  final String name;
  final String description;
  final IconData icon;

  const Course({
    required this.code,
    required this.name,
    required this.description,
    required this.icon,
  });
}

const List<Course> courses = [
  Course(
    code: 'PM001',
    name: 'Pemrograman Mobile',
    description: 'Belajar membuat aplikasi mobile dengan Flutter dan Dart.',
    icon: Icons.phone_android,
  ),
  Course(
    code: 'PW002',
    name: 'Pemrograman Web',
    description: 'Mempelajari pengembangan aplikasi berbasis web.',
    icon: Icons.language,
  ),
  Course(
    code: 'BD003',
    name: 'Basis Data',
    description: 'Mempelajari pengelolaan dan perancangan basis data.',
    icon: Icons.storage,
  ),
  Course(
    code: 'AI004',
    name: 'Kecerdasan Buatan',
    description: 'Mengenal konsep AI dan penerapannya dalam kehidupan.',
    icon: Icons.smart_toy,
  ),
  Course(
    code: 'RPL005',
    name: 'Rekayasa Perangkat Lunak',
    description: 'Mempelajari proses perancangan perangkat lunak.',
    icon: Icons.code,
  ),
];

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';
import 'screens/course_explorer_page.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
      ),
      home: const CourseExplorerPage(),
    );
  }
}

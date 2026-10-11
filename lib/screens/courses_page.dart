import 'package:flutter/material.dart';

import '../course_data.dart';
import '../widgets/blue_header.dart';
import '../widgets/course_card.dart';

class CoursesPage extends StatelessWidget {
  final ValueChanged<Course> onCourseTap;

  const CoursesPage({
    super.key,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BlueHeader(
          title: 'Daftar Mata Kuliah',
          subtitle: 'Pilih mata kuliah dan simpan favoritmu.',
        ),
        const SizedBox(height: 24),
        ...courses.map(
          (course) => CourseCard(
            course: course,
            onTap: () => onCourseTap(course),
          ),
        ),
      ],
    );
  }
}

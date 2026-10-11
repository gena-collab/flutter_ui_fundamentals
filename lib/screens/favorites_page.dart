
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_data.dart';
import '../course_state.dart';
import '../widgets/course_card.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class FavoritesPage extends StatelessWidget {
  final ValueChanged<Course> onCourseTap;

  const FavoritesPage({
    super.key,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final favoriteCourses = courses
        .where((course) => courseState.isFavorite(course.code))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Kuliah Favorit'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Favorit: ${courseState.favoriteCount}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: favoriteCourses.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 56,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text('Belum ada mata kuliah favorit.'),
                          Text('Tekan ikon hati pada halaman Courses.'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteCourses.length,
                      itemBuilder: (context, index) {
                        final course = favoriteCourses[index];

                        return CourseCard(
                          course: course,
                          onTap: () => onCourseTap(course),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

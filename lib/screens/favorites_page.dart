
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

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
    final favoriteState = context.watch<CourseState>();
    final provider = context.watch<CourseProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mata Kuliah Favorit')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  provider.error!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: provider.loadCourses,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final favoriteCourses = provider.courses
        .where((course) => favoriteState.isFavorite(course.code))
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
              'Total Favorit: ${favoriteCourses.length}',
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

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE3F2FD),
                              child: Icon(
                                Icons.menu_book,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(course.title),
                            subtitle: Text(
                              '${course.code} • ${course.credits} SKS • '
                              '${course.status}',
                            ),
                            onTap: () => onCourseTap(course),
                            trailing: IconButton(
                              tooltip: 'Hapus dari favorit',
                              onPressed: () {
                                context
                                    .read<CourseState>()
                                    .toggleFavorite(course.code);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
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

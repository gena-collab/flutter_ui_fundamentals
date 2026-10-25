
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_data.dart' as ui;
import '../course_state.dart';
import '../providers/course_provider.dart';
import '../widgets/blue_header.dart';
import '../widgets/error_view.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CoursesPage extends StatelessWidget {
  final ValueChanged<ui.Course> onCourseTap;

  const CoursesPage({
    super.key,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.error != null) {
          return ErrorView(
             message: provider.error!,
             onRetry: provider.loadCourses,
           );
        }

        if (provider.courses.isEmpty) {
          return const Center(
            child: Text('Belum ada data mata kuliah.'),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const BlueHeader(
              title: 'Daftar Mata Kuliah',
              subtitle: 'Pilih mata kuliah dan simpan favoritmu.',
            ),
            const SizedBox(height: 24),
            Text(
              'Total ${provider.courses.length} mata kuliah',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...provider.courses.map((course) {
              final uiCourse = ui.Course(
                name: course.title,
                code: course.code,
                icon: Icons.menu_book,
                description:
                    '${course.credits} SKS • Status: ${course.status}',
              );

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
                  title: Text(
                    course.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${course.code} • ${course.credits} SKS • ${course.status}',
                  ),
                  onTap: () => onCourseTap(uiCourse),
                  trailing: Consumer<CourseState>(
                    builder: (context, state, child) {
                      final favorite =
                          state.isFavorite(course.code);

                      return IconButton(
                        tooltip: favorite
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        onPressed: () {
                          state.toggleFavorite(course.code);
                        },
                        icon: Icon(
                          favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorite
                              ? Colors.red
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

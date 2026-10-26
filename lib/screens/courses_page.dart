
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/blue_header.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';
import 'edit_course_page.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CoursesPage extends StatelessWidget {
  final ValueChanged<Course> onCourseTap;

  const CoursesPage({
    super.key,
    required this.onCourseTap,
  });

  Future<void> _confirmDeleteCourse(
    BuildContext context,
    Course course,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus "${course.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || confirmed != true || course.id == null) {
      return;
    }

    try {
      await context.read<CourseProvider>().deleteCourse(course.id!);

      if (!context.mounted) return;

      final favoriteState = context.read<CourseState>();
      if (favoriteState.isFavorite(course.code)) {
        favoriteState.toggleFavorite(course.code);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course berhasil dihapus.')),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus course: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return ErrorView(
            message: provider.error!,
            onRetry: provider.loadCourses,
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
            FilledButton.icon(
              onPressed: () {
                Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCoursePage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Course'),
            ),
            const SizedBox(height: 24),
            if (provider.courses.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text('Belum ada data mata kuliah.'),
                ),
              )
            else ...[
              Text(
                'Total ${provider.courses.length} mata kuliah',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...provider.courses.map((course) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE3F2FD),
                      child: Icon(Icons.menu_book, color: Colors.blue),
                    ),
                    title: Text(
                      course.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${course.code} • ${course.credits} SKS • '
                      '${course.status}',
                    ),
                    onTap: () => onCourseTap(course),
                    trailing: Wrap(
                      spacing: 0,
                      children: [
                        IconButton(
                          tooltip: 'Edit course',
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: course.id == null
                              ? null
                              : () {
                                  Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditCoursePage(course: course),
                                    ),
                                  );
                                },
                        ),
                        IconButton(
                          tooltip: 'Hapus course',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: course.id == null || provider.isDeleting
                              ? null
                              : () => _confirmDeleteCourse(context, course),
                        ),
                        Consumer<CourseState>(
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
                                color: favorite ? Colors.red : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        );
      },
    );
  }
}

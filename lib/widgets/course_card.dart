import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_data.dart';
import '../course_state.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.blue.shade50,
          child: Icon(course.icon, color: Colors.blue),
        ),
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(course.code),
        onTap: onTap,
        trailing: Consumer<CourseState>(
          builder: (context, courseState, child) {
            final isFavorite = courseState.isFavorite(course.code);

            return IconButton(
              tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
              onPressed: () {
                context.read<CourseState>().toggleFavorite(course.code);
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}


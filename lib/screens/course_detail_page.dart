
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  void _showFeedbackDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Masukan: ${course.title}'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Tulis masukan',
              hintText: 'Masukkan pendapat kamu...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Terima kasih atas masukannya!'),
                  ),
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    ).then((_) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
      ),
      body: Consumer<CourseState>(
        builder: (context, state, child) {
          final isFavorite = state.isFavorite(course.code);

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 12),
              const CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(
                  Icons.menu_book,
                  size: 42,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                course.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                course.code,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _detailRow('ID Database', course.id?.toString() ?? '-'),
                      const Divider(height: 24),
                      _detailRow('Kode Course', course.code),
                      const Divider(height: 24),
                      _detailRow('Nama Course', course.title),
                      const Divider(height: 24),
                      _detailRow('Jumlah SKS', '${course.credits} SKS'),
                      const Divider(height: 24),
                      _detailRow('Status', course.status),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => state.toggleFavorite(course.code),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor:
                      isFavorite ? Colors.red : Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _showFeedbackDialog(context),
                icon: const Icon(Icons.feedback_outlined),
                label: const Text('Beri Masukan'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 115,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

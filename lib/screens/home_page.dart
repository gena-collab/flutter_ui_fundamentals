
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../student_info.dart';
import '../widgets/blue_header.dart';
import '../widgets/summary_card.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class HomePage extends StatefulWidget {
  final ValueChanged<Course> onCourseTap;
  final ValueChanged<int> onNavigate;

  const HomePage({
    super.key,
    required this.onCourseTap,
    required this.onNavigate,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  int setStateCounter = 0;

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        BlueHeader(
          title: 'Course Explorer',
          subtitle: 'Halo, $studentName! NIM: 2415051038',
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                icon: Icons.menu_book,
                title: 'Total Mata Kuliah',
                value: provider.isLoading
                    ? '...'
                    : '${provider.courses.length}',
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(child: FavoriteCountCard()),
          ],
        ),
        const SizedBox(height: 28),
        const Text(
          'Eksperimen ValueNotifier',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text('Nilai ValueNotifier'),
                const SizedBox(height: 8),
                ValueListenableBuilder<int>(
                  valueListenable: counter,
                  builder: (context, value, child) => Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => counter.value++,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah ValueNotifier'),
                ),
                const Divider(height: 30),
                const Text('Nilai setState() sebagai pembanding'),
                const SizedBox(height: 8),
                Text(
                  '$setStateCounter',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => setState(() => setStateCounter++),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tambah dengan setState()'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Mata Kuliah',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => widget.onNavigate(1),
              child: const Text('Lihat semua'),
            ),
          ],
        ),
        if (provider.isLoading)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (provider.error != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: provider.loadCourses,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          )
        else if (provider.courses.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Belum ada data mata kuliah.'),
          )
        else
          ...provider.courses.take(3).map((course) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE3F2FD),
                  child: Icon(Icons.menu_book, color: Colors.blue),
                ),
                title: Text(course.title),
                subtitle: Text(
                  '${course.code} • ${course.credits} SKS • '
                  '${course.status}',
                ),
                onTap: () => widget.onCourseTap(course),
                trailing: Consumer<CourseState>(
                  builder: (context, state, child) {
                    final favorite = state.isFavorite(course.code);

                    return IconButton(
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
              ),
            );
          }),
      ],
    );
  }
}

class FavoriteCountCard extends StatelessWidget {
  const FavoriteCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    return SummaryCard(
      icon: Icons.favorite,
      title: 'Mata Kuliah Favorit',
      value: '${courseState.favorites.length}',
    );
  }
}

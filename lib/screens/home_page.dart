import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_data.dart';
import '../course_state.dart';
import '../student_info.dart';
import '../widgets/blue_header.dart';
import '../widgets/course_card.dart';
import '../widgets/summary_card.dart';

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
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        BlueHeader(
          title: 'Course Explorer',
          subtitle: 'Halo, $studentName! Yuk, lanjut belajar.',
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                icon: Icons.menu_book,
                title: 'Total Mata Kuliah',
                value: '${courses.length}',
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
        ...courses.take(3).map(
          (course) => CourseCard(
            course: course,
            onTap: () => widget.onCourseTap(course),
          ),
        ),
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

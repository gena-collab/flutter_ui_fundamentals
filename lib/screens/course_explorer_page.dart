import 'package:flutter/material.dart';

import '../course_data.dart';
import 'courses_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class CourseExplorerPage extends StatefulWidget {
  const CourseExplorerPage({super.key});

  @override
  State<CourseExplorerPage> createState() => _CourseExplorerPageState();
}

class _CourseExplorerPageState extends State<CourseExplorerPage> {
  int selectedIndex = 0;

  void showCourseDetail(Course course) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(course.icon, size: 42, color: Colors.blue),
        title: Text(course.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${course.code}'),
            const SizedBox(height: 12),
            Text(course.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              showFeedbackDialog(course);
            },
            child: const Text('Beri Masukan'),
          ),
        ],
      ),
    );
  }

  void showFeedbackDialog(Course course) {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Masukan: ${course.name}'),
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
      ),
    ).then((_) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;

        final pages = [
          HomePage(
            onCourseTap: showCourseDetail,
            onNavigate: (index) => setState(() => selectedIndex = index),
          ),
          CoursesPage(onCourseTap: showCourseDetail),
          const ProfilePage(),
        ];

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (isWide)
                  NavigationRail(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() => selectedIndex = index);
                    },
                    labelType: NavigationRailLabelType.all,
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Icon(
                        Icons.school,
                        size: 34,
                        color: Colors.blue,
                      ),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.menu_book_outlined),
                        selectedIcon: Icon(Icons.menu_book),
                        label: Text('Courses'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: pages,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

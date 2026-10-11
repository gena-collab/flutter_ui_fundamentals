
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_state.dart';
import 'models/course.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

const String studentName = 'Gena Anggarani';
const String studentId = '2415051038';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
      ),
      home: const CourseExplorerPage(),
    );
  }
}

class CourseData {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String category;

  const CourseData({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.category,
  });
}

const List<CourseData> courses = [
  CourseData(
    code: 'PMO',
    title: 'Pemrograman Mobile',
    credits: 3,
    status: 'Selesai',
    category: 'Pemrograman',
  ),
  CourseData(
    code: 'MTP',
    title: 'Metopen',
    credits: 3,
    status: 'Selesai',
    category: 'Penelitian',
  ),
  CourseData(
    code: 'MKT',
    title: 'Mikro Teaching',
    credits: 2,
    status: 'Belum',
    category: 'Pendidikan',
  ),
  CourseData(
    code: 'LLH',
    title: 'Linpro Literasi Humanistik',
    credits: 2,
    status: 'Selesai',
    category: 'Literasi',
  ),
  CourseData(
    code: 'LLK',
    title: 'Linpro Literasi Keuangan',
    credits: 2,
    status: 'Belum',
    category: 'Literasi',
  ),
];

class CourseExplorerPage extends StatefulWidget {
  const CourseExplorerPage({super.key});

  @override
  State<CourseExplorerPage> createState() => _CourseExplorerPageState();
}

class _CourseExplorerPageState extends State<CourseExplorerPage> {
  int selectedIndex = 0;

  final ValueNotifier<int> studyCounter = ValueNotifier<int>(0);
  int activityCounter = 0;

  @override
  void dispose() {
    studyCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onExploreCourses: () {
          setState(() => selectedIndex = 1);
        },
        studyCounter: studyCounter,
        activityCounter: activityCounter,
        onActivityChanged: (value) {
          setState(() => activityCounter = value);
        },
      ),
      const CoursesPage(),
      const ProfilePage(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final wideScreen = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Course Explorer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF174A8B),
            elevation: 0,
          ),
          body: Row(
            children: [
              if (wideScreen)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
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
          bottomNavigationBar: wideScreen
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

class BlueHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const BlueHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF174A8B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class FavoriteCountCard extends StatelessWidget {
  const FavoriteCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    return Card(
      elevation: 0,
      color: Colors.blue.shade50,
      child: ListTile(
        leading: const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 30,
        ),
        title: const Text('Mata Kuliah Favorit'),
        subtitle: Text('${courseState.favorites.length} mata kuliah'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onExploreCourses;
  final ValueNotifier<int> studyCounter;
  final int activityCounter;
  final ValueChanged<int> onActivityChanged;

  const HomePage({
    super.key,
    required this.onExploreCourses,
    required this.studyCounter,
    required this.activityCounter,
    required this.onActivityChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Tahap 8: mengubah Map menjadi objek Course.
    final sampleCourse = Course.fromJson({
      'code': 'PMO',
      'title': 'Pemrograman Mobile',
      'credits': 3,
      'status': 'Selesai',
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BlueHeader(
                title: 'Halo, Gena! 👋',
                subtitle: 'Selamat datang di ruang belajar kamu.',
              ),
              const SizedBox(height: 20),
              const FavoriteCountCard(),
              const SizedBox(height: 24),
              const Text(
                'Contoh Model Course',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Icon(Icons.school, color: Colors.blue),
                  ),
                  title: Text(
                    sampleCourse.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${sampleCourse.code} • ${sampleCourse.credits} SKS'
                    ' • ${sampleCourse.status}',
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Latihan State Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                child: ValueListenableBuilder<int>(
                  valueListenable: studyCounter,
                  builder: (context, value, child) {
                    return ListTile(
                      leading: const Icon(
                        Icons.menu_book,
                        color: Colors.blue,
                      ),
                      title: const Text('Study Counter'),
                      subtitle: Text('Jumlah belajar: $value'),
                      trailing: IconButton(
                        onPressed: () => studyCounter.value++,
                        icon: const Icon(Icons.add_circle),
                      ),
                    );
                  },
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: const Icon(
                    Icons.touch_app,
                    color: Colors.blue,
                  ),
                  title: const Text('Activity Counter'),
                  subtitle: Text('Jumlah aktivitas: $activityCounter'),
                  trailing: IconButton(
                    onPressed: () => onActivityChanged(activityCounter + 1),
                    icon: const Icon(Icons.add_circle),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onExploreCourses,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Jelajahi Mata Kuliah'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1000
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            mainAxisExtent: 185,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(course: course);
          },
        );
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final CourseData course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    course.code,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<CourseState>(
                  builder: (context, courseState, child) {
                    final isFavorite = courseState.isFavorite(course.code);

                    return IconButton(
                      tooltip: isFavorite
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
                      onPressed: () {
                        context.read<CourseState>().toggleFavorite(
                              course.code,
                            );
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
            Text(
              course.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text('${course.credits} SKS • ${course.category}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    course.status,
                    style: TextStyle(
                      color: course.status == 'Selesai'
                          ? Colors.green.shade700
                          : Colors.orange.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(course.title),
                        content: Text(
                          'Kode: ${course.code}\n'
                          'SKS: ${course.credits}\n'
                          'Kategori: ${course.category}\n'
                          'Status: ${course.status}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Tutup'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              showDialog<void>(
                                context: context,
                                builder: (feedbackContext) =>
                                    const FeedbackDialog(),
                              );
                            },
                            child: const Text('Beri Feedback'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Detail'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController controller = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Feedback Mata Kuliah'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Tulis feedback minimal 5 karakter',
              errorText: errorMessage,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.trim().length < 5) {
              setState(() {
                errorMessage = 'Feedback minimal 5 karakter.';
              });
              return;
            }

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feedback berhasil dikirim.')),
            );
          },
          child: const Text('Kirim'),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1976D2),
                ),
                child: const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                studentName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'NIM: $studentId',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.school, color: Colors.blue),
                      title: Text('Program Studi'),
                      subtitle: Text('Teknik Informatika'),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.apps, color: Colors.blue),
                      title: Text('Aplikasi'),
                      subtitle: Text('Course Explorer'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

const String studentName = 'Gena Anggarani';
const String studentId = '2415051038';
const String profileImage = 'assets/images/profile.jpeg';

void main() {
  runApp(const CourseExplorerApp());
}

class Course {
  final String code;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const Course({
    required this.code,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const List<Course> courses = [
  Course(
    code: 'PM001',
    name: 'Pemrograman Mobile',
    description: 'Mempelajari Flutter, Dart, dan desain antarmuka aplikasi.',
    icon: Icons.phone_android_rounded,
    color: Color(0xFF1976D2),
  ),
  Course(
    code: 'PW002',
    name: 'Pemrograman Web',
    description: 'Mempelajari pengembangan website dan teknologi web.',
    icon: Icons.language_rounded,
    color: Color(0xFF0097A7),
  ),
  Course(
    code: 'BD003',
    name: 'Basis Data',
    description: 'Mempelajari perancangan database dan SQL.',
    icon: Icons.storage_rounded,
    color: Color(0xFF7C4DFF),
  ),
  Course(
    code: 'AI004',
    name: 'Kecerdasan Buatan',
    description: 'Mengenal AI dan machine learning.',
    icon: Icons.psychology_rounded,
    color: Color(0xFFEF6C00),
  ),
  Course(
    code: 'RPL005',
    name: 'Rekayasa Perangkat Lunak',
    description: 'Mempelajari analisis dan pengembangan perangkat lunak.',
    icon: Icons.code_rounded,
    color: Color(0xFF00897B),
  ),
];

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F7FC),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF1976D2),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const CourseExplorerPage(),
    );
  }
}

class CourseExplorerPage extends StatefulWidget {
  const CourseExplorerPage({super.key});

  @override
  State<CourseExplorerPage> createState() =>
      _CourseExplorerPageState();
}

class _CourseExplorerPageState extends State<CourseExplorerPage> {
  int selectedIndex = 0;

  // Shared state: satu sumber data favorit untuk beberapa halaman.
  final Set<String> favorites = {};

  void toggleFavorite(String courseCode) {
    setState(() {
      if (favorites.contains(courseCode)) {
        favorites.remove(courseCode);
      } else {
        favorites.add(courseCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 840;

    // Dua child menerima shared state dan callback dari parent.
    final pages = [
      HomePage(
        favorites: favorites,
        onFavoriteToggle: toggleFavorite,
      ),
      CoursesPage(
        favorites: favorites,
        onFavoriteToggle: toggleFavorite,
      ),
      const ProfilePage(),
    ];

    final titles = [
      'Course Explorer',
      'Daftar Mata Kuliah',
      'Profil Mahasiswa',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  profileImage,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
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
          if (isWide) const VerticalDivider(width: 1),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: pages,
            ),
          ),
        ],
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
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteToggle;

  const HomePage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.waving_hand_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Halo, $studentName!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Yuk, jelajahi mata kuliah dan kembangkan kemampuanmu.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'NIM: $studentId',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Ringkasan Belajar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Mata Kuliah',
                  value: '${courses.length}',
                  icon: Icons.menu_book_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Favorit',
                  value: '${favorites.length}',
                  icon: Icons.favorite_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Mata Kuliah',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ...courses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CourseCard(
                course: course,
                isFavorite: favorites.contains(course.code),
                onFavoriteToggle: () => onFavoriteToggle(course.code),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteToggle;

  const CoursesPage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1100 ? 3 : (width >= 600 ? 2 : 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semua Mata Kuliah',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '${courses.length} mata kuliah • ${favorites.length} favorit',
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 180,
            ),
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCard(
                course: course,
                isFavorite: favorites.contains(course.code),
                onFavoriteToggle: () =>
                    onFavoriteToggle(course.code),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF1976D2), size: 28),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF17365D),
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// Child menerima nilai favorit dan callback melalui constructor.
class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: course.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  course.icon,
                  color: course.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF17365D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Kode: ${course.code}'),
                    const SizedBox(height: 5),
                    Text(
                      '3 SKS',
                      style: TextStyle(
                        color: course.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite ? 'Hapus favorit' : 'Tambah favorit',
                onPressed: onFavoriteToggle,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavorite ? Colors.redAccent : Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  void _showFeedbackDialog(BuildContext context) {
    final controller = TextEditingController();
    String? errorMessage;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Kirim Feedback'),
              content: TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tulis feedback di sini...',
                  border: const OutlineInputBorder(),
                  errorText: errorMessage,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Batal'),
                ),
                FilledButton(
                  onPressed: () {
                    if (controller.text.trim().length < 5) {
                      setDialogState(() {
                        errorMessage = 'Feedback minimal 5 karakter.';
                      });
                    } else {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Terima kasih atas feedback kamu!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Kirim'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mata Kuliah')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(course.icon, color: Colors.white, size: 42),
                  const SizedBox(height: 16),
                  Text(
                    course.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kode mata kuliah: ${course.code}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Deskripsi Mata Kuliah',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              course.description,
              style: const TextStyle(height: 1.7),
            ),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF1976D2),
                ),
                title: Text('Informasi Pembelajaran'),
                subtitle: Text('Jumlah beban pembelajaran: 3 SKS'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _showFeedbackDialog(context),
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Berikan Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    profileImage,
                    width: 116,
                    height: 116,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const CircleAvatar(
                      radius: 58,
                      child: Icon(Icons.person, size: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  studentName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'NIM: $studentId',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Mahasiswa',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.badge_outlined),
                  title: Text('Nama Lengkap'),
                  subtitle: Text(studentName),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.numbers),
                  title: Text('Nomor Induk Mahasiswa'),
                  subtitle: Text(studentId),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.school_outlined),
                  title: Text('Status'),
                  subtitle: Text('Mahasiswa Aktif'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.menu_book),
                  title: Text('Aplikasi'),
                  subtitle: Text('Course Explorer'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Terus belajar dan kembangkan kemampuanmu!'),
        ],
      ),
    );
  }
}

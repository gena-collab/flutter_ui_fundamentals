import 'package:flutter/material.dart';
import 'services.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter UI Fundamentals',
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  // Reusable bagian 1: Summary Card
  Widget buildSummaryCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable bagian 2: Course Card
  Widget buildCourseCard(
    Map<String, dynamic> course,
  ) {
    final bool isDone = course['status'] == 'Selesai';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          isDone
              ? Icons.check_circle
              : Icons.schedule,
        ),
        title: Text(
          course['title'] as String,
        ),
        subtitle: Text(
          '${course['code']} • '
          '${course['credits']} SKS\n'
          'Kategori: ${course['category']}',
        ),
        isThreeLine: true,
        trailing: Text(
          course['status'] as String,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Terjadi error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Data tidak tersedia
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          final Map<String, dynamic> data =
              snapshot.data!;

          final String name =
              data['studentName'] as String;

          final String id =
              data['studentId'] as String;

          final List<Map<String, dynamic>> courses =
              (data['courses'] as List)
                  .map(
                    (item) =>
                        item as Map<String, dynamic>,
                  )
                  .toList();

          final int totalCredits = courses.fold(
            0,
            (sum, item) =>
                sum + (item['credits'] as int),
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profile
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      'assets/images/profile.jpeg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(id),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Summary
              Row(
                children: [
                  buildSummaryCard(
                    'Total Mata Kuliah',
                    '${courses.length}',
                    Icons.book,
                  ),
                  const SizedBox(width: 8),
                  buildSummaryCard(
                    'Total SKS',
                    '$totalCredits',
                    Icons.school,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Daftar Mata Kuliah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Course list
              ...courses.map(
                (course) => buildCourseCard(course),
              ),
            ],
          );
        },
      ),
    );
  }
}
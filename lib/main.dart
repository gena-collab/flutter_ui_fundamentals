import 'package:flutter/material.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

const String studentName = 'Gena Anggarani';
const String studentId = '2415051038';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseGridPage(),
    );
  }
}

class CourseGridPage extends StatelessWidget {
  const CourseGridPage({super.key});

  final List<Map<String, String>> courses = const [
    {
      'title': 'Pemrograman Mobile',
      'code': 'PM001',
      'credits': '3 SKS',
    },
    {
      'title': 'Pemrograman Web',
      'code': 'PW002',
      'credits': '3 SKS',
    },
    {
      'title': 'Basis Data',
      'code': 'BD003',
      'credits': '3 SKS',
    },
    {
      'title': 'Rekayasa Perangkat Lunak',
      'code': 'RPL004',
      'credits': '3 SKS',
    },
    {
      'title': 'Kecerdasan Buatan',
      'code': 'AI005',
      'credits': '3 SKS',
    },
    {
      'title': 'Interaksi Manusia dan Komputer',
      'code': 'IMK006',
      'credits': '2 SKS',
    },
  ];

  int getCrossAxisCount(double width) {
    if (width < 600) {
      return 1;
    } else if (width < 840) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5 - GridView'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = getCrossAxisCount(constraints.maxWidth);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  '$studentId - $studentName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.school,
                                size: 40,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                course['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(course['code']!),
                              Text(course['credits']!),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
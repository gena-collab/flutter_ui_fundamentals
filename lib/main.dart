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
      home: CourseInteractionPage(),
    );
  }
}

class CourseInteractionPage extends StatefulWidget {
  const CourseInteractionPage({super.key});

  @override
  State<CourseInteractionPage> createState() =>
      _CourseInteractionPageState();
}

class _CourseInteractionPageState extends State<CourseInteractionPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: Padding(
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
            const SizedBox(height: 24),
            CourseCard(
              title: 'Pemrograman Mobile',
              code: 'PM001',
              isFavorite: isFavorite,
              onFavoritePressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Course Pemrograman Mobile dipilih'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onLongPress;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.menu_book,
                size: 50,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Kode: $code'),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavoritePressed,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                tooltip: 'Favorite',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
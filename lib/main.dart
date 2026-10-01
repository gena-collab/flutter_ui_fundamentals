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
      home: ResponsiveRowPage(),
    );
  }
}

class ResponsiveRowPage extends StatelessWidget {
  const ResponsiveRowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4 - Row & Wrap'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Pembagian Ruang dengan Expanded',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: const Text(
                      'Skill Utama',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: const Text(
                      'Skill Lain',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Skills',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('UI/UX')),
                Chip(label: Text('Firebase')),
                Chip(label: Text('Git')),
                Chip(label: Text('Figma')),
                Chip(label: Text('Android')),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Wrap digunakan agar Chip dapat berpindah ke baris berikutnya '
              'ketika ruang layar tidak mencukupi.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
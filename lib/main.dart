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
      home: LayoutBuilderPage(),
    );
  }
}

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3 - LayoutBuilder'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const CompactLayout();
          } else if (constraints.maxWidth < 840) {
            return const MediumLayout();
          } else {
            return const ExpandedLayout();
          }
        },
      ),
    );
  }
}

class CompactLayout extends StatelessWidget {
  const CompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      'Compact Layout',
      'Lebar layar kurang dari 600',
      Icons.phone_android,
    );
  }
}

class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      'Medium Layout',
      'Lebar layar 600 sampai 839',
      Icons.tablet,
    );
  }
}

class ExpandedLayout extends StatelessWidget {
  const ExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      'Expanded Layout',
      'Lebar layar 840 atau lebih',
      Icons.desktop_windows,
    );
  }
}

Widget _buildLayout(
  String title,
  String description,
  IconData icon,
) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Icon(icon, size: 70),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
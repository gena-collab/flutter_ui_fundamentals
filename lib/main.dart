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
      home: MediaQueryPage(),
    );
  }
}

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final String screenType =
        size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2 - MediaQuery'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  const SizedBox(height: 20),
                  Text('Width: ${size.width.toStringAsFixed(0)}'),
                  Text('Height: ${size.height.toStringAsFixed(0)}'),
                  Text('Orientation: $orientation'),
                  Text('Tipe Layar: $screenType'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../student_info.dart';
import '../widgets/blue_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BlueHeader(
          title: 'Profil Mahasiswa',
          subtitle: 'Informasi akun Course Explorer.',
        ),
        const SizedBox(height: 30),
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
              const SizedBox(height: 18),
              Text(
                studentName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'NIM: $studentId',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Card(
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.blue),
                  title: Text('Mahasiswa'),
                  subtitle: Text('Course Explorer'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../student_info.dart';
import '../widgets/blue_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal logout: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? '-';

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
                backgroundImage:
                    AssetImage('assets/images/profile.jpeg'),
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
              Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.blue,
                      ),
                      title: Text('Mahasiswa'),
                      subtitle: Text('Course Explorer'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.email_outlined,
                        color: Colors.blue,
                      ),
                      title: const Text('Email Akun'),
                      subtitle: Text(email),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

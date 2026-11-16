
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../student_info.dart';
import '../widgets/blue_header.dart';
import '../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();

  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getMyProfile();
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal logout: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const BlueHeader(
          title: 'Profil Pengguna',
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

              FutureBuilder<UserProfile?>(
                future: _profileFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(
                      'Gagal memuat profil: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    );
                  }

                  final profile = snapshot.data;

                  if (profile == null) {
                    return const Text(
                      'Data profil tidak ditemukan.',
                    );
                  }

                  return Column(
                    children: [
                      Text(
                        profile.name.isNotEmpty
                            ? profile.name
                            : studentName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'NIM: $studentId',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.person_outline,
                                color: Colors.blue,
                              ),
                              title: const Text('Nama Lengkap'),
                              subtitle: Text(profile.name),
                            ),
                            const Divider(height: 1),

                            ListTile(
                              leading: const Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                              ),
                              title: const Text('Email Akun'),
                              subtitle: Text(profile.email),
                            ),
                            const Divider(height: 1),

                            ListTile(
                              leading: const Icon(
                                Icons.verified_user_outlined,
                                color: Colors.blue,
                              ),
                              title: const Text('Role Pengguna'),
                              subtitle: Text(profile.roleLabel),
                            ),
                            const Divider(height: 1),

                            const ListTile(
                              leading: Icon(
                                Icons.school,
                                color: Colors.blue,
                              ),
                              title: Text('Aplikasi'),
                              subtitle: Text('Course Explorer'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
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

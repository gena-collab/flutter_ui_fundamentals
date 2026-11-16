
import 'package:supabase_flutter/supabase_flutter.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class UserProfile {
  final String id;
  final String email;
  final String name;
  final String role;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      id: data['id']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      role: data['role']?.toString() ?? 'seeker',
    );
  }

  String get roleLabel {
    switch (role) {
      case 'owner':
        return 'Owner (Penyedia Kursus)';
      case 'admin':
        return 'Admin';
      default:
        return 'Seeker (Pencari Kursus)';
    }
  }
}

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  Future<UserProfile?> getMyProfile() async {
    final user = currentUser;

    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    return UserProfile.fromMap(response);
  }

  Future<String?> get currentUserRole async {
    final profile = await getMyProfile();
    return profile?.role;
  }
}

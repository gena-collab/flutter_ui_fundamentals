
import 'package:supabase_flutter/supabase_flutter.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Mengambil pengguna yang sedang login
  User? get currentUser => _supabase.auth.currentUser;

  // Mengambil status sesi login
  Session? get currentSession => _supabase.auth.currentSession;

  // Mendengarkan perubahan status autentikasi
  Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;

  // Registrasi pengguna baru
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
      },
    );
  }

  // Login pengguna
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Logout pengguna
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Mengambil profil pengguna berdasarkan ID
  Future<Map<String, dynamic>?> getProfile() async {
    final user = currentUser;

    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    return response;
  }
}

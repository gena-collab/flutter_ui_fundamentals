
import 'package:supabase_flutter/supabase_flutter.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  Session? get currentSession => _supabase.auth.currentSession;

  Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;

  bool get isLoggedIn => currentSession != null;

  Future<AuthResponse> register({
    required String email,
    required String password,
    String name = '',
    String role = 'seeker',
  }) async {
    // Role yang boleh dipilih melalui aplikasi hanya seeker dan owner.
    final selectedRole =
        role == 'owner' ? 'owner' : 'seeker';

    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'role': selectedRole,
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

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

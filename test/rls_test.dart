import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../lib/supabase_config.dart';

void main() {
  test('RLS menolak INSERT tanpa izin', () async {
    final client = SupabaseClient(
      SupabaseConfig.supabaseUrl,
      SupabaseConfig.supabaseAnonKey,
    );

    try {
      await client.from('courses_rls_test').insert({
        'id': 999999,
        'title': 'Data pengujian RLS',
      });
      fail('INSERT berhasil, padahal akses seharusnya ditolak.');
    } on PostgrestException catch (e) {
      expect(e.code, '42501');
    } finally {
      client.dispose();
    }
  });
}

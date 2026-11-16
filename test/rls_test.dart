
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_ui_fundamentals/supabase_config.dart';

void main() {
  test('RLS menolak INSERT dari pengguna anonim', () async {
    final client = SupabaseClient(
      SupabaseConfig.supabaseUrl,
      SupabaseConfig.supabaseAnonKey,
    );

    try {
      await client.from('courses').insert({
        'code': 'RLS-TEST-${DateTime.now().microsecondsSinceEpoch}',
        'title': 'Data Pengujian RLS',
        'credits': 3,
        'status': 'Aktif',
      });

      fail('INSERT berhasil, padahal pengguna anonim tidak diizinkan.');
    } on PostgrestException catch (e) {
      expect(e.code, '42501');
    } finally {
      await client.dispose();
    }
  });
}

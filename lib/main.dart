
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'course_state.dart';
import 'supabase_config.dart';
import 'services/course_api_service.dart';
import 'services/course_data_source.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/course_explorer_page.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabaseAnonKey,
  );

  const String apiBaseUrl =
      'https://course-api-pearl.vercel.app';

  final CourseDataSource dataSource =
      CourseApiService(apiBaseUrl);

  final repository = CourseRepository(dataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CourseState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CourseProvider(repository)..loadCourses(),
        ),
      ],
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
      ),
      home: const CourseExplorerPage(),
    );
  }
}

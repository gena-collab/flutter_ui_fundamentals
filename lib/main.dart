
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'course_state.dart';
import 'supabase_config.dart';
import 'services/course_data_source.dart';
import 'services/course_supabase_service.dart';
import 'services/notification_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/auth_gate.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Mendaftarkan background notification handler
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabaseAnonKey,
  );

  final CourseDataSource dataSource = CourseSupabaseService();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
      ),
      home: const AuthGate(),
    );
  }
}

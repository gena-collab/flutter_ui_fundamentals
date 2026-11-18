
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel(
  'course_explorer_channel',
  'Course Explorer Notifications',
  description: 'Notifikasi pengingat belajar Course Explorer',
  importance: Importance.max,
);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('[BACKGROUND] Notification received');
  debugPrint('title: ${message.notification?.title}');
  debugPrint('body: ${message.notification?.body}');
  debugPrint('data: ${message.data}');
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  StreamSubscription<String>? _registrationSubscription;

  Future<void>? _initFuture;

  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: '
      '${settings.authorizationStatus.name}',
    );

    return settings.authorizationStatus;
  }

  void listenTokenRefresh(
    void Function(String token) onRefresh,
  ) {
    _registrationSubscription?.cancel();

    _registrationSubscription = _messaging.onRegistered.listen(
      (installationId) {
        debugPrint('Firebase Installation ID: $installationId');
        onRefresh(installationId);
      },
      onError: (error) {
        debugPrint('Gagal mendapatkan Installation ID: $error');
      },
    );
  }

  Future<void> registerDevice() async {
    try {
      await _messaging.register();
      debugPrint('FCM device registration berhasil.');
    } catch (e) {
      debugPrint('FCM device registration gagal: $e');
    }
  }

  Future<void> init() {
    return _initFuture ??= _initialize();
  }

  Future<void> _initialize() async {
    try {
      await requestPermission();

      const initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      );

      await _localNotifications.initialize(
        settings: initializationSettings,
      );

      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin?.createNotificationChannel(
        notificationChannel,
      );

      listenTokenRefresh((installationId) {
        debugPrint('FID berhasil diterima dari Firebase.');
      });

      await registerDevice();

      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          debugPrint('[FOREGROUND] Notification received');
          debugPrint('title: ${message.notification?.title}');
          debugPrint('body: ${message.notification?.body}');
          debugPrint('data: ${message.data}');

          if (message.notification != null) {
            await showNotification(
              title: message.notification?.title ?? 'Course Explorer',
              body: message.notification?.body ?? '',
            );
          }
        },
        onError: (error) {
          debugPrint('Foreground notification error: $error');
        },
      );

      debugPrint('NotificationService berhasil diinisialisasi.');
    } catch (e) {
      debugPrint('Inisialisasi NotificationService gagal: $e');
      _initFuture = null;
    }
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'course_explorer_channel',
        'Course Explorer Notifications',
        channelDescription:
            'Notifikasi pengingat belajar Course Explorer',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}

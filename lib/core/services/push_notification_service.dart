import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hangangramyeon/core/services/local_notifications_service.dart';

// Top-level background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final notification = message.notification;
  if (notification != null) {
    await LocalNotificationService().showInstant(
      notification.title ?? 'Hangang Ramyeon',
      notification.body ?? '',
    );
  }
}

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _local = LocalNotificationService();

  Future<void> init() async {
    await Firebase.initializeApp();

    // Request permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token (optional: log or send to server)
    await _messaging.getToken();

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      if (notification != null) {
        await _local.showInstant(
          notification.title ?? 'Hangang Ramyeon',
          notification.body ?? '',
        );
      }
    });

    // Background/terminated
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}



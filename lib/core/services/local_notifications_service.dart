import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/foundation.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        "@mipmap/ic_launcher",
      ),
      iOS: DarwinInitializationSettings(),
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );
  }

  static Future<void> _onTap(NotificationResponse response) async {
    if (response.payload != null) {}
  }

  Future<void> scheduleNotification(
    String title,
    String body,
    DateTime date,
    int reminder,
  ) async {
    // Generate a unique notification ID from title and date
    int notificationId = title.hashCode;

    await cancelNotification(notificationId);
    final androidDetails = AndroidNotificationDetails(
      'id_1',
      'Basic Channel',
      importance: Importance.max,
      priority: Priority.max,
      largeIcon: const DrawableResourceAndroidBitmap('background'),
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(date.subtract(Duration(minutes: reminder)), tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> showInstant(String title, String body, {String? payload}) async {
    final androidDetails = AndroidNotificationDetails(
      'id_1',
      'Basic Channel',
      importance: Importance.max,
      priority: Priority.max,
      largeIcon: const DrawableResourceAndroidBitmap('background'),
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}

// Notification Alert System

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('cloudy');

  // Ask permission from user to show notification
  void initializeNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // if rain chances are equal or more than 50% then it should alert User
  void sendNotification(
      String title, String body, double? rainPrediction) async {
    if (rainPrediction! >= 50.0) {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              'channelId', 'channelName', 'channelDescription',
              importance: Importance.max, priority: Priority.high);

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      flutterLocalNotificationsPlugin.show(
          0321, title, body, notificationDetails);
    }
  }
}

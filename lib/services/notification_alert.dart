import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('cloudy');

  void initializeNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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

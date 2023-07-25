import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings initializationSettingsAndroidIOS = DarwinInitializationSettings();

  const  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsAndroidIOS
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotificacion(String titulo, String data) async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'channel_name');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails
  );

  await flutterLocalNotificationsPlugin.show(1, titulo, data, notificationDetails);
}
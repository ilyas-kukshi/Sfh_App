import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String sendMessageUrl = "https://fcm.googleapis.com/fcm/send";
  requestPermission() async {
    FirebaseMessaging.instance.requestPermission(sound: true);
  }

  void displayForegroundNotification(RemoteMessage message) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        color: AppThemeShared.primaryColor,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      1,
      message.notification?.title ?? 'Default Title',
      message.notification?.body ?? 'Default Body',
      platformChannelSpecifics,
      payload: message.data['data'] ?? '',
    );
  }

  Future<String> getDeviceToken() async {
    String? token = messaging.getToken().toString();
    messaging.subscribeToTopic('all');
    return token;
  }

  isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void notificationTapBackground(NotificationResponse message) async {
    // print("myBackgroundMessageHandler message: $message");
    // int msgId = int.tryParse(message["data"]["msgId"].toString()) ?? 0;
    // print("msgId $msgId");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        color: AppThemeShared.primaryColor,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics
    );
    // await serviceLocatorInstance<NotificationService>().showNotificationWithDefaultSound(message);
    await flutterLocalNotificationsPlugin
        .show(1, "Test", "Notification", platformChannelSpecifics, payload: "");
  }

  sendToAll() async {
    try {
      var response = await http.post(Uri.parse(sendMessageUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Constants.notificationServerKey}'
          },
          body: jsonEncode({
            "to": "/topics/all",
            "notification": {"body": "subject", "title": "title"}
          }));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Notification Sent");
        // print(response);
      } else {
        Fluttertoast.showToast(msg: response.toString());
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Notification:$error");
      // print(error);
    }
  }
}

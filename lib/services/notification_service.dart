import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
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
      'com.com.example.sfh_app.notifications.general',
      'General Notifications',
      color: AppThemeShared.primaryColor,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
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

  handleNotificationPayload(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) async {
    Fluttertoast.showToast(msg: message.data.toString());

    if (message.data.isNotEmpty) {
      switch (message.data["type"]) {
        case "category":
          {
            CategoryModel? category =
                await CategoryServices().getById(message.data["categoryId"]);

            if (category != null) {
              if (navigatorKey.currentState != null) {
                navigatorKey.currentState?.pushNamed(
                    '/displayProductsByCategory',
                    arguments: category);
              }
              // NavigationService()
              //     .navigateTo('/displayProductsByCategory', arguments: category);
            }
          }
          break;
        default:
      }
    }
  }
  // void notificationTapBackground(NotificationResponse message) async {
  //   // print("myBackgroundMessageHandler message: $message");
  //   // int msgId = int.tryParse(message["data"]["msgId"].toString()) ?? 0;
  //   // print("msgId $msgId");
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your channel id', 'your channel name',
  //       color: AppThemeShared.primaryColor,
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //   // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     // iOS: iOSPlatformChannelSpecifics
  //   );
  //   // await serviceLocatorInstance<NotificationService>().showNotificationWithDefaultSound(message);
  //   await flutterLocalNotificationsPlugin
  //       .show(1, "Test", "Notification", platformChannelSpecifics, payload: "");
  // }

  sendToAll() async {
    try {
      var response = await http.post(Uri.parse(sendMessageUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Constants.notificationServerKey}'
          },
          body: jsonEncode({
            "to": "/topics/all",
            "notification": {
              "title": "title",
              "body": "subject",
            },
            "data": {"type": "category", "category": "28342893427482"}
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

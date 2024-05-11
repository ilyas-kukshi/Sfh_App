import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/main.dart';
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
      'com.com.nexsolve.sfh.notifications.general',
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
      payload: jsonEncode(message.data),
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

  catchNotification() {
    //When a new notification message is received
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Display notifications received when app is in foreground
      NotificationService().displayForegroundNotification(message);
    });
    //when app is in BACKGROUND and opened through notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      firebaseMessagingBackgroundHandler(message);
    });
    //when app is TERMINATED and opened through notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        firebaseMessagingBackgroundHandler(message);
      }
    });
  }

  static handleNotificationPayload(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) async {
    // Fluttertoast.showToast(msg: message.data.toString());

    if (message.data.isNotEmpty) {
      switch (message.data["type"]) {
        case "category":
          {
            CategoryModel? category =
                await CategoryServices().getById(message.data["category"]);

            if (category != null) {
              if (navigatorKey.currentState != null) {
                navigatorKey.currentState?.pushNamed(
                    '/displayProductsByCategory',
                    arguments: category);
              }
            }
          }
          break;
          case "tag":
          {
            // TagModel? category =
            //     await TagServices().getById(message.data["tag"]);

            // if (category != null) {
            //   if (navigatorKey.currentState != null) {
            //     navigatorKey.currentState?.pushNamed(
            //         '/displayProductsByCategory',
            //         arguments: category);
            //   }
            // }
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
            "data": {"type": "category", "category": "65accde3ce6169072cfb2073"}
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

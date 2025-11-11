import 'dart:convert';
import 'package:espitaliaa_doctors/pages/appointment/appointment_page.dart';
import 'package:espitaliaa_doctors/pages/offers/main_offers_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatformSpecifics() async {
    _requestIOSPermission();
    var initializationSettingsAndroid = AndroidInitializationSettings("ws");

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification
        //  selectNotificationSubject.add(payload);
        );
  }

  Future<void> selectNotification(payload) async {
    if (payload != null) {
      var data = json.decode(payload);
      if (data['action_type'] != null) {
        if (data['action_type'] == 'appointment' ||
            data['action_type'] == 'cancel_appointment') {
          Get.to(AppointmentPage());
        } else if (data['action_type'] == 'active_offer' ||
            data['action_type'] == 'offer') {
          Get.to(MainOffersPage());
        } else {
          print("Selected from another message");
        }
        // Get.to(OrderDetailsPage(id: data['order_id']));
      }
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidChannelSpecifics =
        const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      // timeoutAfter: 5000,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      '${message.notification.title}', // Notification Title
      '${message.notification.body}',
      // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: json.encode(message.data), // Notification Payload
    );
  }
}

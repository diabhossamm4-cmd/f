import 'package:espitaliaa_doctors/utils/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FireBaseCongigFile {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  config() async {
    await Firebase.initializeApp();

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  initFirebaseMessages() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        /*       Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));*/

        print("HelloWorld");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new event was published! = ${message.data}');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        NotificationPlugin().showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published! message');
      /* Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true))*/

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        NotificationPlugin().showNotification(message);
      }
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('A new event was published! from background');

/*  await Firebase.initializeApp();
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;
  if (notification != null && android != null) {
    //NotificationPlugin().showNotification(message);
  }*/
}

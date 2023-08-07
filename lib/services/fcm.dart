import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:texno_bozor/services/local_notification_service.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  await FirebaseMessaging.instance.subscribeToTopic("news");

  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in foreground");
    LocalNotificationService.instance.showFlutterNotification(message);

  });

  // BACkGROUND MESSAGE HANDLING
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FROM TERMINATED MODE

  handleMessage(RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.data["news_image"]} va ${message.notification!.title} in terminated");
    LocalNotificationService.instance.showFlutterNotification(message);
  }

  RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handleMessage(remoteMessage);
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in background");
}




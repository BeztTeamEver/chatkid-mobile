import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Message: ${message.data}');
}

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseInAppMessaging = FirebaseInAppMessaging.instance;

  Future<void> getToken() async {
    await _firebaseMessaging.getToken();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Message: ${message.data}');
    });
  }

  Future<void> getInAppId() async {
    final appId = await _firebaseInAppMessaging;
    print('InAppId: ${appId}');
  }
}

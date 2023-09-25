import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Message: ${message.data}');
}

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> getToken() async {
    await _firebaseMessaging.getToken();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

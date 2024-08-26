import 'dart:convert';

import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/constants/notification.dart';
import 'package:chatkid_mobile/firebase_options.dart';
import 'package:chatkid_mobile/pages/chats/group_chat_page.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatkid_mobile/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class FirebaseService {
  String? fcmToken = "";
  String? appId = "";
  static BuildContext? _context;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseService? _instance;

  FirebaseService._interal() {
    FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  }

  setContent(BuildContext context) {
    _context = context;
  }

  static FirebaseService get instance {
    _instance ??= FirebaseService._interal();
    return _instance!;
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    Logger().i("Handling a background message: ${message.messageId}");
  }

  Future<void> init() async {
    // await _firebaseAuth.useAuthEmulator('localhost', 9099);

    final permission = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      provisional: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );
    if (permission == null || permission == false) {
      throw Exception("Không thể cấp quyền thông báo");
    }
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getFCMToken() async {
    try {
      fcmToken = await _firebaseMessaging.getToken();

      appId = fcmToken?.split(':').first ?? "";
      Logger().i('FCM Token: $fcmToken');
      // FirebaseMessaging.onBackgroundMessage(
      //     (message) => _firebaseMessagingBackgroundHandler(message));
      return fcmToken ?? '';
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Logger().e(e);
      throw Exception("Lỗi đăng nhập tới Google, vui lòng thử lại sau");
    }
  }

  void handleMessage(RemoteMessage message) {
    Logger().i('Got a message whilst in the foreground!');
    Logger().i('Message data: ${message.data}');
    if (message.notification != null) {
      Logger()
          .i('Message also contained a notification: ${message.notification}');
    }

    switch (message.data['type']) {
      case NotificationTypeConstants.CHAT:
        handleChatNotification(message);
        break;
      case NotificationTypeConstants.TARGET:
        Logger().i("Notification message");
        break;
      default:
        Logger().i("Default message");
        break;
    }
  }

  Future<void> handleChatNotification(RemoteMessage message) async {
    final data = message.data;
    final channel = await FamilyService().getFamilyChannel();
    Navigator.of(_context!)
        .push(createRoute(() => GroupChatPage(channelId: channel.id)));
  }

  void handleGetNotification(GlobalKey<NavigatorState> navigatorKey) {
    // Handle notification when app is in background
    FirebaseMessaging.onBackgroundMessage((RemoteMessage? message) async {
      if (message == null) {
        return;
      }
      await _firebaseMessagingBackgroundHandler(message);
      // showDialog(
      //     context: navigatorKey.currentContext!,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('A new FCM message arrived!'),
      //         content: Text('This is a FCM message background'),
      //       );
      //     });
    });

    // Handle notification when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message == null) {
        return;
      }
      Logger().i("Message app: ${message.messageId}");
      ShowToast.success(msg: "A new FCM message arrived!");

      handleMessage(message);
      // Navigator.of(_context!).push(createRoute(
      //     () => GroupChatPage(channelId: message.data['channelId'])));
    });

    // Handle notification when open app from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message == null) {
        return;
      }
      Logger().i("Message opened app: ${message.messageId}");

      // showDialog(
      //     context: navigatorKey.currentContext!,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('A new FCM message arrived!'),
      //         content: Text('This is a FCM message background'),
      //       );
      //     });
      handleMessage(message);
      // Navigator.of(_context!).push(createRoute(
      //     () => GroupChatPage(channelId: message.data['channelId'])));
      // Logger().i("Route name: ${ModalRoute.of(_context!)?.settings.name}");
    });
  }

  void authStateChanges(Function(User?) callback) {
    _firebaseAuth.authStateChanges().listen((User? user) {
      callback(user);
    });
  }

  void idTokenChanges(Function(User?) callback) {
    _firebaseAuth.idTokenChanges().listen((User? user) {
      callback(user);
    });
  }

  void userChanges(Function(User?) callback) {
    _firebaseAuth.userChanges().listen((User? user) {
      callback(user);
    });
  }

  Future<void> signOut() async {
    await AuthService.logoutMember(fcmToken ?? "");
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}

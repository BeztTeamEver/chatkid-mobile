import 'package:chatkid_mobile/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatkid_mobile/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class FirebaseService {
  String? fcmToken = "";
  String? appId = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseService? _instance;

  FirebaseService._interal() {
    FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  }

  static FirebaseService get instance {
    _instance ??= FirebaseService._interal();
    return _instance!;
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  Future<void> init() async {
    // await _firebaseAuth.useAuthEmulator('localhost', 9099);
    await _firebaseMessaging.requestPermission();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<String?> getFCMToken() async {
    try {
      fcmToken = await _firebaseMessaging.getToken();

      appId = fcmToken?.split(':').first ?? "";
      FirebaseMessaging.onBackgroundMessage(
          (message) => _firebaseMessagingBackgroundHandler(message));
      return fcmToken ?? '';
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
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
      Logger().e(e.toString());
      throw Exception("Lỗi đăng nhập tới Google, vui lòng thử lại sau");
    }
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
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}

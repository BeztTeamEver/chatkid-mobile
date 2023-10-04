import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      RemoteMessage message) async {
    print('Title: ${message.notification!.title}');
    print('Body: ${message.notification!.body}');
    print('Message: ${message.data}');
  }

  Future<void> initAuth() async {
    // await _firebaseAuth.useAuthEmulator('localhost', 9099);
  }

  Future<void> getFCMToken() async {
    fcmToken = await _firebaseMessaging.getToken();

    appId = fcmToken?.split(':').first ?? "";
    FirebaseMessaging.onBackgroundMessage(
        (message) => _firebaseMessagingBackgroundHandler(message));
  }

  Future<UserCredential> signInWithGoogle() async {
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

    print(credential.accessToken);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
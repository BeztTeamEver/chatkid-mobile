// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALTCf2PvgmVYjtrPDfr2J_ei_lrPPGcI4',
    appId: '1:343387729372:web:2c8e52325ae2de61f6f319',
    messagingSenderId: '343387729372',
    projectId: 'kidtalkie-979b7',
    authDomain: 'kidtalkie-979b7.firebaseapp.com',
    databaseURL: 'https://kidtalkie-979b7-default-rtdb.firebaseio.com',
    storageBucket: 'kidtalkie-979b7.appspot.com',
    measurementId: 'G-WRNGW3TDDY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPmoK9aQZkSuBScfKh8mEXSGagVt86qf4',
    appId: '1:343387729372:android:7e9cb49bd04ea8f3f6f319',
    messagingSenderId: '343387729372',
    projectId: 'kidtalkie-979b7',
    databaseURL: 'https://kidtalkie-979b7-default-rtdb.firebaseio.com',
    storageBucket: 'kidtalkie-979b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4mS-ti-4R6QNV6XuJGqSgVYADmkRNTIQ',
    appId: '1:343387729372:ios:842cca52fb5178b9f6f319',
    messagingSenderId: '343387729372',
    projectId: 'kidtalkie-979b7',
    databaseURL: 'https://kidtalkie-979b7-default-rtdb.firebaseio.com',
    storageBucket: 'kidtalkie-979b7.appspot.com',
    androidClientId: '343387729372-0stfbn846d23h40r5v93eijf1adgsfhq.apps.googleusercontent.com',
    iosClientId: '343387729372-hq1dklb4cpo7cdufmep0fqsbj97ef016.apps.googleusercontent.com',
    iosBundleId: 'com.kidtalkie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4mS-ti-4R6QNV6XuJGqSgVYADmkRNTIQ',
    appId: '1:343387729372:ios:3825a9188ab41ce2f6f319',
    messagingSenderId: '343387729372',
    projectId: 'kidtalkie-979b7',
    databaseURL: 'https://kidtalkie-979b7-default-rtdb.firebaseio.com',
    storageBucket: 'kidtalkie-979b7.appspot.com',
    androidClientId: '343387729372-0stfbn846d23h40r5v93eijf1adgsfhq.apps.googleusercontent.com',
    iosClientId: '343387729372-nb73qt631kiielr499f7l68nah3adl5c.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatkidMobile.RunnerTests',
  );
}

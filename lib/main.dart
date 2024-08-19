import 'package:chatkid_mobile/pages/splash_pages.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/notification_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/camera_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:modals/modals.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env file
  await dotenv.load(fileName: ".env");
  //Firesbase setup
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseService = FirebaseService.instance;
  final ttsService = TtsService().instance;
  await firebaseService.init();
  await firebaseService.getFCMToken();
  await CameraService().init();

  // tts service setup
  await TtsService().initState();
  // share preferrence setup for one time page
  await LocalStorage.getInstance();
  firebaseService.handleGetNotification(navigatorKey);
  SocketService();
  CacheManager.logLevel = CacheManagerLogLevel.verbose;
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(MeController());
    Get.put(NotificationController());

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'KidTalkie',
      color: primary,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: secondary,
          primarySwatch: primary,
          backgroundColor: primary.shade50,
          errorColor: Colors.green.shade100,
          brightness: Brightness.light,
        ),
        textTheme: textTheme,
        primarySwatch: primary,
        shadowColor: HexColor('4E291414'),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (states) => primary.shade100,
            ),
            surfaceTintColor: MaterialStateColor.resolveWith(
              (states) => Colors.transparent,
            ),
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.white,
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => primary.shade400,
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          height: 80,
          indicatorColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(
            textTheme.bodySmall!.copyWith(
              color: neutral.shade800,
              fontSize: 10,
            ),
          ),
        ),
        cardTheme: CardTheme(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        scaffoldBackgroundColor: primary.shade50,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFFE8EAF1), width: 3),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: neutral.shade400,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: red.shade100,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: red.shade100,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: primary.shade400,
              width: 1,
            ),
          ),
          errorStyle: textTheme.bodyMedium!.copyWith(
            color: red.shade800,
          ),
          contentPadding: const EdgeInsets.only(
            left: 22,
            top: 14,
            bottom: 14,
            right: 18,
          ),
          fillColor: Colors.transparent,
          hintStyle: TextStyle(
            color: neutral.shade400,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPages(),
      builder: (context, widget) {
        ErrorWidget.builder = (errorDetails) {
          errorDetails.printError();
          return Center(
            child: Text(
              'Something went wrong',
              style: textTheme.bodyMedium!.copyWith(
                color: red.shade800,
              ),
            ),
          );
        };
        if (widget != null) return widget;
        throw StateError('widget is null');
      },
      // routes: routes,
    );
  }
}

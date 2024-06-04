import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/bot/bot_asset.dart';
import 'package:chatkid_mobile/pages/bot/bot_asset_store.dart';
import 'package:chatkid_mobile/pages/splash_pages.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

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

  // tts service setup
  await TtsService().initState();
  // share preferrence setup for one time page
  await LocalStorage.getInstance();

  SocketService();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const BotAssetStore(),
      // home: const SplashPages(),
      routes: routes,
    );
  }
}

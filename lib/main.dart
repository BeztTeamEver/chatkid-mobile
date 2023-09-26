import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/login_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().getInAppId();
  await FirebaseService().getToken();

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
          primarySwatch: primary,
          backgroundColor: primary.shade50,
          errorColor: Colors.green.shade100,
          brightness: Brightness.light,
        ),
        textTheme: textTheme,
        primarySwatch: primary,
        shadowColor: HexColor('4E291414'),
        scaffoldBackgroundColor: primary.shade50,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFFE8EAF1), width: 3),
          ),
          filled: true,
          contentPadding: const EdgeInsets.only(
            left: 26,
            top: 28,
            bottom: 28,
          ),
          fillColor: neutral.shade50,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

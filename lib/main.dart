import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
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
          brightness: Brightness.light,
        ),
        primarySwatch: primary,
        shadowColor: HexColor('4E291414'),
        scaffoldBackgroundColor: primary.shade50,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

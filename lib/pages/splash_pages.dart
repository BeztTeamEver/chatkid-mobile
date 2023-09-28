import 'package:after_layout/after_layout.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/init_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages>
    with AfterLayoutMixin<SplashPages> {
  // Todo: for testing only
  final isFirstScreen = 0;
  Future<void> checkIsFirstScreen(BuildContext context) async {
    // TODO check if the page is logined
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // bool isFirstScreen = prefs.getBool('isFirstScreen') ?? true;
    if (isFirstScreen == 0) {
      // await prefs.setBool('isFirstScreen', false);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InitPage()));
    } else {
      Navigator.pushNamed(context, routesName['${AppRoutes.login}']!);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkIsFirstScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

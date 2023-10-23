import 'package:after_layout/after_layout.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/constants/sign_up_list.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/init_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
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
  void checkIsFirstScreen(BuildContext context) {
    SharedPreferences prefs = LocalStorage.instance.preferences;

    bool isFirstScreen = prefs.getBool('isFirstScreen') ?? false;
    String? accessToken = prefs.getString('accessToken');
    int? currentStep = prefs.getInt('step');
    if (currentStep != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => signUpStep[currentStep]));
      return;
    }
    if (accessToken != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
      return;
    }
    if (!isFirstScreen) {
      // await prefs.setBool('isFirstScreen', false);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InitPage()));
      return;
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkIsFirstScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

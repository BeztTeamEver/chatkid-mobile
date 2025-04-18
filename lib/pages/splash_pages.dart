import 'package:after_layout/after_layout.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/constants/sign_up_list.dart';
import 'package:chatkid_mobile/pages/chats/group_chat_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/init_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/start_page/family_name_page.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/pages/start_page/password_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
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
  void checkIsFirstScreen(BuildContext context) async {
    SharedPreferences prefs = LocalStorage.instance.preferences;

    // USE FOR DEVELOP ONLY
    // Navigator.pushReplacement(
    //   context,
    //   createRoute(
    //     () => GroupChatPage(
    //       channelId: "",
    //     ),
    //   ),
    // );
    // return;
    bool isFirstScreen = prefs.getBool(LocalStorageKey.IS_FIRST_SCREEN) ?? true;
    String? accessToken = prefs.getString(LocalStorageKey.ACCESS_TOKEN);
    int? currentStep = prefs.getInt('step');
    if (currentStep != null && currentStep < signUpStep.length) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => signUpStep[currentStep]));
      return;
    }

    if (accessToken != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
      return;
    }
    if (isFirstScreen) {
      // await prefs.setBool('isFirstScreen', false);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const InitPage()));
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkIsFirstScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Container(
        color: Colors.white,
        child: const Center(
          child: LogoWidget(),
        ),
      ),
    );
  }
}

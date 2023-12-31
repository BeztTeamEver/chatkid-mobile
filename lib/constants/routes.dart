import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/history_tracking/user_profile_notification_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/init_page.dart';
import 'package:chatkid_mobile/pages/notification/notification_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

enum AppRoutes {
  activities,
  home,
  profile,
  voice,
  history,
  notification,
  initPage,
  signUp,
  login,
  wallet
}

final Map<String, String> routesName = <String, String>{
  '${AppRoutes.home}': '/${AppRoutes.home}}',
  '${AppRoutes.activities}': '/${AppRoutes.activities}',
  '${AppRoutes.history}': '/${AppRoutes.history}',
  '${AppRoutes.notification}': '/${AppRoutes.notification}',
  '${AppRoutes.profile}': '/${AppRoutes.profile}',
  '${AppRoutes.wallet}': '/${AppRoutes.wallet}',
  '${AppRoutes.voice}': '/${AppRoutes.voice}',
  '${AppRoutes.initPage}': '/${AppRoutes.initPage}',
  '${AppRoutes.signUp}': '/${AppRoutes.signUp}',
  '${AppRoutes.login}': '/${AppRoutes.login}',
};

final Map<String, Widget Function(BuildContext)> routes =
    <String, WidgetBuilder>{
  '/${AppRoutes.activities}': (BuildContext context) => const ExplorePage(),
  '/${AppRoutes.history}': (BuildContext context) =>
      const UserProfileNotificationPage(),
  '/${AppRoutes.notification}': (BuildContext context) =>
      const NotificationPage(),
  '/${AppRoutes.home}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.profile}': (BuildContext context) => ProfilePage(),
  // '/${AppRoutes.wallet}': (BuildContext context) => WalletPage(family: null,),
  '/${AppRoutes.voice}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.initPage}': (BuildContext context) => const InitPage(),
  '/${AppRoutes.login}': (BuildContext context) => const LoginPage(),
  '/${AppRoutes.signUp}': (BuildContext context) => const SignUpPage(),
};

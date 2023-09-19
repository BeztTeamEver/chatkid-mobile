import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';

enum AppRoutes { activities, home, profile, voice, history, notification }

final Map<String, String> routesName = <String, String>{
  '${AppRoutes.home}': '/${AppRoutes.home}}',
  '${AppRoutes.activities}': '/${AppRoutes.activities}',
  '${AppRoutes.history}': '/${AppRoutes.history}',
  '${AppRoutes.notification}': '/${AppRoutes.notification}',
  '${AppRoutes.profile}': '/${AppRoutes.profile}',
  '${AppRoutes.voice}': '/${AppRoutes.voice}',
};

final Map<String, Widget Function(BuildContext)> routes =
    <String, WidgetBuilder>{
  '/${AppRoutes.activities}': (BuildContext context) => const ActivationPage(),
  '/${AppRoutes.history}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.notification}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.home}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.profile}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.voice}': (BuildContext context) => const HomePage(),
};

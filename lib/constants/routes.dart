import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';

enum AppRoutes { activation, home, profile, voice }

final Map<String, String> routesName = <String, String>{
  '${AppRoutes.home}': '/${AppRoutes.home}}',
  '${AppRoutes.activation}': '/${AppRoutes.activation}',
  '${AppRoutes.profile}': '/${AppRoutes.profile}',
  '${AppRoutes.voice}': '/${AppRoutes.voice}',
};

final Map<String, Widget Function(BuildContext)> routes =
    <String, WidgetBuilder>{
  '/${AppRoutes.activation}': (BuildContext context) => const ActivationPage(),
  '/${AppRoutes.home}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.profile}': (BuildContext context) => const HomePage(),
  '/${AppRoutes.voice}': (BuildContext context) => const HomePage(),
};

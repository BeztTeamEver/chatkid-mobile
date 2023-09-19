import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/modals/menu_modal.dart';
import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';

final List<Menu> menu = [
  Menu(
    title: 'Home',
    icon: 'home',
    route: routesName['${AppRoutes.home}']!,
    role: ['child', 'parent'],
    widget: const HomePage(),
  ),
  Menu(
    title: "Voice",
    icon: 'headset',
    route: routesName['${AppRoutes.voice}']!,
    role: ['child'],
    widget: const ActivationPage(),
  ),
  Menu(
    title: 'history',
    icon: 'history',
    route: routesName['${AppRoutes.history}']!,
    role: ['parent'],
    widget: const HomePage(),
  ),
  Menu(
    title: 'Activities',
    icon: 'rocket',
    route: routesName['${AppRoutes.activities}']!,
    role: ['child'],
    widget: const HomePage(),
  ),
  Menu(
    title: 'notification',
    icon: 'bell',
    route: routesName['${AppRoutes.notification}']!,
    role: ['parent'],
    widget: const HomePage(),
  ),
  Menu(
    title: 'Profile',
    icon: 'user',
    route: routesName['${AppRoutes.profile}']!,
    role: ['child', 'parent'],
    widget: const HomePage(),
  ),
];

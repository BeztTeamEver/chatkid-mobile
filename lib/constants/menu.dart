import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/modals/menu_modal.dart';

List<Menu> menu = [
  Menu(
    title: 'Home',
    icon: 'home',
    route: routesName['${AppRoutes.home}']!,
    role: ['child', 'parend'],
  ),
  Menu(
      title: "Voice",
      icon: 'headset',
      route: routesName['${AppRoutes.voice}']!,
      role: ['child', 'parent']),
  Menu(
    title: 'Chat',
    icon: 'rocket',
    route: routesName['${AppRoutes.activation}']!,
    role: ['child', 'parent'],
  ),
  Menu(
    title: 'Profile',
    icon: 'user',
    route: routesName['${AppRoutes.profile}']!,
    role: ['child', 'parent'],
  ),
];

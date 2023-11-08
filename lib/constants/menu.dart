import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_categories_detail_page.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';

final List<Menu> menu = [
  Menu(
    title: 'Home',
    icon: 'home',
    route: routesName['${AppRoutes.home}']!,
    role: [RoleConstant.Parent, RoleConstant.Child],
    widget: const HomePage(),
  ),
  Menu(
    title: "Voice",
    icon: 'headset',
    route: routesName['${AppRoutes.voice}']!,
    role: [RoleConstant.Child],
    widget: const ActivationPage(),
  ),
  Menu(
    title: 'history',
    icon: 'history',
    route: routesName['${AppRoutes.history}']!,
    role: [RoleConstant.Parent],
    widget: const HomePage(),
  ),
  Menu(
    title: 'Activities',
    icon: 'rocket',
    route: routesName['${AppRoutes.activities}']!,
    role: [RoleConstant.Child],
    widget: const ExplorePage(),
  ),
  Menu(
    title: 'notification',
    icon: 'bell',
    route: routesName['${AppRoutes.notification}']!,
    role: [RoleConstant.Parent],
    widget: const HomePage(),
  ),
  Menu(
    title: 'Profile',
    icon: 'user',
    route: routesName['${AppRoutes.profile}']!,
    role: [RoleConstant.Parent, RoleConstant.Child],
    widget: const ProfilePage(),
  ),
];

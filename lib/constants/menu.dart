import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/pages/activation_page.dart';
import 'package:chatkid_mobile/pages/chats/list_group_chat.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_page.dart';
import 'package:chatkid_mobile/pages/explore/explore_homepages.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/notification/notification_page.dart';
import 'package:chatkid_mobile/pages/history_tracking/user_profile_notification_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';

final List<Menu> menu = [
  Menu(
    title: 'Khám phá',
    iconDefault: 'bottomMenu/discover',
    iconActive: 'bottomMenu/discover_active',
    route: routesName['${AppRoutes.blog}']!,
    role: [RoleConstant.Child],
    widget: const ExploreHomepage(),
  ),
  Menu(
    title: "Trò chuyện",
    iconDefault: 'bottomMenu/chat',
    iconActive: 'bottomMenu/chat_active',
    route: routesName['${AppRoutes.chat}']!,
    role: [RoleConstant.Child, RoleConstant.Parent],
    widget: const ListGroupChat(),
  ),
  Menu(
    title: 'Thành tựu',
    iconDefault: 'bottomMenu/reward',
    iconActive: 'bottomMenu/reward_active',
    route: routesName['${AppRoutes.history}']!,
    role: [RoleConstant.Child],
    widget: const UserProfileNotificationPage(),
  ),
  Menu(
    title: 'Hoạt động',
    iconDefault: 'bottomMenu/activities',
    iconActive: 'bottomMenu/activities_active',
    route: routesName['${AppRoutes.activities}']!,
    role: [RoleConstant.Parent],
    widget: const ExplorePage(),
  ),
  Menu(
    title: 'Thông báo',
    iconDefault: 'bottomMenu/notification',
    iconActive: 'bottomMenu/notification_active',
    route: routesName['${AppRoutes.notification}']!,
    role: [RoleConstant.Parent],
    widget: const NotificationPage(),
  ),
  Menu(
    title: 'Tài khoản',
    iconDefault: 'bottomMenu/profile',
    iconActive: 'bottomMenu/profile_active',
    route: routesName['${AppRoutes.profile}']!,
    role: [RoleConstant.Parent, RoleConstant.Child],
    widget: ProfilePage(),
  ),
];

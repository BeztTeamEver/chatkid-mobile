import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/pages/chats/list_group_chat.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/children_tracking/children_tracking_page.dart';
import 'package:chatkid_mobile/pages/notification/notification_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/pages/routes/todo_route.dart';

final List<Menu> menu = [
  Menu(
    title: 'Trang chủ',
    iconDefault: 'bottomMenu/list_detail',
    iconActive: 'bottomMenu/list_detail_active',
    route: routesName['${AppRoutes.home}']!,
    role: [RoleConstant.Parent, RoleConstant.Child],
    widget: const TodoRouteWrapper(),
  ),

  Menu(
    title: "Trò chuyện",
    iconDefault: 'bottomMenu/chat',
    iconActive: 'bottomMenu/chat_active',
    route: routesName['${AppRoutes.chat}']!,
    role: [RoleConstant.Child],
    widget: const ListGroupChat(),
  ),

  // Menu(
  //   title: 'Thành tựu',
  //   iconDefault: 'bottomMenu/reward',
  //   iconActive: 'bottomMenu/reward_active',
  //   route: routesName['${AppRoutes.history}']!,
  //   role: [RoleConstant.Child],
  //   widget: const UserProfileNotificationPage(),
  // ),
  Menu(
    title: 'Bé',
    iconDefault: 'bottomMenu/kid',
    iconActive: 'bottomMenu/kid_active',
    route: routesName['${AppRoutes.activities}']!,
    role: [RoleConstant.Parent],
    widget: const ChildrenTrackingPage(),
  ),
  Menu(
    title: 'center',
    iconDefault: 'bottomMenu/plus',
    iconActive: 'bottomMenu/plus_active',
    route: routesName['${AppRoutes.blog}']!,
    role: [RoleConstant.Parent],
    widget: const ExplorePage(),
  ),
  Menu(
    title: 'Khám phá',
    iconDefault: 'bottomMenu/discover',
    iconActive: 'bottomMenu/discover_active',
    route: routesName['${AppRoutes.blog}']!,
    role: [RoleConstant.Child],
    widget: const ExplorePage(),
  ),
  // Menu(
  //   title: 'Thông báo',
  //   iconDefault: 'bottomMenu/notification',
  //   iconActive: 'bottomMenu/notification_active',
  //   route: routesName['${AppRoutes.notification}']!,
  //   role: [RoleConstant.Parent],
  //   widget: const NotificationPage(),
  // ),
  Menu(
    title: "Thông báo",
    iconDefault: 'bottomMenu/bell',
    iconActive: 'bottomMenu/bell_active',
    route: routesName['${AppRoutes.notification}']!,
    role: [RoleConstant.Child, RoleConstant.Parent],
    widget: NotificationPage(),
  ),
  Menu(
    title: 'Tài khoản',
    iconDefault: 'bottomMenu/profile',
    iconActive: 'bottomMenu/profile_active',
    route: routesName['${AppRoutes.profile}']!,
    role: [RoleConstant.Parent, RoleConstant.Child],
    widget: const ProfilePage(),
  ),
];

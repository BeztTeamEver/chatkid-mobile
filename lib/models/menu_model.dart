import 'package:chatkid_mobile/constants/menu.dart';
import 'package:flutter/material.dart';

class Menu {
  String title;
  String iconDefault;
  String iconActive;
  String route;
  List<String> role;
  Widget widget;

  Menu({
    required this.title,
    required this.iconDefault,
    required this.iconActive,
    required this.route,
    required this.role,
    required this.widget,
  });
}

class MenuList {
  final List<Menu> list = menu;
  String role;

  MenuList({required this.role});

  List<Menu> getMenu() {
    return menu.where((element) => element.role.contains(role)).toList();
  }

  List<Widget> getWidgets() {
    return getMenu().map((e) => e.widget).toList();
  }
}

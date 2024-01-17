import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BottomMenu extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const BottomMenu({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  UserModel currentAccount = UserModel.fromJson(
    jsonDecode(LocalStorage.instance.preferences.getString('user') ?? "{}"),
  );
  final double _borderRadius = 8;
  @override
  Widget build(BuildContext context) {
    final menu =
        MenuList(role: currentAccount.role ?? RoleConstant.Child).getMenu();

    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Center(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: widget.currentIndex,
            onTap: (index) {
              widget.onTap(index);
            },
            selectedItemColor: primary.shade900,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
            items: menu.map(
              (item) {
                return BottomNavigationBarItem(
                  label: item.title,
                  icon: SvgIcon(
                      size: 28,
                      icon: item.route == menu[widget.currentIndex].route
                          ? item.iconActive
                          : item.iconDefault
                      // color: item.route == menu[widget.currentIndex].route
                      //     ? Theme.of(context).colorScheme.primary
                      //     : neutral.shade200,
                      ),
                  backgroundColor: Colors.transparent,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

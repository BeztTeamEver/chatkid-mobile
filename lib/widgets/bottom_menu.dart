import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/count_noti_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
  CountNotiController countNotiController = Get.find();

  @override
  Widget build(BuildContext context) {
    final menu =
        MenuList(role: currentAccount.role ?? RoleConstant.Child).getMenu();

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBarTheme(
        data: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: primary.shade900,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
        ),
        child: NavigationBar(
          // type: BottomNavigationBarType.fixed,
          elevation: 0,
          onDestinationSelected: (value) => widget.onTap(value),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: widget.currentIndex,
          destinations: menu.map((item) {
            if (item.title == 'center') return Container();
            return Obx(
              () => Badge(
                label: Text(
                  countNotiController.countNoti.value.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                isLabelVisible: (item.route == menu[2].route ||
                        item.route == menu[3].route) &&
                    countNotiController.countNoti > 0,
                backgroundColor: red.shade500,
                textColor: Colors.white,
                alignment: Alignment.topRight,
                largeSize: 15,
                offset: const Offset(-22, 4),
                child: NavigationDestination(
                  icon: SvgIcon(
                    size: 28,
                    icon: item.route == menu[widget.currentIndex].route
                        ? item.iconActive
                        : item.iconDefault,
                  ),
                  label: item.title.contains("center") ? "" : item.title,
                ),
              ),
            );
          }).toList(),

          // currentIndex: widget.currentIndex,
          // onTap: (index) {
          //   widget.onTap(index);
          // },
          // selectedItemColor: primary.shade900,
          // items: menu.map(
          //   (item) {
          //     return BottomNavigationBarItem(
          //       label: item.title,
          //       icon: SvgIcon(
          //           size: 28,
          //           icon: item.route == menu[widget.currentIndex].route
          //               ? item.iconActive
          //               : item.iconDefault
          //           // color: item.route == menu[widget.currentIndex].route
          //           //     ? Theme.of(context).colorScheme.primary
          //           //     : neutral.shade200,
          //           ),
          //       backgroundColor: Colors.transparent,
          //     );
          //   },
          // ).toList(),
        ),
      ),
    );
  }
}

class CenterNotch extends StatefulWidget {
  const CenterNotch({super.key});

  @override
  State<CenterNotch> createState() => _CenterNotchState();
}

class _CenterNotchState extends State<CenterNotch> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -10,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // child: SvgIcon(
            //   size: 28,
            //   icon: 'bottomMenu/list_detail_active',
            //   color: Colors.white,
            // ),
          ),
        ),
      ],
    );
  }
}

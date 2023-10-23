import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onTap;

  const BottomMenu({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    final menu = MenuList(role: 'child').getMenu();

    return Container(
      margin: const EdgeInsets.all(20),
      height: 62,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: widget.currentIndex,
            onTap: (index) {
              widget.onTap(index);
            },
            selectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: menu.map(
              (item) {
                return BottomNavigationBarItem(
                  label: "",
                  icon: SvgIcon(
                    size: 24,
                    icon: item.icon,
                    color: item.route == menu[widget.currentIndex].route
                        ? Theme.of(context).colorScheme.primary
                        : neutral.shade300,
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

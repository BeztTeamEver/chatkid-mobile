import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabbar extends StatefulWidget {
  final Function onTabChange;
  final TabController tabController;

  const CustomTabbar(
      {super.key, required this.onTabChange, required this.tabController});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabButton(
          onTap: () => widget.onTabChange(0),
          label: 'Nhiệm vụ',
          isSelected: widget.tabController.index == 0,
        ),
        const SizedBox(
          width: 10,
        ),
        TabButton(
          onTap: () => widget.onTabChange(1),
          label: 'Phong trào thi đua',
          isSelected: widget.tabController.index == 1,
        ),
      ],
    );
  }
}

class TabButton extends StatefulWidget {
  final bool isSelected;
  final String label;
  final Function onTap;

  const TabButton(
      {super.key,
      this.isSelected = false,
      this.label = '',
      required this.onTap});

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        padding: EdgeInsets.symmetric(vertical: 2),
        child: ElevatedButton(
          onPressed: () => widget.onTap(),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
            backgroundColor: MaterialStateProperty.all(
              widget.isSelected ? primary.shade500 : primary.shade200,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color: widget.isSelected ? primary.shade900 : primary.shade700,
            ),
          ),
        ),
      ),
    );
  }
}

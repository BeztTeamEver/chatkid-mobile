import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/tab_bar/tab_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabbar extends StatefulWidget {
  final Function onTabChange;
  final TabController tabController;
  final List<String> tabs;
  const CustomTabbar(
      {super.key,
      required this.onTabChange,
      required this.tabController,
      required this.tabs});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.tabs
          .map(
            (e) => TabButton(
              label: e,
              isSelected: widget.tabController.index == widget.tabs.indexOf(e),
              onTap: () {
                widget.onTabChange(widget.tabs.indexOf(e));
                widget.tabController.animateTo(widget.tabs.indexOf(e));
              },
            ),
          )
          .toList(),
    );
  }
}

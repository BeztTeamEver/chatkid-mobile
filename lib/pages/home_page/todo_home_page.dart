import 'package:chatkid_mobile/pages/home_page/widgets/banner.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/calendar.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modals/modals.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TodoBanner(),
      bottomSheet: BottomSheet(
        enableDrag: false,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height - 280),
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: primary.shade100,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Calendar()),
              ],
            ),
          );
        },
      ),
    );
  }
}

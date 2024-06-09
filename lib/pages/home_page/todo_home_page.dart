import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/banner.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/calendar.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/todo_main_sheet.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modals/modals.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final todoHomeController = Get.put(TodoHomeStore());
  final _bottomSheetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TodoBanner(
            bottomSheetKey: _bottomSheetKey,
          ),
          TodoMainBottomSheet(
            bottomSheetKey: _bottomSheetKey,
            todoHomeController: todoHomeController,
          ),
        ],
      ),
    );
  }
}

import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/banner.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/todo_main_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final _bottomSheetKey = GlobalKey();
  TodoHomeStore todoHomeController = Get.put<TodoHomeStore>(TodoHomeStore());

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

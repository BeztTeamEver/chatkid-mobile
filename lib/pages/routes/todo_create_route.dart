import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/todo_create_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoCreateRoute extends StatefulWidget {
  const TodoCreateRoute({super.key});

  @override
  State<TodoCreateRoute> createState() => _TodoCreateRouteState();
}

class _TodoCreateRouteState extends State<TodoCreateRoute>
    with TickerProviderStateMixin {
  final TodoFormCreateController todoFormCreateController =
      Get.put(TodoFormCreateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoFormCreateController.stepController.value = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this, value: 0.1)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          todoFormCreateController.isEdit.value = false;
          todoFormCreateController.stepController.value!.dispose();
          return;
        }
        todoFormCreateController.resetStep();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Obx(
                  () => LinearProgressIndicator(
                    value: todoFormCreateController.stepController.value!.value,
                  ),
                ),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    // bottom: PreferredSize(
                    //   preferredSize: const Size.fromHeight(16),
                    //   child: Obx(
                    //     () => LinearProgressIndicator(
                    //       value: todoFormCreateController.stepController.value!.value,
                    //     ),
                    //   ),
                    // ),
                    actions: [
                      ButtonIcon(
                        onPressed: () {},
                        icon: 'trash',
                        iconSize: 24,
                        color: primary.shade500,
                      )
                    ],
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      child: SecondaryButton(
                        child: SvgIcon(
                          icon: 'chevron-left',
                          color: primary.shade500,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      'Tạo công việc',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  body: Navigator(
                    onGenerateRoute: (setting) {
                      return MaterialPageRoute(
                        builder: (context) {
                          return const TodoCreatePage();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

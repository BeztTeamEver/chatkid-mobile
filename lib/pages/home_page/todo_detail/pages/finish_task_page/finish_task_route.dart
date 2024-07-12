import 'package:chatkid_mobile/pages/controller/todo_page/todo_detail_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/finish_task_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FinishTaskRoute extends StatefulWidget {
  const FinishTaskRoute({super.key});

  @override
  State<FinishTaskRoute> createState() => _FinishTaskRouteState();
}

class _FinishTaskRouteState extends State<FinishTaskRoute>
    with SingleTickerProviderStateMixin {
  TodoFeedbackStore todoFeedbackStore = Get.put(TodoFeedbackStore());

  @override
  void initState() {
    super.initState();
    todoFeedbackStore.stepController.value = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      value: 0.25,
    )..addListener(() {
        setState(() {});
      });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: todoFeedbackStore.step.value == 1,
      onPopInvoked: (didPop) {
        if (didPop) {
          todoFeedbackStore.stepController.value!.dispose();
          todoFeedbackStore.resetStep();
          return;
        }
        todoFeedbackStore.decreaseStep();
        todoFeedbackStore.updateProgress();
        todoFeedbackStore.previousPage();
        // todoFormCreateController.NavigatePop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Obx(
                  () => LinearProgressIndicator(
                    value: todoFeedbackStore.stepController.value!.value,
                  ),
                ),
              ),
              Expanded(
                child: Scaffold(
                  body: Navigator(
                    onPopPage: (route, result) {
                      if (!route.didPop(result)) {
                        return false;
                      }
                      todoFeedbackStore.decreaseStep();
                      todoFeedbackStore.updateProgress();
                      return true;
                    },
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) {
                          return FinishTaskPage();
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

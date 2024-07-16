import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_create_form_wrapper.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_template_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TargetCreateRoute extends StatefulWidget {
  const TargetCreateRoute({super.key});

  @override
  State<TargetCreateRoute> createState() => _TargetCreateRouteState();
}

class _TargetCreateRouteState extends State<TargetCreateRoute>
    with TickerProviderStateMixin {
  TargetFormStore targetFormStore = Get.put(TargetFormStore());

  @override
  void initState() {
    super.initState();
    targetFormStore.stepController.value = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this, value: 0.25)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: targetFormStore.step.value == 0,
      onPopInvoked: (didPop) {
        if (didPop) {
          targetFormStore.stepController.value!.dispose();
          targetFormStore.resetStep();
          return;
        }
        targetFormStore.decreaseStep();
        targetFormStore.updateProgress();
        targetFormStore.NavigatePop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Column(
              children: [
                targetFormStore.step.value != 0
                    ? Container(
                        child: LinearProgressIndicator(
                          value: targetFormStore.stepController.value!.value,
                        ),
                      )
                    : Container(),
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

                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        child: SecondaryButton(
                          child: SvgIcon(
                            icon: 'chevron-left',
                            color: primary.shade500,
                          ),
                          onTap: () {
                            if (targetFormStore.step.value == 0) {
                              Navigator.pop(context);
                            } else {
                              targetFormStore.decreaseStep();
                              targetFormStore.updateProgress();
                              targetFormStore.NavigatePop();
                            }
                          },
                        ),
                      ),
                      centerTitle: true,
                      title: Text(
                        'Tạo công vaiệc',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    body: TargetCreateFormWrapper(
                      child: Navigator(
                          key: targetFormStore.navigatorKey,
                          onPopPage: (route, result) {
                            if (!route.didPop(result)) {
                              return false;
                            }
                            targetFormStore.decreaseStep();
                            targetFormStore.updateProgress();
                            targetFormStore.NavigatePop();
                            return true;
                          },
                          onGenerateRoute: (settings) {
                            return MaterialPageRoute(
                              builder: (context) {
                                return TargetTemplatePage();
                              },
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:chatkid_mobile/pages/controller/todo_page/todo_detail_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/widgets/capture_evidence.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/widgets/feedback_difficult.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/widgets/feedback_emotion.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/widgets/feedback_voice.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/widgets/finish_step.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/bot_message.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FinishTaskPage extends StatefulWidget {
  const FinishTaskPage({super.key});

  @override
  State<FinishTaskPage> createState() => _FinishTaskPageState();
}

class _FinishTaskPageState extends State<FinishTaskPage> {
  TodoFeedbackStore todoFeedbackStore = Get.find();

  final initData = {
    'emotion': '',
    'difficult': 2.0,
    'voice': '',
    'evidence': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        body: FormBuilder(
          initialValue: initData,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                  child: BotMessage()),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: todoFeedbackStore.pageController,
                  children: [
                    FeedbackDifficult(),
                    FeedBackEmotion(),
                    CaptureEvidence(),
                    FeedbackVoice(),
                    FinishStep(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Obx(() {
          return todoFeedbackStore.step.value != 2 ||
                  todoFeedbackStore.isCaptured
              ? BottomAction(todoFeedbackStore: todoFeedbackStore)
              : const SizedBox(
                  width: 0,
                  height: 0,
                );
        }));
  }
}

class BottomAction extends StatelessWidget {
  const BottomAction({
    super.key,
    required this.todoFeedbackStore,
  });

  final TodoFeedbackStore todoFeedbackStore;

  void _handleBack() {
    if (todoFeedbackStore.step.value == 0) {
      Get.back();
    } else {
      todoFeedbackStore.decreaseStep();
      todoFeedbackStore.updateProgress();
      todoFeedbackStore.previousPage();
      // Navigator.pop(context);
    }
  }

  void _handleSecondaryButton() {
    if (todoFeedbackStore.isCaptured && todoFeedbackStore.step.value == 2) {
      todoFeedbackStore.setIsCaptured(false);
    } else {
      _handleBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormBuilderField(builder: (field) => Container(), name: "evidence"),
            Expanded(
              child: ElevatedButton(
                child: Text(
                  todoFeedbackStore.isCaptured ? 'Chụp lại' : 'Quay lại',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primary.shade500,
                        fontSize: 16,
                      ),
                ),
                onPressed: () {
                  _handleSecondaryButton();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  surfaceTintColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent,
                  ),
                  shadowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                        color: primary.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: FullWidthButton(
                width: 200,
                child: Text(
                  'Tiếp theo',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
                onPressed: () {
                  if (todoFeedbackStore.step.value == 4) {
                  } else {
                    todoFeedbackStore.increaseStep();
                    todoFeedbackStore.updateProgress();
                    todoFeedbackStore.nextPage();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

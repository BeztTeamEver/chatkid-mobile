import 'package:chatkid_mobile/constants/feedback_page.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_detail_store.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotMessage extends StatefulWidget {
  const BotMessage({super.key});

  @override
  State<BotMessage> createState() => _BotMessageState();
}

class _BotMessageState extends State<BotMessage> {
  TodoFeedbackStore todoFeedbackStore = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BotFeedBackMessage[todoFeedbackStore.step.value].isNotEmpty
          ? Row(
              children: [
                Container(
                  height: 48,
                  child: SvgIcon(
                    size: 48,
                    icon: 'pumkin',
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: primary.shade500,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    BotFeedBackMessage[todoFeedbackStore.step.value],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                SizedBox(width: 8),
              ],
            )
          : Container(),
    );
  }
}

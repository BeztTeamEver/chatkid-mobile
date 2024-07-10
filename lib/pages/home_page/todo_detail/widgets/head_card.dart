import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/task_status.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadCard extends StatefulWidget {
  final String id;
  final TaskModel task;

  const HeadCard({super.key, required this.id, required this.task});

  @override
  State<HeadCard> createState() => _HeadCardState();
}

class _HeadCardState extends State<HeadCard> {
  TtsService _ttsService = TtsService().instance;

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        CustomCard(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.only(bottom: 4),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primary.shade200,
              ),
              child: Hero(
                tag: widget.id,
                child: Image.network(
                  widget.task.taskType.imageHomeUrl ??
                      "https://picsum.photos/200/200",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    widget.task.taskType.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  ButtonIcon(
                    onPressed: () {
                      _speak(widget.task.note ?? "");
                    },
                    icon: "volumn",
                    padding: 0,
                    iconSize: 28,
                  ),
                ],
              ),
            ),
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    // TODO: use task time
                    "${widget.task.startTime.format(DateConstants.timeFormatWithoutSecond)} ${widget.task.finishTime != null ? widget.task.finishTime!.format(DateConstants.timeFormatWithoutSecond) : ""}, ${widget.task.startTime.format(DateConstants.dateSlashFormat)}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  VerticalDivider(
                    color: neutral.shade200,
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                    width: 20,
                  ),
                  Text(
                    StatusTextMap[widget.task.status] ?? "",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: StatusColorMap[widget.task.status],
                        ),
                  ),
                ],
              ),
            ),
            widget.task.finishTime != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Thời gian hoàn thành: ${widget.task.finishTime != null ? widget.task.finishTime!.format(DateConstants.timeFormatWithoutSecond) : ""}, ${widget.task.finishTime != null ? widget.task.finishTime!.format(DateConstants.dateSlashFormat) : ""}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  )
                : Container(),
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Thưởng 1000",
                    style: TextStyle(
                      fontSize: 14,
                      color: neutral.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SvgIcon(
                    icon: 'coin',
                    size: 24,
                  ),
                  VerticalDivider(
                    color: neutral.shade200,
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                    width: 20,
                  ),
                  GetX<TodoHomeStore>(
                    builder: (controller) {
                      return Row(children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: AvatarPng(
                            imageUrl: controller
                                .members[controller.currentUserIndex.value]
                                .avatarUrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.members[controller.currentUserIndex.value]
                                  .name ??
                              "",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: neutral.shade500,
                                  ),
                        ),
                      ]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 10,
          top: 10,
          child: ButtonIcon(
            icon: 'chevron-left',
            color: primary.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            iconSize: 26,
            padding: 4,
            backgroundColor: primary.shade100,
          ),
        ),
      ],
    );
  }
}

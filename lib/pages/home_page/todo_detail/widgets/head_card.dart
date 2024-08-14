import 'dart:convert';

import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/constants/task_status.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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

  UserModel createdBy = UserModel();
  @override
  void dispose() {
    // TODO: implement dispose
    _ttsService.stop();
    super.dispose();
  }

  void getAssigner() {
    final members =
        (jsonDecode(LocalStorage.instance.getString(LocalStorageKey.MEMBERS))
                as List<dynamic>?)
            ?.map((e) => UserModel.fromJson(jsonDecode(e)))
            .toList();
    if (members == null || members.isEmpty) {
      return;
    }
    final assigner = members
        .firstWhereOrNull((element) => element.id == widget.task.assigneerId);

    if (assigner == null) {
      return;
    }
    setState(() {
      createdBy = assigner;
    });
  }

  @override
  void initState() {
    super.initState();
    getAssigner();
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
            const SizedBox(height: 8),
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
                children: [
                  Text(
                    // TODO: use task time
                    "${widget.task.startTime.format(DateConstants.timeFormatWithoutSecond)} - ${widget.task.endTime.format(DateConstants.timeFormatWithoutSecond)}, ${widget.task.startTime.format(DateConstants.dateSlashFormat)}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
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
                  Label(
                      width: 112,
                      type: StatusLabelTypeMap[widget.task.status]!,
                      label: StatusTextMap[widget.task.status]!),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            // widget.task.finishTime != null
            //     ? Container(
            //         width: MediaQuery.of(context).size.width,
            //         padding: const EdgeInsets.symmetric(horizontal: 16),
            //         child: Text(
            //           "Thời gian hoàn thành: ${widget.task.finishTime != null ? widget.task.finishTime!.format(DateConstants.timeFormatWithoutSecond) : ""}, ${widget.task.finishTime != null ? widget.task.finishTime!.format(DateConstants.dateSlashFormat) : ""}",
            //           style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //         ),
            //       )
            //     : Container(),
            createdBy.name != null
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "Người giao việc:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          child: AvatarPng(
                            imageUrl: createdBy.avatarUrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${createdBy.name}",
                          style: TextStyle(
                            fontSize: 14,
                            color: neutral.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            createdBy.name != null
                ? SizedBox(
                    height: 12,
                  )
                : Container(),
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Thưởng ${widget.task.numberOfCoin}",
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
                      final user = controller.members.firstWhereOrNull(
                          (element) => element.id == widget.task.memberId);

                      return Row(children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: AvatarPng(
                            imageUrl: user?.avatarUrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user?.name ?? "",
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

import 'dart:ui';

import 'package:chatkid_mobile/constants/feedback_page.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBackCard extends StatefulWidget {
  final TaskModel task;

  const FeedBackCard({super.key, required this.task});

  @override
  State<FeedBackCard> createState() => _FeedBackCardState();
}

class _FeedBackCardState extends State<FeedBackCard> {
  final TodoHomeStore todoHomeStore = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      children: [
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          useVoice: false,
          message:
              'Công việc ${FeedbackMap[widget.task.feedbackLevel]!.toLowerCase()}',
        ),
        SizedBox(height: 16),
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          useVoice: false,
          imageUrl:
              widget.task.feedbackEmoji ?? "https://picsum.photos/200/200",
        ),
        SizedBox(height: 16),
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          voiceUrl: widget.task.feedbackVoice,
        ),
        SizedBox(height: 16),
        Image.network(
          widget.task.evidence ?? "https://picsum.photos/200/200",
          fit: BoxFit.cover,
          height: 400,
        ),
      ],
    );
  }
}

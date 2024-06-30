import 'dart:ui';

import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBackCard extends StatefulWidget {
  const FeedBackCard({super.key});

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
          message: "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!",
          useTextfullWidth: true,
        ),
        SizedBox(height: 16),
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          useVoice: false,
          message: "Hài lòng",
          useTextfullWidth: true,
        ),
        SizedBox(height: 16),
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          useVoice: false,
          useTextfullWidth: true,
        ),
        SizedBox(height: 16),
        Image.network(
          "https://picsum.photos/200/200",
          fit: BoxFit.contain,
          height: 592,
        ),
      ],
    );
  }
}

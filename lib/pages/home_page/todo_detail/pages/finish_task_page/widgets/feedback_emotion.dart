import 'package:chatkid_mobile/constants/feedback_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';

class FeedBackEmotion extends StatefulWidget {
  const FeedBackEmotion({super.key});

  @override
  State<FeedBackEmotion> createState() => _FeedBackEmotionState();
}

class _FeedBackEmotionState extends State<FeedBackEmotion> {
  final user = LocalStorage.instance.getUser();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: StickerList.getSticker(user.gender ?? "")
          .map(
            (e) => GestureDetector(
              onTap: () {
                print(e);
              },
              child: Image.asset(
                e,
                width: 50,
                height: 50,
              ),
            ),
          )
          .toList(),
    );
  }
}

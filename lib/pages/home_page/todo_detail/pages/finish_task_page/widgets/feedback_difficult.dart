import 'package:chatkid_mobile/constants/feedback_page.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_detail_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/bot_message.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FeedbackDifficult extends StatefulWidget {
  const FeedbackDifficult({super.key});

  @override
  State<FeedbackDifficult> createState() => _FeedbackDifficultState();
}

class _FeedbackDifficultState extends State<FeedbackDifficult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 520,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 600,
                color: Colors.transparent,
                padding: EdgeInsets.all(10),
                child: MainCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainCard extends StatefulWidget {
  const MainCard({super.key});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  TodoFeedbackStore todoFeedbackStore = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      children: [
        Expanded(
          child: FormBuilderField(
            name: 'difficult',
            builder: (field) => Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: FeedbackEmojiList.map(
                              (e) => EmojiLabel(emoji: e.emoji, label: e.label))
                          .toList(),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderThemeData(
                        inactiveTrackColor: neutral.shade200,
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                        trackHeight: 24,
                        thumbColor: primary.shade400,
                        activeTrackColor: primary.shade400,
                        overlayColor: primary.shade100,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 20,
                          elevation: 1,
                          pressedElevation: 12,
                        ),
                      ),
                      child: Slider(
                        divisions: 4,
                        value: field.value as double,
                        onChanged: (value) {
                          field.didChange(value);
                        },
                        min: 0,
                        max: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class EmojiLabel extends StatelessWidget {
  final String emoji;
  final String label;
  const EmojiLabel({super.key, required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgIcon(icon: emoji, size: 54),
        SizedBox(width: 20),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

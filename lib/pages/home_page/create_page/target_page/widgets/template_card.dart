import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateCard extends StatefulWidget {
  final TargetModel targetModel;

  const TemplateCard({super.key, required this.targetModel});

  @override
  State<TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<TemplateCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.targetModel.message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // TODO: implement missions
                  // ListView(
                  //   children: widget.targetModel.missions
                  //       .map((e) => Text())
                  //       .toList(),
                  // )
                ],
              ),
            ),
            Row(
              children: [
                SvgIcon(
                  icon: 'coin',
                  size: 56,
                ),
                Text('x10'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

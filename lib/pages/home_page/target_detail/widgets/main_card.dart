import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainCard extends StatefulWidget {
  final String label;
  final int count;
  final String sticker;
  final MissionModel mission;
  final int progress;
  const MainCard(
      {super.key,
      required this.mission,
      required this.label,
      required this.progress,
      required this.count,
      required this.sticker});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 140),
      width: MediaQuery.of(context).size.width,
      child: CustomCard(
        mainAxisAlignment: MainAxisAlignment.start,
        backgroundImage: widget.mission.imageHomeUrl,
        padding: const EdgeInsets.all(14),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Wrap(
                        children: List.generate(
                          widget.count,
                          (index) => FinishCountItem(
                              isFinished: widget.progress > index),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FinishCountItem extends StatelessWidget {
  final bool isFinished;
  const FinishCountItem({super.key, this.isFinished = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: SvgIcon(
          icon: isFinished ? "finished_item" : "unfinished_item", size: 28),
    );
  }
}

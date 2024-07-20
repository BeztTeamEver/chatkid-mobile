import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCard extends StatefulWidget {
  final String label;
  final int count;
  final String sticker;
  const MainCard(
      {super.key,
      required this.label,
      required this.count,
      required this.sticker});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: CustomCard(
        padding: const EdgeInsets.all(16),
        children: [
          Expanded(
            child: Row(
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
                      Wrap(children: [
                        FinishCountItem(isFinished: true),
                        FinishCountItem(isFinished: false),
                      ])
                    ],
                  ),
                ),
                SvgIcon(
                  icon: widget.sticker,
                  size: 80,
                ),
              ],
            ),
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

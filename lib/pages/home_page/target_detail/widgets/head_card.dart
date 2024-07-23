import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/edit_modal.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadCard extends StatefulWidget {
  final TargetModel target;
  const HeadCard({super.key, required this.target});

  @override
  State<HeadCard> createState() => _HeadCardState();
}

class _HeadCardState extends State<HeadCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      widget.target.message ?? "Mục tiêu",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 18,
                              ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${widget.target.startTime.format(DateConstants.dateSlashFormat)} - ${widget.target.endTime.format(DateConstants.dateSlashFormat)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ProgressBar(
                              value: widget.target.currentProgress /
                                  widget.target.totalProgress,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.network(
                            widget.target.rewardImageUrl ??
                                "https://via.placeholder.com/150",
                            width: 80,
                            height: 62,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 4,
                top: 4,
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
              Positioned(
                top: 1,
                right: 4,
                child: ButtonIcon(
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return EditModal();
                      },
                    );
                  },
                  icon: "dots",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

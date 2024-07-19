import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class TargetItem extends StatefulWidget {
  final TargetModel target;
  const TargetItem({super.key, required this.target});

  @override
  State<TargetItem> createState() => _TargetItemState();
}

class _TargetItemState extends State<TargetItem> {
  // TODO: implement data
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomCard(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.target.message,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.target.startTime.format(DateConstants.dateSlashFormat)} - ${widget.target.endTime.format(DateConstants.dateSlashFormat)}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          width: constraints.maxWidth,
                          child: ProgressBar(
                            value: widget.target.currentProgress /
                                (widget.target.totalProgress == 0
                                    ? 1
                                    : widget.target.totalProgress),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                child: SvgIcon(
                  icon: 'coin',
                  size: 68,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'x1000',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: neutral.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

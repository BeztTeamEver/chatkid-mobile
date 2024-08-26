import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/target_status.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/edit_modal.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HeadCard extends StatefulWidget {
  final TargetModel target;
  const HeadCard({super.key, required this.target});

  @override
  State<HeadCard> createState() => _HeadCardState();
}

class _HeadCardState extends State<HeadCard> {
  final TodoHomeStore store = Get.find();
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
                    const SizedBox(
                      height: 4,
                    ),
                    Label(
                        width: 140,
                        type: TargetStatusLabelMap[widget.target.status]!,
                        label: TargetTextMap[widget.target.status]!),
                    const SizedBox(
                      height: 4,
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Image.network(
                          widget.target.rewardImageUrl ??
                              "https://via.placeholder.com/150",
                          width: 120,
                          height: 82,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                            "${widget.target.reward}",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: neutral.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
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
                  onPressed: () async {
                    final List<dynamic>? target = await showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return EditModal(
                          id: widget.target.id,
                          target: widget.target,
                        );
                      },
                    );
                    Logger().i(target);

                    if (target != null) {
                      if (target[0] == 'delete') {
                        store.removeTarget(widget.target);
                      } else {
                        store.updateTarget(target[1]);
                        store.setSelectedTarget(target[1]);
                      }
                    }
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

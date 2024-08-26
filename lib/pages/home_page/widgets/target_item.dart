import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/target_status.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/target_detail.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/edit_modal.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TargetItem extends StatefulWidget {
  final TargetModel target;
  const TargetItem({super.key, required this.target});

  @override
  State<TargetItem> createState() => _TargetItemState();
}

class _TargetItemState extends State<TargetItem> {
  final TodoHomeStore store = Get.find();
  // TODO: implement data
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomCard(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        onTap: () {
          store.setSelectedTarget(widget.target);
          Navigator.push(
            context,
            createRoute(() => TargetDetail()),
          );
        },
        onLongPressed: () async {
          final target = await showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return EditModal(
                id: widget.target.id,
                target: widget.target,
              );
            },
          );

          if (target != null) {
            if (target[0] == 'delete') {
              store.removeTarget(widget.target);
            } else {
              store.updateTarget(target[1]);
              store.setSelectedTarget(target[1]);
            }
          }
        },
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
                      Label(
                          type: TargetStatusLabelMap[widget.target.status]!,
                          label: TargetTextMap[widget.target.status]!),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.target.startTime.format(DateConstants.dateSlashFormat)} - ${widget.target.endTime.format(DateConstants.dateSlashFormat)}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              color: neutral.shade900,
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
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Image.network(
                    widget.target.rewardImageUrl ??
                        'https://picsum.photos/100/100',
                    width: 140,
                    height: 82,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : CustomCircleProgressIndicator(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

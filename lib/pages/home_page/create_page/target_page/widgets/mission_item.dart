import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/input_number.dart';
import 'package:chatkid_mobile/widgets/input_number_without_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';

class MissionItem extends StatefulWidget {
  final TaskTypeModel taskType;
  const MissionItem({super.key, required this.taskType});

  @override
  State<MissionItem> createState() => _MissionItemState();
}

class _MissionItemState extends State<MissionItem> {
  final TargetFormStore targetFormStore = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.32,
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
                targetFormStore.removeListMission(widget.taskType.id);
                targetFormStore.formKey.currentState?.unregisterField(
                    widget.taskType.id, FormBuilderFieldState());
                targetFormStore.formKey.currentState?.save();
              },
              backgroundColor: red.shade500,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Xóa',
            ),
          ],
        ),
        child: CustomCard(
          backgroundImage: widget.taskType.imageHomeUrl,
          padding: EdgeInsets.all(16),
          children: [
            FormBuilderField(
              name: widget.taskType.id,
              builder: (FormFieldState<dynamic> field) {
                return Container();
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.taskType.name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  InputNumber(
                    name: widget.taskType.id,
                    backgroundColor: primary.shade50,
                    formKey: targetFormStore.formKey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

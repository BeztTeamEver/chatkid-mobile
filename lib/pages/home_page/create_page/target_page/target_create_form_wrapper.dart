import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TargetCreateFormWrapper extends StatefulWidget {
  final Widget child;
  const TargetCreateFormWrapper({super.key, required this.child});

  @override
  State<TargetCreateFormWrapper> createState() =>
      _TargetCreateFormWrapperState();
}

class _TargetCreateFormWrapperState extends State<TargetCreateFormWrapper> {
  final TargetFormStore targetFormStore = Get.put(TargetFormStore());
  final TargetFormModel targetFormModel = TargetFormModel(
    endTime: DateTime.now(),
    startTime: DateTime.now(),
    memberId: '',
    reward: '',
    rewardImageUrl: '',
    message: '',
    missions: [],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: targetFormStore.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: targetFormModel.toMap(),
        child: widget.child,
      ),
    );
  }
}

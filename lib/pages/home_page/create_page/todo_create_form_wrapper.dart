import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TodoCreateFormWrapper extends StatefulWidget {
  final Widget child;
  const TodoCreateFormWrapper({super.key, required this.child});

  @override
  State<TodoCreateFormWrapper> createState() => _TodoCreateFormWrapperState();
}

class _TodoCreateFormWrapperState extends State<TodoCreateFormWrapper> {
  TodoFormCreateController todoFormCreateController = Get.find();

  final initFormData = {
    "startTime": DateTime.now(),
    "endTime": DateTime.now(),
    "frequency": <String>[],
    "giftTicket": "1",
    "memberId": "",
    "note": "",
    "assignees": <String>[],
  };

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      initialValue: initFormData,
      key: todoFormCreateController.formKey,
      child: widget.child,
    );
  }
}

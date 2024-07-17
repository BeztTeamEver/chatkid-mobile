import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TargetAddGiftPage extends StatefulWidget {
  const TargetAddGiftPage({super.key});

  @override
  State<TargetAddGiftPage> createState() => _TargetAddGiftPageState();
}

class _TargetAddGiftPageState extends State<TargetAddGiftPage> {
  final TargetFormStore targetFormStore = Get.find();
  @override
  Widget build(BuildContext context) {
    Logger().i(targetFormStore.formKey.currentState?.value['missions']);
    return Scaffold(
      primary: false,
      body: Container(
        child: const Center(
          child: Text('Add Gift'),
        ),
      ),
    );
  }
}

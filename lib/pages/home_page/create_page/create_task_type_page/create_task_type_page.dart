import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/create_task_type_page/task_type_image_item.dart';
import 'package:chatkid_mobile/pages/routes/todo_create_route.dart';
import 'package:chatkid_mobile/services/task_category_service.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateTaskTypePage extends StatefulWidget {
  final TaskTypeImageModel taskType;
  final String TaskCategoryId;
  const CreateTaskTypePage(
      {super.key, required this.TaskCategoryId, required this.taskType});

  @override
  State<CreateTaskTypePage> createState() => _CreateTaskTypePageState();
}

class _CreateTaskTypePageState extends State<CreateTaskTypePage> {
  final TextEditingController _nameController = TextEditingController();
  final TodoFormCreateController _todoFormCreateController = Get.find();
  submit() async {
    try {
      if (_nameController.text.isEmpty) {
        ShowToast.error(msg: "Vui lòng nhập tên công việc");
        return;
      }
      bool isExisted = false;
      _todoFormCreateController.taskCategories.forEach(
        (element) {
          element.taskTypes.forEach(
            (element) {
              if (element.name == _nameController.text) {
                isExisted = true;
              }
            },
          );
        },
      );
      if (isExisted) {
        ShowToast.error(msg: "Tên công việc đã tồn tại");
        return;
      }
      await TodoService().createTaskType(
        RequestTaskTypeCreateModel(
          name: _nameController.text,
          taskCategoryId: widget.TaskCategoryId,
          imageUrl: widget.taskType.imageUrl,
          imageHomeUrl: widget.taskType.imageHomeUrl,
        ),
      );
      Get.back(result: true);
    } catch (e) {
      Logger().e(e);
      ShowToast.error(msg: e.toString().split(":")[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: SecondaryButton(
              child: SvgIcon(
                icon: 'chevron-left',
                color: primary.shade500,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        centerTitle: true,
        title: Text(
          'Tạo công việc',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: FormBuilder(
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputField(
                  name: "name",
                  controller: _nameController,
                  label: "Tên loại công việc",
                  hint: "Nhập tên công việc",
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: FullWidthButton(
                    onPressed: () {
                      // Navigator.popUntil(context, (route) {
                      //   return route.isFirst;
                      // });
                      submit();
                    },
                    child: Text(
                      "Tiếp theo",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

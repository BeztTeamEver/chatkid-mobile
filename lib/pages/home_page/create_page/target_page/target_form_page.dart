import 'dart:convert';

import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/add_mission_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_add_gift_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_create_item.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_item.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/textarea_input.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TargetFormPage extends ConsumerStatefulWidget {
  const TargetFormPage({super.key});

  @override
  ConsumerState<TargetFormPage> createState() => _TargetFormPageState();
}

class _TargetFormPageState extends ConsumerState<TargetFormPage> {
  final TargetFormStore targetFormStore = Get.find();
  String missionError = "";

  void onSubmit() async {
    setState(() {
      missionError = "";
    });
    targetFormStore.formKey.currentState!.save();
    final startTime =
        targetFormStore.formKey.currentState!.fields['startTime']!;
    final endTime = targetFormStore.formKey.currentState!.fields['endTime']!;
    if (startTime.value != null &&
        endTime.value?.isBefore(startTime.value) == true) {
      endTime.invalidate(
        'Thời gian kết thúc không thể trước thời gian bắt đầu',
        shouldFocus: false,
      );
      return;
    }
    if (targetFormStore.missions.isEmpty) {
      ShowToast.error(msg: "Vui lòng chọn công việc");
      return;
    }
    if (targetFormStore.formKey.currentState!.saveAndValidate()) {
      final missions = targetFormStore.missions;
      final formMissions = [];

      missions.forEach((element) {
        final amount = int.tryParse(
            targetFormStore.formKey.currentState!.value[element] ?? "");
        if (amount == null || amount <= 0) {
          setState(() {
            missionError = "Có công việc chưa được chọn số lượng";
          });
          return;
        }
        formMissions
            .add(MissionModel(amount: amount, taskTypeId: element).toMap());
      });
      if (missions.isEmpty) {
        ShowToast.error(msg: "Vui lòng chọn công việc");
        return;
      }

      if (missionError.isNotEmpty) {
        ShowToast.error(msg: missionError);
        return;
      }

      targetFormStore.formKey.currentState!.fields['startTime']!.didChange(
        (startTime.value as DateTime).startOfDay,
      );
      targetFormStore.formKey.currentState!.fields['endTime']!.didChange(
        (endTime.value as DateTime).endOfDay,
      );
      targetFormStore.formKey.currentState!.fields['missions']!.didChange(
        formMissions,
      );

      targetFormStore.formKey.currentState!.save();
      targetFormStore.increaseStep();
      targetFormStore.updateProgress();
      await Navigator.of(context)
          .push(createRoute(() => TargetAddGiftPage()))
          .then((value) {
        if (value != null) {
          Get.back(result: value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskCategoriesFuture = ref
        .watch(
            getTaskCategoriesProvider(PagingModel(pageSize: 100, pageNumber: 0))
                .future)
        .then((value) {
      targetFormStore.setCategory(value);
      return value;
    });
    return Scaffold(
      primary: false,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderField(
                builder: (field) => Container(),
                name: 'missions',
              ),
              TextAreaInput(
                name: 'message',
                label: 'Lời nhắn',
                minLines: 4,
                maxLines: 4,
                maxLength: 50,
                hint: "Nhập lời nhắn",
                validation: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Vui lòng nhập lời nhắn"),
                  FormBuilderValidators.maxLength(100,
                      errorText: "Không nhập quá 100 ký tự"),
                ]),
              ),
              const SizedBox(height: 14),
              Text(
                'Thời gian bắt đầu',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 4),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: FormBuilderDateTimePicker(
                  name: 'startTime',
                  inputType: InputType.date,
                  format: DateFormat(DateConstants.dateSlashFormat),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thời gian kết thúc',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 4),
              FormBuilderDateTimePicker(
                name: 'endTime',
                autofocus: false,
                autocorrect: false,
                inputType: InputType.date,
                format: DateFormat(DateConstants.dateSlashFormat),
                decoration: InputDecoration(
                  errorMaxLines: 2,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              Text(
                'Công việc',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 4),
              FutureBuilder(
                future: taskCategoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Có lỗi xảy ra');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (targetFormStore.categories.isEmpty) {
                    return const Center(
                      child: Text('Không có dữ liệu'),
                    );
                  }
                  return Obx(
                    () => ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemCount: targetFormStore.missions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        TaskTypeModel? currentTask = null;

                        targetFormStore.categories.forEach((category) {
                          category.taskTypes.forEach((tasktype) {
                            if (tasktype.id ==
                                targetFormStore.missions[index]) {
                              currentTask = tasktype;
                            }
                          });
                        });

                        if (currentTask == null) {
                          return SizedBox();
                        }
                        return MissionItem(
                          taskType: currentTask!,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CreateItemCard(
                onAdd: () {
                  Navigator.of(context)
                      .push(createRoute(() => AddMissionPage()));
                },
              ),
            ],
          ),
        ),
      ),
      extendBody: false,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: FullWidthButton(
          onPressed: () {
            onSubmit();
          },
          child: Text(
            "Tiếp theo",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

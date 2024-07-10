import 'package:chatkid_mobile/constants/todo_form.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/todo_assign_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_number.dart';
import 'package:chatkid_mobile/widgets/select_button_list.dart';
import 'package:chatkid_mobile/widgets/textarea_input.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoFormPage extends StatefulWidget {
  const TodoFormPage({super.key});

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  TodoFormCreateController todoFormCreateController = Get.find();

  String? errorText;
  bool isStartTimeError = false;
  bool isEndTimeError = false;

  @override
  void initState() {
    super.initState();
  }

  validateTime(name) {
    return todoFormCreateController
                .formKey.currentState?.fields['$name.hour1']?.hasError ==
            true ||
        todoFormCreateController
                .formKey.currentState?.fields['$name.hour2']?.hasError ==
            true ||
        todoFormCreateController
                .formKey.currentState?.fields['$name.minute1']?.hasError ==
            true ||
        todoFormCreateController
                .formKey.currentState?.fields['$name.minute2']?.hasError ==
            true;
  }

  void onSubmit() {
    if (todoFormCreateController.formKey.currentState!.saveAndValidate()) {
      final formState = todoFormCreateController.formKey.currentState!;
      final formValue = formState.value;

      final startHour = int.parse(formValue['startTime.hour1']!) * 10 +
          int.parse(formValue['startTime.hour2']!);
      final startMinute = int.parse(formValue['startTime.minute1']!) * 10 +
          int.parse(formValue['startTime.minute2']!);

      final endHour = int.parse(formValue['endTime.hour1']!) * 10 +
          int.parse(formValue['endTime.hour2']!);
      final endMinute = int.parse(formValue['endTime.minute1']!) * 10 +
          int.parse(formValue['endTime.minute2']!);

      if (startHour >= 24 || startMinute >= 60) {
        todoFormCreateController.formKey.currentState?.fields['startTime']
            ?.invalidate("Thời gian không hợp lệ");
        setState(() {
          errorText = "Thời gian không hợp lệ";
        });
        return;
      }
      if (endHour >= 24 || endMinute >= 60) {
        todoFormCreateController.formKey.currentState?.fields['endTime']
            ?.invalidate("Thời gian không hợp lệ");
        todoFormCreateController.formKey.currentState?.fields['endTime']
            ?.save();
        setState(() {
          errorText = "Thời gian không hợp lệ";
        });
        return;
      }

      if (startHour > endHour ||
          (startHour == endHour && startMinute >= endMinute)) {
        todoFormCreateController.formKey.currentState?.fields['startTime']
            ?.invalidate("Thời gian bắt đầu phải nhỏ hơn thời gian kết thúc");
        setState(() {
          errorText = "Thời gian bắt đầu phải nhỏ hơn thời gian kết thúc";
        });
        return;
      }
      setState(() {
        errorText = "";
      });
      final startTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        startHour,
        startMinute,
      );
      formState.fields['startTime']?.didChange(
        startTime,
      );

      final endTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        endHour,
        endMinute,
      );
      formState.fields['endTime']?.didChange(endTime);

      // if (formValue['frequency'].isEmpty) {
      //   formValue['frequency'] = [''];
      // }
      todoFormCreateController.increaseStep();
      todoFormCreateController.updateProgress();
      Navigator.push(context, createRoute(() => TodoAssignPage()));
    } else {
      if (validateTime("startTime")) {
        setState(() {
          isStartTimeError = true;
        });
      } else {
        setState(() {
          isStartTimeError = false;
        });
      }
      if (validateTime("endTime")) {
        setState(() {
          isEndTimeError = true;
        });
      } else {
        setState(() {
          isEndTimeError = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todoFormCreateController.formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // For register new field, create a formBuilderField with no widget
              FormBuilderField(
                initialValue: DateTime.now(),
                builder: (field) {
                  return Container();
                },
                name: "startTime",
              ),
              FormBuilderField(
                initialValue: DateTime.now(),
                builder: (field) {
                  return Container();
                },
                name: "endTime",
              ),
              FormBuilderField(
                initialValue: "",
                builder: (field) {
                  return Container();
                },
                name: "memberId",
              ),
              Obx(
                () => FormBuilderField(
                  initialValue: todoFormCreateController.selectedTaskType.value,
                  builder: (field) {
                    return Container();
                  },
                  name: "taskTypeId",
                ),
              ),
              TextAreaInput(
                label: 'Ghi chú',
                name: "note",
                minLines: 4,
                maxLines: 6,
              ),
              const SizedBox(height: 14),
              Container(
                child: ClockInput(
                  name: "startTime",
                  label: "Thời gian bắt đầu",
                  isError: isStartTimeError,
                  errorText: errorText,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                child: ClockInput(
                  isError: isStartTimeError,
                  name: "endTime",
                  label: "Thời gian kết thúc",
                ),
              ),
              SizedBox(height: 14),
              SelectButtonList<String>(
                name: "frequency",
                label: "Lặp lại trong tuần",
                isMultiple: true,
                options: TodoCreateFormOptions.daysOfWeekOption,
                onSelected: (value) {},
              ),
              SizedBox(height: 14),
              InputNumber(
                name: "giftTicket",
                label: "Thưởng coin",
                rightLableIcon: "coin",
                formKey: todoFormCreateController.formKey,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FullWidthButton(
        onPressed: () {
          onSubmit();
        },
        child: Text(
          "Tiếp tục",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class ClockInput extends StatefulWidget {
  final String name;
  final bool? isError;
  final String? label;
  final String? errorText;

  const ClockInput(
      {super.key,
      required this.name,
      this.label,
      this.isError,
      this.errorText});

  @override
  State<ClockInput> createState() => _ClockInputState();
}

class _ClockInputState extends State<ClockInput> {
  TodoFormCreateController todoFormCreateController = Get.find();

  onEnterTime(String name, String? value) {}

  setInitValue() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitValue();
  }

  @override
  Widget build(BuildContext context) {
    Logger().i(todoFormCreateController
        .formKey.currentState?.fields['${widget.name}']?.errorText);
    final validation =
        ValidationBuilder().required().minLength(1).maxLength(1).build();
    return FocusScope(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Text(
                  widget.label!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: neutral.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                )
              : Container(),
          Container(
            constraints: BoxConstraints(maxWidth: 568),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: constraints.maxWidth / 4 - 16,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextAreaInput(
                          name: "${widget.name}.hour1",
                          fontSize: 20,
                          maxLength: 1,
                          validation: validation,
                          hint: "1",
                          type: TextInputType.number,
                          onChanged: onEnterTime,
                          disableErrorText: true,
                          isNextWhenComplete: true,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: constraints.maxWidth / 4 - 16,
                        child: TextAreaInput(
                          name: "${widget.name}.hour2",
                          fontSize: 20,
                          maxLength: 1,
                          type: TextInputType.number,
                          hint: "0",
                          validation: validation,
                          disableErrorText: true,
                          // onChanged: onEnterTime,
                          isNextWhenComplete: true,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(":",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: neutral.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 36)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: constraints.maxWidth / 4 - 16,
                        child: TextAreaInput(
                          name: "${widget.name}.minute1",
                          fontSize: 20,
                          maxLength: 1,
                          type: TextInputType.number,
                          validation: validation,
                          // onChanged: onEnterTime,
                          disableErrorText: true,
                          isNextWhenComplete: true,
                          hint: "0",
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: constraints.maxWidth / 4 - 16,
                        child: TextAreaInput(
                          name: "${widget.name}.minute2",
                          fontSize: 20,
                          maxLength: 1,
                          hint: "0",
                          type: TextInputType.number,
                          validation: validation,
                          // onChanged: onEnterTime,
                          disableErrorText: true,
                          isNextWhenComplete: true,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          todoFormCreateController.formKey.currentState
                          ?.fields['${widget.name}.hour1']?.hasError ==
                      true ||
                  todoFormCreateController.formKey.currentState
                          ?.fields['${widget.name}.hour2']?.hasError ==
                      true ||
                  todoFormCreateController.formKey.currentState
                          ?.fields['${widget.name}.minute1']?.hasError ==
                      true ||
                  todoFormCreateController.formKey.currentState
                          ?.fields['${widget.name}.minute2']?.hasError ==
                      true
              ? Text(
                  "Thời gian không hợp lệ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                )
              : Container(),
          widget.errorText?.isNotEmpty == true
              ? Text(widget.errorText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red))
              : Container(),
        ],
      ),
    );
  }
}

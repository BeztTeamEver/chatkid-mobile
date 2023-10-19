import 'dart:ffi';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:logger/logger.dart';

class InfoPage extends StatefulWidget {
  final TextEditingController nameController;
  final bool isParent;
  final TextEditingController genderController;
  final TextEditingController yearBirthDayController;
  const InfoPage(
      {super.key,
      required this.nameController,
      required this.genderController,
      this.isParent = true,
      required this.yearBirthDayController});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final userRole = widget.isParent ? "phụ huynh" : "bé";
    return Center(
      child: Form(
        child: Column(
          children: [
            Text(
              "Tài khoản $userRole",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 64,
              height: 64,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 2,
                  color: primary.shade400,
                ),
              ),
              child: SvgIcon(
                icon: iconAnimalList[0],
                size: 50,
              ), //TODO: change icon
            ),
            SizedBox(
              height: 20,
            ),
            InputField(
              hint: 'Nhập tên của bạn',
              label: "Họ và Tên",
              name: "name",
              autoFocus: true,
              controller: widget.nameController,
              validator: ValidationBuilder(
                requiredMessage: "Vui lòng nhập tên",
              ).build(),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Giới tính",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderDropdown(
                  name: "gender",
                  validator: ValidationBuilder(
                          requiredMessage: "Vui lòng chọn giới tính")
                      .build(),
                  dropdownColor: primary.shade50,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Nam",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: 'male',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Nữ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: "female",
                    ),
                  ],
                  onChanged: (value) {
                    widget.genderController.text = value.toString();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InputField(
              name: "yearBirthDay",
              validator: ValidationBuilder(
                requiredMessage: "Vui lòng nhập năm sinh",
              )
                  .minLength(4, "Năm sinh gồm 4 số")
                  .maxLength(4, "Năm sinh gồm 4 số")
                  .required()
                  .add((value) {
                if (value != null &&
                    int.parse(value) > 1900 &&
                    int.parse(value) < DateTime.now().year) {
                  return null;
                }
                return "Năm sinh không hợp lệ";
              }).build(),
              controller: widget.yearBirthDayController,
              type: TextInputType.number,
              label: "Năm sinh",
              hint: "Nhập năm sinh của bạn",
            ),
          ],
        ),
      ),
    );
  }
}

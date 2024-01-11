import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/info_form.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/widgets/wheel_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:logger/logger.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class InfoPage extends StatefulWidget {
  final TextEditingController nameController;
  final bool isParent;
  final TextEditingController roleController;
  final TextEditingController genderController;
  final TextEditingController yearBirthDayController;
  const InfoPage(
      {super.key,
      required this.nameController,
      required this.genderController,
      this.isParent = true,
      required this.roleController,
      required this.yearBirthDayController});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    widget.roleController.text = widget.isParent ? "phụ huynh" : "bé";
    final userRole = widget.isParent ? "phụ huynh" : "bé";
    return Center(
      child: Form(
        child: Column(
          children: [
            Text(
              "Thiết lập tài khoản $userRole",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 20,
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
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
                  height: 10,
                ),
                Container(
                  width: 173,
                  height: 28,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SvgIcon(
                          icon: "edit",
                          size: 16,
                        ),
                        Text(
                          "Thay đổi ảnh đại diện",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            WheelInput(
              label: "Vai trò",
              options: InfoForm.ROLE_OPTIONS,
              controller: widget.roleController,
              description: "Chọn vai trò của bạn",
              hintText: "Chọn vai trò của bạn",
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
                WheelInput(
                  controller: widget.genderController,
                  options: InfoForm.GENDER_OPTIONS,
                  description: "Chọn giới tính của bạn",
                  hintText: "Chọn giới tính của bạn",
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // InputField(
            //   name: "yearBirthDay",
            //   validator: ValidationBuilder(
            //     requiredMessage: "Vui lòng nhập năm sinh",
            //   )
            //       .minLength(4, "Năm sinh gồm 4 số")
            //       .maxLength(4, "Năm sinh gồm 4 số")
            //       .required()
            //       .add((value) {
            //     if (value != null &&
            //         int.parse(value) > 1900 &&
            //         int.parse(value) < DateTime.now().year) {
            //       return null;
            //     }
            //     return "Năm sinh không hợp lệ";
            //   }).build(),
            //   controller: widget.yearBirthDayController,
            //   type: TextInputType.number,
            //   label: "Năm sinh",
            //   hint: "Nhập năm sinh của bạn",
            // ),
          ],
        ),
      ),
    );
  }
}

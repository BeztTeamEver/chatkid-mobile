// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/info_page.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

class InformationUpdate extends ConsumerStatefulWidget {

  const InformationUpdate({super.key});

  @override
  ConsumerState<InformationUpdate> createState() => _InformationUpdateState();
}

class _InformationUpdateState extends ConsumerState<InformationUpdate> {
  final MeController currentUser = Get.find();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final roleController = TextEditingController();
  final avatarController = TextEditingController();
  final yearBirthDayController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.setText(currentUser.profile.value.name ?? '');
    genderController.setText(currentUser.profile.value.gender ?? '');
    roleController.setText(currentUser.profile.value.role ?? '');
    avatarController.setText(currentUser.profile.value.avatarUrl ?? '');
    yearBirthDayController.setText(currentUser.profile.value.yearOfBirth?.toString() ?? '2024');
  }

  void handleUpdateProfile() {
    UserService()
        .updateUser(UserModel(
          id: currentUser.profile.value.id,
          avatarUrl: avatarController.text,
          name: nameController.text,
          gender: genderController.text,
          yearOfBirth: int.parse(yearBirthDayController.text),
        ))
        .then((value) => {
              currentUser.updateProfile(value),
              ShowToast.success(msg: 'Cập nhật thông tin thành công 🎉'),
              Navigator.of(context).pop(),
            })
        .catchError(
          (err) => ShowToast.error(msg: 'Cập nhật thông tin thất bại'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Thông tin tài khoản"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: InfoPage(
                  nameController: nameController,
                  genderController: genderController,
                  avatarController: avatarController,
                  roleController: roleController,
                  yearBirthDayController: yearBirthDayController,
                  isParent: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(width: 2, color: primary.shade500),
                          ),
                          fixedSize: MaterialStatePropertyAll(
                            Size(
                                MediaQuery.of(context).size.width / 2 - 40, 48),
                          ),
                        ),
                        child: const Text(
                          "Huỷ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    FullWidthButton(
                      onPressed: handleUpdateProfile,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: const Text(
                        'Lưu thay đổi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

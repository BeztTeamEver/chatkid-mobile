import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class InformationDetail extends ConsumerStatefulWidget {
  final UserModel user;

  const InformationDetail({super.key, required this.user});

  @override
  ConsumerState<InformationDetail> createState() => _InformationDetailState();
}

class _InformationDetailState extends ConsumerState<InformationDetail> {
  @override
  void initState() {
    super.initState();

    Logger().d(jsonEncode(widget.user));
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
          child: Wrap(
            runSpacing: 16,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Vai trò",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: neutral.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.user.role == RoleConstant.Parent
                        ? 'Phụ huynh'
                        : 'Bé',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: neutral.shade800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Họ và tên",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: neutral.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.user.name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: neutral.shade800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Giới tính",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: neutral.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.user.gender == "male" ? 'Nam' : 'Nữ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: neutral.shade800,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Năm sinh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: neutral.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.user.role == RoleConstant.Parent
                        ? 'Phụ huynh'
                        : 'Bé',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: neutral.shade800,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FullWidthButton(
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Thay đổi thông tin',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

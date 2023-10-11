import 'dart:async';

import 'package:chatkid_mobile/pages/start_page/family_name_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/successful_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfulConFirmPage extends StatelessWidget {
  const SuccessfulConFirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        createRoute(() => FamilyNamePage()),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SuccessfullIcon(),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Xác nhận tài khoản thành công",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 86,
              ),
              SvgPicture.asset("assets/successConfirmPage/success_robot.svg")
            ],
          ),
        ),
      ),
    );
  }
}

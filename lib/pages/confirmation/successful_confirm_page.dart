import 'dart:async';

import 'package:chatkid_mobile/pages/start_page/family_name_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/successful_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child:
                  SvgPicture.asset("assets/successConfirmPage/background.svg"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SuccessfulIcon(),
                    const SizedBox(
                      height: 32,
                      width: double.infinity,
                    ),
                    Text(
                      "Xác nhận tài khoản thành công",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 86,
                ),
                Container(
                  constraints: const BoxConstraints.expand(
                    width: double.infinity,
                    height: 320,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: SvgPicture.asset(
                                  "assets/successConfirmPage/robot_floor.svg"),
                            ),
                            Positioned(
                              child: SvgPicture.asset(
                                  "assets/successConfirmPage/success_robot.svg"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

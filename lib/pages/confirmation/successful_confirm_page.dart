import 'package:chatkid_mobile/widgets/confirmation/successful_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfulConFirmPage extends StatelessWidget {
  const SuccessfulConFirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SuccessfullIcon(),
              SizedBox(
                height: 32,
              ),
              Text(
                "Xác nhận tài khoản thành công",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
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

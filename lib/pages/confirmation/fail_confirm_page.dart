import 'package:chatkid_mobile/widgets/confirmation/fail_icon.dart';
import 'package:chatkid_mobile/widgets/login_logout/google_button_widget.dart';
import 'package:chatkid_mobile/widgets/login_logout/switch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailConfirmPage extends StatelessWidget {
  const FailConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FailIcon(),
              const SizedBox(
                height: 32,
              ),
              Text(
                // TODO: message error
                "Đăng nhập không thành công",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 86,
              ),
              SvgPicture.asset("assets/failConfirmPage/fail_robot.svg"),
              const SizedBox(
                height: 40,
              ),
              const GoogleButton(isLogin: true),
              const SizedBox(
                height: 20,
              ),
              const SwichSignIn(
                isSwitchLogin: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

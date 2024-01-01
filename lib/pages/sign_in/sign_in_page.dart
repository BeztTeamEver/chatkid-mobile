import 'package:chatkid_mobile/pages/sign_up/sign_up_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/login_logout/google_button_widget.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/login_logout/switch_page.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 20),
            Text.rich(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          "Chúng tôi sử dụng tính năng đăng ký bằng tài khoản Google để xác minh rằng người lớn đang thiết lập tài khoản "),
                  TextSpan(
                    text: "KidTalkie",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const TextSpan(
                      text: ", và trẻ của bạn có quyền sử dụng ứng dụng này"),
                ],
              ),
            ),
            const SizedBox(height: 100),
            GoogleButton(isLogin: true),
            const SizedBox(height: 20),
            const SwitchSignIn(),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/loginPage/illusion.svg',
              width: MediaQuery.of(context).size.width - 40,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
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

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoWidget(isShowText: false),
            const SizedBox(height: 20),
            Text(
              "Đăng ký tài khoản".toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  InputField(
                    name: "email",
                    label: "Email",
                    controller: _emailController,
                    hint: "Nhập email của bạn",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FullWidthButton(
                    onPressed: () {
                      Navigator.push(
                          context, createRoute(() => const MainPage()));
                    },
                    child: Text(
                      "Xác nhận",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Hoặc",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GoogleButton(
                    isLogin: false,
                  ),
                  const SizedBox(height: 20),
                  const SwitchSignIn(
                    isSwitchLogin: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'assets/loginPage/illusion.svg',
              width: MediaQuery.of(context).size.width - 50,
            ),
          ],
        ),
      ),
    );
  }
}

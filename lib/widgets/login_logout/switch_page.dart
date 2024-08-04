import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/sign_up/sign_up_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SwitchSignIn extends StatefulWidget {
  final bool isSwitchLogin;
  const SwitchSignIn({
    super.key,
    this.isSwitchLogin = false,
  });

  @override
  State<SwitchSignIn> createState() => _SwitchSignInState();
}

class _SwitchSignInState extends State<SwitchSignIn> {
  @override
  Widget build(BuildContext context) {
    final label = widget.isSwitchLogin
        ? "Bạn đã có tài khoản? "
        : "Bạn chưa có tài khoản? ";
    final textLink = widget.isSwitchLogin ? "Đăng nhập ngay" : "Đăng ký";
    final route = widget.isSwitchLogin ? const LoginPage() : const SignUpPage();

    return Text.rich(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
      textAlign: TextAlign.center,
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: label),
          TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            text: textLink,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Navigator.of(context).push(
                  createRoute(() => route),
                );
              },
          ),
        ],
      ),
    );
  }
}

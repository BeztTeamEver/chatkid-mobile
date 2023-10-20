import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Mật Khẩu cho tài khoản",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Để đảm bảo bí mật cho tài khoản",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: neutral.shade400,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              InputField(
                name: "password",
                controller: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

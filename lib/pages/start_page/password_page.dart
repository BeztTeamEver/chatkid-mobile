import 'package:chatkid_mobile/constants/regex.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class PasswordPage extends ConsumerStatefulWidget {
  final String userId;
  final String? name;
  final GlobalKey<FormBuilderState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const PasswordPage({
    super.key,
    this.name = "",
    required this.userId,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  ConsumerState<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends ConsumerState<PasswordPage> {
  String? _errorText;
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Mật Khẩu cho tài khoản của ${widget.name}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  height: 1.45,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Để đảm bảo bí mật cho tài khoản ;)",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  height: 1.2,
                  color: neutral.shade600,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            label: "Mật khẩu",
            hint: "Mật khẩu của bạn",
            name: "password",
            validator: widget.formKey.currentState?.fields['step']?.value != 1
                ? ValidationBuilder(
                    requiredMessage: "Vui lòng nhập mật khẩu",
                  )
                    .required()
                    .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
                    .regExp(Regex.password, "Mật khẩu bao gồm ký tự và số")
                    .build()
                : null,
            type: TextInputType.visiblePassword,
            controller: widget.passwordController,
            autoFocus: false,
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscured = !_obscured;
                  });
                },
                child: Icon(
                  _obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            label: "Nhập lại mật khẩu",
            hint: "Mật khẩu của bạn",
            validator: (val) {
              if (val !=
                  widget.formKey.currentState?.fields['password']?.value) {
                return "Mật khẩu không khớp";
              }
              return null;
            },
            autoFocus: false,
            name: "confirmPassword",
            type: TextInputType.visiblePassword,
            controller: widget.confirmPasswordController,
          ),
        ],
      ),
    );
  }
}

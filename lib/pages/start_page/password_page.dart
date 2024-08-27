import 'package:chatkid_mobile/constants/regex.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/otp_textfield.dart';
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
  bool _obscuredConfirm = true;

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
          // InputField(
          //   label: "Mật khẩu",
          //   hint: "Mật khẩu của bạn",
          //   name: "password",
          //   validator: widget.formKey.currentState?.fields['step']?.value != 1
          //       ? ValidationBuilder(
          //           requiredMessage: "Vui lòng nhập mật khẩu",
          //         )
          //           .required()
          //           .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
          //           .regExp(Regex.password, "Mật khẩu bao gồm ký tự và số")
          //           .build()
          //       : null,
          //   type: TextInputType.visiblePassword,
          //   controller: widget.passwordController,
          //   autoFocus: false,
          //   isObscure: _obscured,
          //   suffixIcon: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          //     child: GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           _obscured = !_obscured;
          //         });
          //       },
          //       child: Icon(
          //         _obscured
          //             ? Icons.visibility_rounded
          //             : Icons.visibility_off_rounded,
          //         size: 24,
          //       ),
          //     ),
          //   ),
          // ),
          Text(
            "Mật khẩu",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade600,
                ),
          ),
          FormBuilderField(
              focusNode: primaryFocus,
              validator: ValidationBuilder()
                  .required()
                  .minLength(4, "Vui lòng nhập đủ 4 ký tự")
                  .build(),
              builder: (field) {
                return Container(
                  height: 80,
                  child: OtpTextField(
                    height: 40,
                    fontSize: 36,
                    width: 40,
                    length: 4,
                    onCompleted: (value) {
                      field.didChange(value);
                    },
                    isObscured: true,
                    validation: ValidationBuilder()
                        .required()
                        .minLength(4, "Vui lòng nhập đủ 4 ký tự")
                        .build(),
                  ),
                );
              },
              name: "password"),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Nhập lại mật khẩu",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade600,
                ),
          ),
          // InputField(
          //   label: "Nhập lại mật khẩu",
          //   hint: "Mật khẩu của bạn",
          //   validator: (val) {
          //     if (widget.formKey.currentState != null &&
          //         val !=
          //             widget.formKey.currentState?.fields['password']?.value) {
          //       return "Mật khẩu không khớp";
          //     }
          //     return null;
          //   },
          //   isObscure: _obscuredConfirm,
          //   autoFocus: false,
          //   name: "confirmPassword",
          //   type: TextInputType.visiblePassword,
          //   suffixIcon: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          //     child: GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           _obscuredConfirm = !_obscuredConfirm;
          //         });
          //       },
          //       child: Icon(
          //         _obscuredConfirm
          //             ? Icons.visibility_rounded
          //             : Icons.visibility_off_rounded,
          //         size: 24,
          //       ),
          //     ),
          //   ),
          //   controller: widget.confirmPasswordController,
          // ),
          FormBuilderField(
              validator: ValidationBuilder()
                  .required()
                  .minLength(4, "Vui lòng nhập đủ 4 ký tự")
                  .build(),
              builder: (field) {
                return Container(
                  height: 80,
                  child: OtpTextField(
                    isFocus: false,
                    height: 40,
                    fontSize: 36,
                    width: 40,
                    length: 4,
                    onCompleted: (value) {
                      field.didChange(value);
                    },
                    isObscured: true,
                    validation: ValidationBuilder()
                        .required()
                        .minLength(4, "Vui lòng nhập đủ 4 ký tự")
                        .build(),
                  ),
                );
              },
              name: "confirmPassword"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

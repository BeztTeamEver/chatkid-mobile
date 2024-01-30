import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/regex.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/confirmation/successfull_registration.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';

class PasswordPage extends ConsumerStatefulWidget {
  final String userId;
  final GlobalKey<FormBuilderState> formKey;
  final passwordController;
  final confirmPasswordController;
  const PasswordPage({
    super.key,
    required this.userId,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  ConsumerState<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends ConsumerState<PasswordPage> {
  // GlobalKey _formkey = GlobalKey<FormBuilderState>();
  String? _errorText;

  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController =
  //     TextEditingController();

  // Future<void> _submitForm(callback, stopLoading) async {
  //   // TODO: delete when integrate with backend
  //   Navigator.push(
  //       context,
  //       createRoute(
  //         () => SuccessfulRegistrationPage(),
  //       ));
  //   try {
  //     final isValid =
  //         (_formkey.currentState as FormBuilderState).saveAndValidate() &&
  //             (_formkey.currentState as FormBuilderState).isValid;
  //     if (isValid) {
  //       UserModel newUser = UserModel.fromJson({
  //         "id": widget.userId,
  //         "password": passwordController.text,
  //       });
  //       await ref.watch(updateUserProvider(newUser).future).then((value) {
  //         Navigator.pushReplacement(
  //           context,
  //           createRoute(
  //             () => SuccessfulRegistrationPage(
  //               isParent: value.role == RoleConstant.Parent,
  //             ),
  //           ),
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //   } finally {
  //     stopLoading();
  //   }
  // }

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
            "Mật Khẩu cho tài khoản ${widget.userId} của Minh",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  height: 1.45,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Để đảm bảo bí mật cho tài khoản phụ huynh ;)",
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
            validator: ValidationBuilder(
              requiredMessage: "Vui lòng nhập mật khẩu",
              optional: widget.formKey.currentState!.fields['step']!.value != 1,
            )
                .required()
                .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
                .regExp(Regex.password, "Mật khẩu bao gồm ký tự và số")
                .build(),
            type: TextInputType.visiblePassword,
            controller: widget.passwordController,
            autoFocus: false,
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            label: "Nhập lại mật khẩu",
            hint: "Mật khẩu của bạn",
            validator: ValidationBuilder(
              requiredMessage: "Vui lòng nhập mật khẩu",
              optional: widget.formKey.currentState!.fields['step']!.value != 1,
            )
                .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
                .regExp(Regex.password, "Mật khẩu bao gồm ký tự và số")
                .regExp(RegExp(widget.passwordController.text),
                    "Mật khẩu không khớp")
                .build(),
            autoFocus: false,
            name: "confirmPassword",
            type: TextInputType.visiblePassword,
            controller: widget.confirmPasswordController,
          ),
          // const SizedBox(
          //   height: 32,
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: ElevatedButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         child: const Text("Quay lại"),
          //         style: Theme.of(context)
          //             .elevatedButtonTheme
          //             .style!
          //             .copyWith(
          //               elevation: const MaterialStatePropertyAll(2),
          //               shape: MaterialStatePropertyAll(
          //                 RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(40),
          //                   side: BorderSide(
          //                     color: primary.shade400,
          //                     width: 2,
          //                   ),
          //                 ),
          //               ),
          //               backgroundColor:
          //                   MaterialStatePropertyAll(primary.shade50),
          //               foregroundColor:
          //                   MaterialStatePropertyAll(primary.shade400),
          //             ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: LoadingButton(
          //         handleOnTap: (stopLoading) {
          //           _submitForm(() {}, stopLoading);
          //         },
          //         label: "Tiếp tục",
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // SvgPicture.asset(
          //   "assets/loginPage/illusion.svg",
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   height: MediaQuery.of(context).size.height * 0.3,
          // )
        ],
      ),
    );
  }
}

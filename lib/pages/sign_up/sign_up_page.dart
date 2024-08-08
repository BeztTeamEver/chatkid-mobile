import 'package:chatkid_mobile/pages/confirmation/confirmation_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/login_logout/google_button_widget.dart';
import 'package:chatkid_mobile/widgets/login_logout/switch_page.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit() {
    final isValid = _formKey.currentState!.saveAndValidate();

    if (!isValid) return;

    try {
      //TODO: implement sign up with email
      Logger().d(_emailController.text);
      Navigator.push(
          context,
          createRoute(() => ConfirmationPage(
                email: _emailController.text,
              )));
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: Revert to login with gmail when ready
            const LogoWidget(isShowText: true),
            // Text(
            //   "Đăng ký tài khoản".toUpperCase(),
            //   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //         color: Theme.of(context).primaryColor,
            //         fontWeight: FontWeight.w800,
            //       ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    // InputField(
                    //   name: "email",
                    //   label: "Email",
                    //   controller: _emailController,
                    //   hint: "Nhập email của bạn",
                    //   validator: ValidationBuilder(
                    //           requiredMessage: "Vui lòng nhập Email")
                    //       .required()
                    //       .email("Định dang email chưa đúng")
                    //       .build(),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // FullWidthButton(
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //     context, createRoute(() => const MainPage()));
                    //     _onSubmit();
                    //   },
                    //   child: Text(
                    //     "Xác nhận",
                    //     style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    //           color: Colors.white,
                    //         ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Text(
                    //   "Hoặc",
                    //   style: Theme.of(context).textTheme.bodyMedium,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
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
            ),
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

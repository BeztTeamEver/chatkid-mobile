import 'package:chatkid_mobile/constants/regex.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
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

class PasswordLoginPage extends ConsumerStatefulWidget {
  final String userId;
  final String name;
  const PasswordLoginPage(
      {super.key, required this.userId, required this.name});

  @override
  ConsumerState<PasswordLoginPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends ConsumerState<PasswordLoginPage> {
  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  String? _errorText;
  bool _obscured = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  _submit(Function callback) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final isValid = _formkey.currentState!.saveAndValidate();
      if (isValid) {
        String password = _formkey.currentState?.fields['password']!.value;
        await UserService()
            .login(UserModel(
          id: widget.userId,
          deviceToken: await FirebaseService.instance.getFCMToken(),
          password: password,
        ))
            .then((value) async {
          await LocalStorage.instance.preferences.setInt('step', 2);
          callback();
        }).whenComplete(() => setState(() {
                  _isLoading = false;
                }));
      }
    } catch (e) {
      Logger().e(e);
      ErrorSnackbar.showError(err: e, context: context);
      _formkey.currentState!.fields['password']!
          .invalidate(e.toString().split(":")[1], shouldFocus: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 18,
          ),
          child: FormBuilder(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Mật Khẩu cho tài khoản ${widget.name}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Để đảm bảo bí mật cho tài khoản",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: neutral.shade400,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  label: "Mật khẩu",
                  hint: "Mật khẩu của bạn",
                  name: "password",
                  validator: ValidationBuilder(
                          requiredMessage: "Vui lòng nhập mật khẩu")
                      .required()
                      // .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
                      // .regExp(Regex.password, "Mật khẩu bao gồm ký tự và số")
                      .build(),
                  type: TextInputType.visiblePassword,
                  controller: passwordController,
                  isObscure: _obscured,
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
                  height: 70,
                ),
                FullWidthButton(
                  onPressed: () {
                    _submit(
                      () => Navigator.pushAndRemoveUntil(
                        context,
                        createRoute(
                          () => MainPage(),
                        ),
                        (route) => false,
                      ),
                    );
                  },
                  isDisabled: _isLoading,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tiếp tục",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset(
                  "assets/loginPage/illusion.svg",
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

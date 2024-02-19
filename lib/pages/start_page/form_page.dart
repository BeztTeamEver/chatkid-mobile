import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/enum/role.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/confirmation/successfull_registration.dart';
import 'package:chatkid_mobile/pages/start_page/info_page.dart';
import 'package:chatkid_mobile/pages/start_page/password_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/file_provider.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends ConsumerStatefulWidget {
  final UserModel user;
  const FormPage({super.key, required this.user});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _roleController = TextEditingController();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _yearBirthDayController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _avatarController = TextEditingController();
  final _preferences = LocalStorage.instance.preferences;

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? "";
    //TODO: check the user if it is the first time register
    final isFirstRegister =
        _preferences.getBool(LocalStorageKey.IS_FIRST_REGISTER);
    if (isFirstRegister == null) {
      _preferences.setBool(LocalStorageKey.IS_FIRST_REGISTER, true);
      return;
    }
    if (isFirstRegister == true) {
      _preferences.setBool(LocalStorageKey.IS_FIRST_REGISTER, false);
    }
  }

  void _onSubmitInfo(callback, stopLoading) async {
    final isValid = _formKey.currentState!.saveAndValidate() &&
        _formKey.currentState!.isValid;

    if (_currentPage == 0) {
      setState(() {
        _currentPage++;
      });
      _formKey.currentState?.registerField('step', FormBuilderFieldState());
      _formKey.currentState?.save();
      Logger().i(_formKey.currentState?.value);

      _formKey.currentState?.fields['step']?.didChange(1);
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (isValid) {
      UserModel newUser = UserModel.fromJson({
        ..._formKey.currentState!.value,
        "avatarUrl": widget.user.avatarUrl,
        "password": widget.user.password,
        "deviceToken": FirebaseService.instance.fcmToken,
      });
      // callback();
      // stopLoading();
      // return;
      try {
        await ref.watch(createUserProvider(newUser)).whenData((data) {
          Logger().d(data);
          callback();
        });
      } catch (e) {
        Logger().e(e);
        ErrorSnackbar.showError(err: e, context: context);
      } finally {
        stopLoading();
      }
    }
    stopLoading();
    _formKey.currentState!.errors.forEach((key, value) {
      Logger().e("$key: $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatars = ref.watch(getAvatarProvider);
    final formPages = <Widget>[
      InfoPage(
        roleController: _roleController,
        genderController: _genderController,
        nameController: _nameController,
        yearBirthDayController: _yearBirthDayController,
        avatarController: _avatarController,
        isParent: widget.user.role == RoleConstant.Parent,
      ),
      PasswordPage(
        userId: widget.user.id ?? "",
        formKey: _formKey,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 60),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onWillPop: () => Future.value(false),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: 2,
                    onPageChanged: (value) => setState(() {
                      _currentPage = value;
                    }),
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => formPages[index],
                  ),
                ),
                ActionButton(context),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _currentPage == 0 ? 0 : 250,
                  width: 300,
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    "assets/loginPage/illusion.svg",
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == 0) {
                  Navigator.pop(context);
                  return;
                }
                setState(() {
                  _currentPage--;
                });
                _pageController.animateToPage(
                  _currentPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text("Quay lại"),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    elevation: const MaterialStatePropertyAll(2),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                          color: primary.shade400,
                          width: 2,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(primary.shade50),
                    foregroundColor: MaterialStatePropertyAll(primary.shade400),
                  ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _onSubmitInfo(
                  () => Navigator.pushReplacement(
                    context,
                    createRoute(
                      () => StartPage(),
                    ),
                  ),
                  () {},
                );
              },
              child: const Text("Tiếp tục"),
            ),
          ),
        ],
      ),
    );
  }
}

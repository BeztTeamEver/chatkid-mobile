import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/info_form.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/successful_icon.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessfulRegistrationPage extends StatelessWidget {
  final bool _isParent;

  SuccessfulRegistrationPage({super.key, bool isParent = true})
      : _isParent = isParent;

  final SharedPreferences _preferences = LocalStorage.instance.preferences;
  _onCompleted(BuildContext context) async {
    bool isFirstRegister =
        _preferences.getBool(LocalStorageKey.IS_FIRST_REGISTER) ?? false;
    if (isFirstRegister) {
      _preferences
          .setBool(LocalStorageKey.IS_FIRST_REGISTER, false)
          .then((value) => {
                Navigator.pushReplacement(
                  context,
                  createRoute(
                    // TODO: replace with the child role
                    () => FormPage(
                      userRole:
                          _isParent ? RoleConstant.Parent : RoleConstant.Child,
                    ),
                  ),
                )
              });

      return;
    }
    Navigator.pushReplacement(
      context,
      createRoute(
        () => const StartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SuccessfulIcon(),
                    const SizedBox(
                      height: 32,
                      width: double.infinity,
                    ),
                    Text(
                      "Bạn đã tạo thành công tài khoản ${_isParent ? "phụ huynh" : "bé"}",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 86,
              ),
              FullWidthButton(
                onPressed: () {
                  _onCompleted(context);
                },
                child: Text(
                  "Tiếp tục",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              Container(
                constraints: const BoxConstraints.expand(
                  width: double.infinity,
                  height: 320,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: SvgPicture.asset(
                                "assets/successConfirmPage/robot_floor.svg"),
                          ),
                          Positioned(
                            child: SvgPicture.asset(
                                "assets/successConfirmPage/success_robot.svg"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

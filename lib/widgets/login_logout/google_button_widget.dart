import 'package:chatkid_mobile/modals/auth_modal.dart';
import 'package:chatkid_mobile/pages/confirmation/confirmation_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButton extends StatelessWidget {
  final bool isLogin;
  final LocalStorage _localStorage = LocalStorage.instance;

  GoogleButton({super.key, required this.isLogin});

  Future<void> _signInFunction(String accessToken) async {
    try {
      await AuthService.googleLogin(accessToken);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> _signUpFunction(String accessToken) async {
    try {
      await AuthService.signUp(accessToken);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> _signInWithGoogle(
      Function callback, Function errorCallback, Function stopLoading) async {
    LocalStorage prefs = LocalStorage.instance;

    await FirebaseService.instance.signInWithGoogle().then((value) async {
      String token = value.credential!.accessToken!;
      if (isLogin) {
        prefs.preferences.setBool('isFirstScreen', true);
        await _signInFunction(token);
      } else {
        await _signUpFunction(token);
      }
      callback();
    }).catchError(
      (err) async {
        print(err);
        prefs.removeToken();
        errorCallback(err);
      },
    ).whenComplete(
      () => stopLoading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = isLogin
        ? 'Đăng nhập bằng tài khoản google'
        : 'Đăng ký bằng tài khoản Google';
    final route = isLogin
        ? const MainPage()
        : const ConfirmationPage(); // Todo: for testing only
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingBtn(
          height: 60,
          borderRadius: 40,
          width: MediaQuery.of(context).size.width - 40,
          animate: true,
          loader: Container(
            padding: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          onTap: (startLoading, stopLoading, btnState) async {
            if (btnState == ButtonState.idle) {
              startLoading();
              // call your network api
              // await _signInWithGoogle(stopLoading);
              // await Future.delayed(const Duration(seconds: 5));
              await _signInWithGoogle(
                () {
                  Navigator.push(context, createRoute(() => route));
                },
                (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                    ),
                  );
                },
                stopLoading,
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SvgIcon(icon: 'google', size: 34),
              const SizedBox(width: 10),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

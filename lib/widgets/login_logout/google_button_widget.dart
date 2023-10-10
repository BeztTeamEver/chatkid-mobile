import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/pages/confirmation/confirmation_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButton extends StatelessWidget {
  final bool isLogin;
  final LocalStorage _localStorage = LocalStorage.instance;
  late String _email = "";
  late Widget _route = const MainPage();

  GoogleButton({super.key, required this.isLogin});

  Future<void> _signInFunction(String accessToken) async {
    try {
      await AuthService.googleLogin(accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signUpFunction(String accessToken) async {
    try {
      await AuthService.signUp(accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signInWithGoogle(
      Function callback, Function errorCallback, Function stopLoading) async {
    LocalStorage prefs = LocalStorage.instance;

    try {
      await FirebaseService.instance.signInWithGoogle().then((value) async {
        String token = value.credential!.accessToken!;
        Logger().d(token);
        _email = value.user!.email!;
        if (isLogin) {
          prefs.preferences.setBool('isFirstScreen', true);
          await _signInFunction(token);
        } else {
          _route = ConfirmationPage(email: _email);
          await _signUpFunction(token);
        }
        callback();
      }).catchError((err) {
        prefs.removeToken();
        errorCallback(err, StackTrace.current);
      }).whenComplete(
        () => stopLoading(),
      );
    } catch (err, stack) {
      prefs.removeToken();
      errorCallback(err, stack);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = isLogin
        ? 'Đăng nhập bằng tài khoản google'
        : 'Đăng ký bằng tài khoản Google';

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
              await _signInWithGoogle(
                () {
                  Navigator.push(context, createRoute(() => _route));
                },
                (error, stack) {
                  Logger().d(error.toString(), stackTrace: stack);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Đăng nhập thất bại, vui lòng thử lại!"),
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

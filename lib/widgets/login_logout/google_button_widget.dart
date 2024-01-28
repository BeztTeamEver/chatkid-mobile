import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/pages/confirmation/confirmation_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButton extends StatefulWidget {
  final bool isLogin;

  GoogleButton({super.key, required this.isLogin});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isLoading = false;

  final LocalStorage _localStorage = LocalStorage.instance;

  late String _email = "";
  final LocalStorage _prefs = LocalStorage.instance;

  late Widget _route;

  Future<void> _signInFunction(String accessToken) async {
    try {
      _prefs.preferences.setBool('isFirstScreen', true);
      _route = const StartPage();
      await AuthService.googleLogin(accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signUpFunction(String accessToken) async {
    try {
      _route = ConfirmationPage(email: _email);
      await AuthService.signUp(accessToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signInWithGoogle(Function callback) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseService.instance.signInWithGoogle().then((value) async {
        String token = value.credential!.accessToken!;
        Logger().d(token);
        _email = value.user!.email!;
        if (widget.isLogin) {
          await _signInFunction(token);
        } else {
          await _signUpFunction(token);
        }
        Logger().d("Login success");
        callback();
      }).catchError((err) {
        _prefs.removeToken();
        throw err;
      }).whenComplete(() => setState(() {
            _isLoading = false;
          }));
    } catch (err, stack) {
      _prefs.removeToken();
      Logger().d(err.toString(), stackTrace: stack);
      ErrorSnackbar.showError(err: err, context: context, stack: stack);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.isLogin
        ? 'Đăng nhập bằng tài khoản google'
        : 'Đăng ký bằng tài khoản Google';

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FullWidthButton(
            onPressed: () async {
              await _signInWithGoogle(
                () => Navigator.push(context, createRoute(() => _route)),
              );
            },
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                    : const SvgIcon(icon: 'google', size: 28),
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
      ),
    );
  }
}

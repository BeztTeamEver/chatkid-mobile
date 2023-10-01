import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/confirmation/confirmation_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleButton extends StatelessWidget {
  final bool isLogin;

  const GoogleButton({super.key, required this.isLogin});
  _signInWithGoogle(
      Function callback, Function errorCallback, Function stopLoading) async {
    await FirebaseService().signInWithGoogle().then((value) {
      callback();
    }).catchError(
      (err) async {
        print(err);
        errorCallback();
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
              _signInWithGoogle(
                () {
                  Navigator.push(context, createRoute(() => route));
                },
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đăng nhập thất bại'),
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

import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:url_launcher/url_launcher.dart';

// class GoogleButton extends StatelessWidget {
//   const GoogleButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//         ),
//         overlayColor: MaterialStateColor.resolveWith(
//           (states) => Colors.white.withOpacity(0.4),
//         ),
//         padding: MaterialStateProperty.all<EdgeInsets>(
//           const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         ),
//       ),
//     );
//   }
// }

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  _signInWithGoogle(Function callback) async {
    final Uri url = Uri.parse(
        'https://accounts.google.com/accountchooser/identifier?checkedDomains=youtube&continue=https%3A%2F%2Fwww.google.com%2Fwebhp%3Fauthuser%3D&dsh=S-1744306821%3A1695826976292798&flowEntry=AccountChooser&flowName=GlifWebSignIn&pstMsg=1&theme=glif');
    await launchUrl(url, mode: LaunchMode.inAppWebView).then(
      (value) {
        print("value: $value");
        callback();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              await _signInWithGoogle(stopLoading);
              // await Future.delayed(const Duration(seconds: 5));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SvgIcon(icon: 'google', size: 34),
              const SizedBox(width: 10),
              Text(
                'Đăng nhập bằng Google',
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

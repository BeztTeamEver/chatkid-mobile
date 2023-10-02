import 'dart:async';

import 'package:chatkid_mobile/pages/confirmation/successful_confirm_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/login_logout/switch_page.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:chatkid_mobile/widgets/otp_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  int _remainingTime = 120;
  Timer? _timer;

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        timer.cancel();
        return;
      }
      countdownToken();
    });
  }

  void countdownToken() {
    setState(() {
      _remainingTime--;
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = "ngia@gmail.com";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const Center(
                  child: LogoWidget(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: 'Mã xác nhận đã được gửi đến '),
                      TextSpan(text: email),
                    ],
                  ),
                ),
                Text(
                  ' Bạn hãy kiểm tra mail để thực hiện bước xác nhận',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 100,
                ),
                const OtpTextField(),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                // TODO: extract this as a widget
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      // timout the code text
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Mã còn hiệu lực trong '),
                          TextSpan(
                            text: "${_remainingTime}s",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Chưa nhận được mã xác nhận? ',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: neutral.shade500),
                          ),
                          TextSpan(
                            text: 'Gửi lại',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 165,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50),
                        ),
                      ),
                  onPressed: () {
                    Navigator.of(context).push(
                      createRoute(
                        () => const SuccessfulConFirmPage(),
                      ),
                    );
                  },
                  child: const Text('Tiếp tục'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SwichSignIn(
                  isSwitchLogin: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

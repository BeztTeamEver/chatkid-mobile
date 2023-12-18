import 'dart:async';

import 'package:chatkid_mobile/pages/confirmation/fail_confirm_page.dart';
import 'package:chatkid_mobile/pages/confirmation/successful_confirm_page.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/login_logout/switch_page.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:chatkid_mobile/widgets/otp_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';

class ConfirmationPage extends StatefulWidget {
  final String email;

  const ConfirmationPage({super.key, required this.email});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  static const defaultReMainingTime = 120;
  int _remainingTime = defaultReMainingTime;
  bool _isResend = false;
  Timer? _availableTokenTimeOut;
  int _triedTime = 3;
  String _otp = "";
  final _key = GlobalKey<FormState>();

  void startCountdown() {
    _availableTokenTimeOut =
        Timer.periodic(const Duration(seconds: 1), (timer) {
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

  void decreaseTriedTime() {
    setState(() {
      _triedTime--;
    });
  }

  void resetTime() {
    setState(() {
      _remainingTime = defaultReMainingTime;
    });
  }

  void setResend() {
    setState(() {
      _isResend = !_isResend;
    });
  }

  @override
  void initState() {
    super.initState();

    startCountdown();
  }

  @override
  void dispose() {
    if (_availableTokenTimeOut != null) {
      _availableTokenTimeOut!.cancel();
    }
    if (_availableTokenTimeOut != null) {
      _availableTokenTimeOut!.cancel();
    }
    super.dispose();
  }

  Future<void> _verify(Function callback, Function stopLoading) async {
    if (_otp.isEmpty) {
      stopLoading();
      ErrorSnackbar.showError(
          err: ":Mã OTP không được trống", context: context);
      return;
    }
    await AuthService.verifyOtp(_otp).then((value) {
      callback();
    }).catchError((err, stack) {
      decreaseTriedTime();
      if (_triedTime == 0) {
        Navigator.of(context).push(
          createRoute(
            () => const FailConfirmPage(),
          ),
        );
      }
      ErrorSnackbar.showError(err: err, stack: stack, context: context);
    }).whenComplete(() {
      stopLoading();
    });
  }

  Future<void> _resend() async {
    if (!_isResend) setResend();
    await AuthService.resendOtp().then((value) {
      if (_isResend) setResend();
      resetTime();
    }).catchError((err, stack) {
      ErrorSnackbar.showError(err: err, stack: stack, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: remove this when not use

    return Scaffold(
      key: _key,
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
                      TextSpan(text: widget.email),
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
                OtpTextField(
                  length: 6,
                  onCompleted: (value) {
                    setState(() {
                      _otp = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                _triedTime != 3
                    ? Text(
                        'Bạn còn ${_triedTime} lần thử',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: red.shade500,
                            ),
                      )
                    : Container(),
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _resend();
                              },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !_isResend
                                  ? Theme.of(context).primaryColor
                                  : neutral.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 125,
                    ),
                  ],
                ),
                LoadingBtn(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 40,
                  animate: true,
                  borderRadius: 40,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    await _verify(() {
                      Navigator.of(context).pushReplacement(
                        createRoute(
                          () => const SuccessfulConFirmPage(),
                        ),
                      );
                    }, stopLoading);
                  },
                  child: const Text('Tiếp tục'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SwitchSignIn(
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

import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final email = "ngia@gmail.com";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
            ],
          ),
        ),
      ),
    );
  }
}

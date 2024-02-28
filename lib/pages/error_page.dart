import 'package:chatkid_mobile/widgets/confirmation/fail_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage(
      {super.key, this.message = "Đã có lỗi xảy ra vui lòng thử lại sau!"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FailIcon(),
              const SizedBox(
                height: 32,
              ),
              Text(
                // TODO: message error
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 86,
              ),
              SvgPicture.asset("assets/failConfirmPage/fail_robot.svg"),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

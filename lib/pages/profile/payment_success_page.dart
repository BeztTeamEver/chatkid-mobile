import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String dateTime;

  const PaymentSuccessPage({super.key, required this.dateTime});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  MeController me = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanh toán thành công',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: HexColor("#2D2D2D")),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Giao dịch được tạo lúc ${widget.dateTime}',
                style: TextStyle(
                  color: neutral.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                'assets/successConfirmPage/success_payment.png',
                height: 300,
              ),
              Text(
                'Giao dịch thành công, kim cương đã được chuyển vào tài khoản của bạn',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: neutral.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () async {
                  await me.refetch();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: primary.shade500,
                      width: 2,
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 50)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(
                    primary.shade50,
                  ),
                ),
                child: Text(
                  'Quay lại',
                  style: TextStyle(
                    color: primary.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

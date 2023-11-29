import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_confirm_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessPage extends StatefulWidget {
  SubcriptionModel subcription;
  PaymentSuccessPage({super.key, required this.subcription});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/successConfirmPage/success_payment.svg',
                height: 300,
              ),
              Text(
                'Thanh toán thành công',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 26),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Bạn đã thanh toán thành công ${widget.subcription.name}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      createRoute(
                        () => const MainPage(),
                      ),
                    )
                  },
                  style: ButtonStyle(
                    side: const MaterialStatePropertyAll(BorderSide(
                        color: Color.fromRGBO(255, 155, 6, 1), width: 1)),
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 50)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                  ),
                  child: Text(
                    'Quay lại',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.orangeAccent),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

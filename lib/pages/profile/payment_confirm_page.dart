import 'dart:convert';

import 'package:chatkid_mobile/models/paypal_model.dart';
import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/profile/payment_success_page.dart';
import 'package:chatkid_mobile/providers/paypal_provider.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';

class PaymentConfirmPage extends ConsumerStatefulWidget {
  SubcriptionModel supcription;
  String? orderId;
  PaymentConfirmPage({super.key, required this.supcription, this.orderId});

  @override
  ConsumerState<PaymentConfirmPage> createState() => _PaymentConfirmPageState();
}

class _PaymentConfirmPageState extends ConsumerState<PaymentConfirmPage> {
  bool isChecked = true;
  late String orderId;
  @override
  void initState() {
    orderId = widget.orderId ?? "";
  }

  Future<void> onSubmit(callback) async {
    var json = LocalStorage.instance.preferences.getString('user');
    var userId = UserModel.fromJson(jsonDecode(json ?? "")).id;
    Logger().d(UserModel.fromJson(jsonDecode(json ?? "")).id);
    final OrderCaptureModel model = OrderCaptureModel(
        orderId: orderId, userId: userId, energy: widget.supcription.energy);
    try {
      ref
          .watch(
            capturePaypalProvider(model).future,
          )
          .then((value) => (callback()))
          .catchError((err) {
        Logger().e(err);
        ErrorSnackbar.showError(context: context, err: err);
      });
    } catch (err) {
      Logger().e(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset("assets/icons/back.svg"),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 13.0),
                        child: Text(
                          'Xác nhận',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Số tiền thanh toán',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          NumberFormat.formatAmount(widget
                              .supcription.actualPrice!),
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 155, 6, 1),
                              fontSize: 36,
                              fontWeight: FontWeight.bold)),
                      const Text('vnđ',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 155, 6, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Thông tin thanh toán',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Giá trị gói',
                                  style: TextStyle(
                                      color: Color.fromRGBO(165, 168, 187, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${NumberFormat.formatAmount(widget.supcription.actualPrice!)} vnđ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Giảm giá',
                                  style: TextStyle(
                                      color: Color.fromRGBO(165, 168, 187, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '0 vnđ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tổng thanh toán',
                                  style: TextStyle(
                                      color: Color.fromRGBO(165, 168, 187, 1),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${NumberFormat.formatAmount(widget.supcription.actualPrice!)} vnđ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Phương thức thanh toán',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset: const Offset(1, 1))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/payment/paypal.png',
                                    width: 42,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'PayPal',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                side: const BorderSide(width: 0),
                                shape: const CircleBorder(),
                                activeColor: Colors.orangeAccent,
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: LoadingBtn(
                    height: 50,
                    borderRadius: 40,
                    width: double.infinity,
                    loader: Container(
                      padding: const EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    onTap: (startLoading, stopLoading, btnState) async {
                      if (btnState == ButtonState.idle) {
                        startLoading();
                        onSubmit(() {
                          stopLoading();
                          Navigator.push(
                            context,
                            createRoute(
                              () => PaymentSuccessPage(
                                subcription: widget.supcription,
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: Text(
                      "Xác nhận",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  style: ButtonStyle(
                    side: const MaterialStatePropertyAll(BorderSide(
                        color: Color.fromRGBO(255, 155, 6, 1), width: 1.5)),
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
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomMenu(
      //   currentIndex: 3,
      //   onTap: (index) {
      //     Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => MainPage(index: index)));
      //   },
      // ),
    );
  }
}

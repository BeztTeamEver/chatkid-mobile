import 'dart:convert';

import 'package:chatkid_mobile/models/package_model.dart';
import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_success_page.dart';
import 'package:chatkid_mobile/services/payment_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final PackageModel package;
  const PaymentPage({super.key, required this.package});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  bool isChecked = true;
  bool isLoading = false;
  late CreateTransactionModel transaction;

  @override
  void initState() {
    super.initState();
  }

  Future<void> onZaloPaySubmit() async {
    try {
      DateTime now = DateTime.now();
      PaymentService()
          .createZaloPayOrder(widget.package.id)
          .then((value) => {
                FlutterZaloPaySdk.payOrder(zpToken: value.zp_trans_token)
                    .then((event) {
                  switch (event) {
                    case FlutterZaloPayStatus.cancelled:
                      ShowToast.error(msg: "Người dùng huỷ thanh toán!");
                      break;
                    case FlutterZaloPayStatus.success:
                      Navigator.pushReplacement(
                        context,
                        createRoute(
                          () => PaymentSuccessPage(
                            dateTime:
                                "${DateTimeUtils.getFormatTime(now)}, ${DateTimeUtils.getFormatedDate(now, "dd/MM/yyyy")}",
                          ),
                        ),
                      );
                      break;
                    case FlutterZaloPayStatus.failed:
                      ShowToast.error(msg: "Thanh toán thất bại");
                      break;
                    default:
                      ShowToast.error(msg: "Thanh toán thất bại");
                      break;
                  }
                }).catchError((err) {
                  Logger().e(err);
                  ShowToast.error(
                      msg: "Đã có lỗi xảy ra, vui lòng thử lại sau!");
                })
              })
          .catchError(
        (onError) {
          Logger().e(onError);
          ShowToast.error(msg: "Đã có lỗi xảy ra, vui lòng thử lại sau!");
        },
      ).whenComplete(
        () => setState(() {
          isLoading = false;
        }),
      );
    } catch (err) {
      Logger().e(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(primary.shade100),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: primary.shade400,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  "Thanh toán",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Thông tin gói kim cương',
                  style: TextStyle(
                    color: HexColor('#2D2D2D'),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
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
                          Image.asset(
                            "assets/icons/diamond_icon.png",
                            width: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.package.diamond.toString(),
                            style: TextStyle(
                              color: neutral.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${NumberFormat.formatAmount(widget.package.actualPrice.toString())} vnđ',
                        style: TextStyle(
                          color: neutral.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Thông tin thanh toán',
                  style: TextStyle(
                    color: HexColor('#2D2D2D'),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                            Text(
                              'Giá trị gói',
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor('#717171'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${NumberFormat.formatAmount(widget.package.actualPrice.toString())} vnđ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: HexColor('#2D2D2D')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giảm giá',
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor('#717171'),
                                fontWeight: FontWeight.w700,
                              ),
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
                        Divider(
                          color: HexColor('#D7D9E4'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng thanh toán',
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor('#717171'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${NumberFormat.formatAmount(widget.package.actualPrice.toString())} vnđ',
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Phương thức thanh toán',
                  style: TextStyle(
                    color: HexColor('#2D2D2D'),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                                'assets/payment/zalopay.png',
                                width: 42,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'ZaloPay',
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
                            checkColor: Colors.white,
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
              child: FullWidthButton(
                isDisabled: !isChecked || isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  onZaloPaySubmit();
                },
                child: isLoading
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        width: 45,
                        height: 45,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Xác nhận",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                if (isLoading) return;
                Navigator.pop(context);
              },
              style: ButtonStyle(
                side: const MaterialStatePropertyAll(BorderSide(
                    color: Color.fromRGBO(255, 155, 6, 1), width: 1.5)),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
              ),
              child: const Text(
                'Quay lại',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/paypal_model.dart';
import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_confirm_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_momo_qrcode.dart';
import 'package:chatkid_mobile/pages/profile/subcription_page.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/providers/paypal_provider.dart';
import 'package:chatkid_mobile/providers/transaction_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final SubcriptionModel subcription;
  const PaymentPage({super.key, required this.subcription});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  bool isChecked = true;
  bool isLoading = false;
  late PaypalRequestModel model;
  late CreateTransactionModel transaction;

  @override
  void initState() {
    // model = PaypalRequestModel(
    //     amount: widget.subcription.price, returnUrl: "", cancelUrl: "");
    transaction = CreateTransactionModel(
      subscriptionId: widget.subcription.id,
    );
  }

  Future<void> onSubmit(callback) async {
    try {
      ref
          .watch(
            createPaypalProvider(model).future,
          )
          .then((value) => (callback(value.id, value.links[1].href)))
          .catchError((err) {
        Logger().e(err);
        ErrorSnackbar.showError(context: context, err: err);
      });
    } catch (err) {
      Logger().e(err);
    }
  }

  Future<void> onMomoSubmit(callback) async {
    try {
      ref
          .watch(createTransactionProvider(transaction).future)
          .then((value) => callback(value.identifier));
    } catch (err) {
      Logger().e(err);
    }
  }

  _launchPaypalURL(String url, String orderId) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),
              mode: LaunchMode.inAppWebView,
              webViewConfiguration:
                  const WebViewConfiguration(enableDomStorage: false))
          .then((resultingValue) {
        Navigator.push(
          context,
          createRoute(
            () => PaymentConfirmPage(
              supcription: widget.subcription,
              orderId: orderId,
            ),
          ),
        );
      });
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Thanh toán"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                                widget.subcription.diamond.toString(),
                                style: TextStyle(
                                  color: neutral.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${NumberFormat.formatAmount(widget.subcription.actualPrice.toString())} vnđ',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                                  '${NumberFormat.formatAmount(widget.subcription.actualPrice.toString())} vnđ',
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
                                  '${NumberFormat.formatAmount(widget.subcription.actualPrice.toString())} vnđ',
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
                      // if (btnState == ButtonState.idle) {
                      //   startLoading();
                      //   onSubmit((orderId, link) {
                      //     stopLoading();
                      //     _launchPaypalURL(link, orderId);
                      //   });
                      // }
                      onMomoSubmit((String identifier) {
                        Navigator.push(
                          context,
                          createRoute(
                            () => MoMoQRCodePage(
                              index: widget.subcription.diamond,
                              identifier: identifier,
                            ),
                          ),
                        );
                      });
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
                            "Tiếp tục",
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
        ),
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: 3,
        onTap: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage(index: index)),
          );
        },
      ),
    );
  }
}

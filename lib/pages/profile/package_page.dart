import 'package:chatkid_mobile/models/package_model.dart';
import 'package:chatkid_mobile/pages/profile/payment_history_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_page.dart';
import 'package:chatkid_mobile/services/package_service.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  late final Future<List<PackageModel>> packages;
  final WalletController wallet = Get.find();

  @override
  void initState() {
    super.initState();
    packages = PackageService().getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(primary.shade100),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: primary.shade200,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/diamond_icon.png",
                          width: 20,
                        ),
                        Obx(() => Text("${wallet.diamond}"))
                      ],
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(4)),
                      backgroundColor:
                          MaterialStatePropertyAll(primary.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.history_rounded,
                      color: primary.shade400,
                      size: 32,
                    ),
                    onPressed: () => Navigator.push(
                        context, createRoute(() => const PaymentHistoryPage())),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: secondary.shade200,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/payment/bot-head.png", height: 64),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/diamond_icon.png",
                            width: 20,
                          ),
                          Text(
                            "BẢNG GIÁ CÁC GÓI KIM CƯƠNG",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: secondary.shade900,
                            ),
                          ),
                          Image.asset(
                            "assets/icons/diamond_icon.png",
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    FutureBuilder(
                      future: packages,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data as List<PackageModel>;
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => PaymentPage(
                                          package: data[index],
                                        ),
                                      ),
                                    )
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0,
                                              blurRadius: 6,
                                              offset: const Offset(1, 1))
                                        ]),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          data[index].thumbnailUrl,
                                          fit: BoxFit.cover,
                                          width: 120,
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/icons/diamond_icon.png",
                                                  width: 20,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  data[index]
                                                      .diamond
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 5,
                                              ),
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/payment/card-price.png"),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              child: Text(
                                                '${NumberFormat.formatAmount(data[index].actualPrice.toString() ?? "0")} vnđ',
                                                style: const TextStyle(
                                                  fontSize: 14.4,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 16,
                                  ),
                              itemCount: data.length);
                        }
                        if (snapshot.hasError) {
                          Logger().e(snapshot.error);
                          return Container();
                        } else {
                          return Container(
                            height: 330,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

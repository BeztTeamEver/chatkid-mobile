import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/pages/profile/payment_page.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/services/subcription_service.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class SubcriptionPage extends StatefulWidget {
  const SubcriptionPage({super.key});

  @override
  State<SubcriptionPage> createState() => _SubcriptionPageState();
}

class _SubcriptionPageState extends State<SubcriptionPage> {
  late final Future<List<SubcriptionModel>> subcriptions;
  @override
  void initState() {
    super.initState();
    subcriptions = SubcriptionService().getSubcriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
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
                      child: const Text(
                        "Các gói năng lượng",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: subcriptions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<SubcriptionModel>;
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                createRoute(
                                  () => PaymentPage(
                                    subcription: data[index],
                                  ),
                                ),
                              )
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index].name ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            data[index].energy.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 24),
                                          ),
                                          const Icon(
                                            Icons.bolt_outlined,
                                            color:
                                                Color.fromRGBO(255, 155, 6, 1),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color.fromRGBO(
                                                255, 155, 6, 1)),
                                        child: Text(
                                          '${NumberFormat.formatAmount(data[index].actualPrice!.toStringAsFixed(0))} vnđ',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemCount: data.length);
                  }
                  if (snapshot.hasError) {
                    Logger().e(snapshot.error);
                    return Container();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

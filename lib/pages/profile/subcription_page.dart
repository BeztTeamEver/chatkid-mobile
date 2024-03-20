import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/payment_page.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/services/subcription_service.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class SubcriptionPage extends StatefulWidget {
  const SubcriptionPage({super.key});

  @override
  State<SubcriptionPage> createState() => _SubcriptionPageState();
}

class _SubcriptionPageState extends State<SubcriptionPage> {
  late final Future<List<SubcriptionModel>> subscriptions;
  @override
  void initState() {
    super.initState();
    subscriptions = SubcriptionService().getSubcriptions();
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
        title: Text("Các gói năng lượng"),
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
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: subscriptions,
                builder: (context, snapshot) {
                  Logger().i(snapshot.hasData);
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
                                        color: Colors.grey.withOpacity(0.2),
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
                                          '${NumberFormat.formatAmount(data[index].actualPrice!)} vnđ',
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
      bottomNavigationBar: BottomMenu(
        currentIndex: 3,
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage(index: index)));
        },
      ),
    );
  }
}

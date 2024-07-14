import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/transfer_detail.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferEnergyPage extends StatefulWidget {
  const TransferEnergyPage({super.key});

  @override
  State<TransferEnergyPage> createState() => _TransferEnergyPageState();
}

class _TransferEnergyPageState extends State<TransferEnergyPage> {
  late final String userId = LocalStorage.instance.getUser().id!;
  final WalletController wallet = Get.put(WalletController());
  final Future<FamilyModel> family = FamilyService().getFamily();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Chuyển năng lượng"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: family,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as FamilyModel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(78, 41, 20, 0.03),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: Offset(0, 3))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'THÔNG TIN NĂNG LƯỢNG',
                          style: TextStyle(
                              color: Color.fromRGBO(197, 92, 2, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "Bạn đang có ${wallet.diamond}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.bolt_outlined,
                              color: Color.fromRGBO(255, 155, 6, 1),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ...data.members.fold(<UserModel>[], (previousValue, element) {
                    if (element.id != userId) {
                      previousValue.add(element);
                    }
                    return previousValue;
                  }).map(
                    (user) => GestureDetector(
                      onTap: () {
                        Navigator.push(context, createRoute(() => TransferDetailPage(user: user,)));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(78, 41, 20, 0.03),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: AvatarPng(
                                      imageUrl: user.avatarUrl,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: const Color.fromRGBO(
                                              255, 155, 6, 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            user.diamond?.toString() ?? '0',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.bolt_outlined,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.name ?? "Ẩn danh",
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
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

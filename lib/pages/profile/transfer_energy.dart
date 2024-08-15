import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/transfer_detail.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
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
  final String userId = LocalStorage.instance.getUser().id!;
  final MeController me = Get.find();
  Future<FamilyModel> family = FamilyService().getFamily();

  void refetchFamily() {
    setState(() {
      family = FamilyService().getFamily();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
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
                  const Text(
                    "Quản lý ví kim cương",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            FutureBuilder(
              future: family,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as FamilyModel;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 140,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 8, left: 20, right: 20),
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
                                  'THÔNG TIN KIM CƯƠNG',
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
                                        "Bạn đang có ${me.profile.value.diamond ?? 0}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset(
                                      "assets/icons/diamond_icon.png",
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ...data.members.fold(<UserModel>[],
                              (previousValue, element) {
                            if (element.id != userId) {
                              previousValue.add(element);
                            }
                            return previousValue;
                          }).map(
                            (user) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    createRoute(() => TransferDetailPage(
                                        user: user,
                                        refetchFamily: refetchFamily)));
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(78, 41, 20, 0.03),
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
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.green,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(30),
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
                                                    user.diamond?.toString() ??
                                                        '0',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Image.asset(
                                                    "assets/icons/diamond_icon.png",
                                                    width: 12,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      user.name ?? "Ẩn danh",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height - 180,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

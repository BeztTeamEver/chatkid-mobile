import 'dart:ffi';

import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/models/wallet_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:modals/modals.dart';

class TransferDetailPage extends StatefulWidget {
  final UserModel user;
  final Function() refetchFamily;

  const TransferDetailPage(
      {super.key, required this.user, required this.refetchFamily});

  @override
  State<TransferDetailPage> createState() => _TransferDetailPageState();
}

class _TransferDetailPageState extends State<TransferDetailPage> {
  final String userId = LocalStorage.instance.getUser().id!;
  final WalletController wallet = Get.find();
  final TextEditingController _numberController = TextEditingController();
  int tempCount = 0;

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
        title: const Text("Chuyển kim cương"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        "Bạn đang có ${wallet.diamond}",
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: AvatarPng(
                          imageUrl: widget.user.avatarUrl,
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
                              color: const Color.fromRGBO(255, 155, 6, 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                ((widget.user.diamond ?? 0) + tempCount)
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
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
                  widget.user.name ?? "Ẩn danh",
                  style: const TextStyle(fontWeight: FontWeight.w600),
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
                onPressed: () async {
                  showModal(
                    ModalEntry.positioned(
                      context,
                      tag: 'containerModal',
                      left: 0,
                      top: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: MediaQuery.of(context).size.width - 40,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Chuyển kim cương",
                                    style: TextStyle(
                                      color: neutral.shade900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  InputField(
                                    controller: _numberController,
                                    name: "amount diamond",
                                    label: "Số kim cương",
                                    hint: "Nhập số kim cương",
                                    type: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    validator: ValidationBuilder(
                                      requiredMessage:
                                          'Vui lòng nhập số lượng kim cương',
                                    ).build(),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _numberController.clear();
                                          removeAllModals();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              44,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            border: Border.all(
                                              width: 2,
                                              color: primary.shade500,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Quay lại",
                                              style: TextStyle(
                                                color: primary.shade500,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      FullWidthButton(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                44,
                                        onPressed: () {
                                          wallet.transferDiamond(
                                            TransferDiamondPayloadModel(
                                              ownerId: userId,
                                              receiverId: widget.user.id ?? '',
                                              diamond: int.parse(
                                                  _numberController.text),
                                            ),
                                            () async {
                                              await widget.refetchFamily();
                                              setState(() {
                                                tempCount += int.parse(
                                                    _numberController.text);
                                              });
                                              _numberController.clear();
                                              removeAllModals();
                                            },
                                          );
                                        },
                                        child: const Text(
                                          "Chuyển",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Chuyển kim cương",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
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

import 'package:chatkid_mobile/models/transfer_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/models/wallet_model.dart';
import 'package:chatkid_mobile/pages/profile/card-tranfer.dart';
import 'package:chatkid_mobile/services/transaction_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  final MeController me = Get.find();
  final TextEditingController _numberController = TextEditingController();
  late Future<List<TransferModel>> transferHistory;
  int tempCount = 0;

  @override
  void initState() {
    super.initState();
    transferHistory =
        TransactionService().getTransferHistory(widget.user.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primary.shade100),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      "Chuyển kim cương",
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        fontSize: 18,
                      ),
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
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                          child: SizedBox(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _handleShowModal(context, false);
                        },
                        icon: Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: primary.shade500,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                icon: "arrow-down",
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Rút",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _handleShowModal(context, true);
                        },
                        icon: Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: secondary.shade500,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                icon: "arrow-up",
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Chuyển",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Lịch sử chuyển kim cương",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: neutral.shade900,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              FutureBuilder(
                future: transferHistory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 500,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as List<TransferModel>;
                    return Container(
                      height: MediaQuery.of(context).size.height - 440,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            bottom: 12,
                          ),
                          child: Wrap(
                            runSpacing: 12,
                            children: data
                                .map(
                                  (e) => CardTransfer(
                                    transfer: e,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleShowModal(BuildContext context, bool isTransfer) {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isTransfer ? "Chuyển kim cương" : "Rút kim cương",
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
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      validator: ValidationBuilder(
                        requiredMessage: 'Vui lòng nhập số lượng kim cương',
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
                            width: MediaQuery.of(context).size.width / 2 - 44,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
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
                          width: MediaQuery.of(context).size.width / 2 - 44,
                          onPressed: () {
                            me.transferDiamond(
                              TransferDiamondPayloadModel(
                                ownerId: userId,
                                receiverId: widget.user.id ?? '',
                                diamond: isTransfer
                                    ? int.parse(_numberController.text)
                                    : -int.parse(_numberController.text),
                              ),
                              () async {
                                await widget.refetchFamily();
                                setState(
                                  () {
                                    transferHistory = TransactionService()
                                        .getTransferHistory(
                                            widget.user.id ?? '');
                                    if (isTransfer) {
                                      tempCount +=
                                          int.parse(_numberController.text);
                                    } else {
                                      tempCount -=
                                          int.parse(_numberController.text);
                                    }
                                  },
                                );
                                _numberController.clear();
                                removeAllModals();
                              },
                            );
                          },
                          child: Text(
                            isTransfer ? "Chuyển" : "Rút",
                            style: const TextStyle(
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
  }
}

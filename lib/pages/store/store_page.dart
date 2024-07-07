import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/store/card_item.dart';
import 'package:chatkid_mobile/pages/store/form_item.dart';
import 'package:chatkid_mobile/services/gift_service.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/src/widgets/media_query.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

// RoleConstant.Child
class _StorePageState extends State<StorePage> {
  final UserModel _currentAccount = LocalStorage.instance.getUser();
  late Future<List<GiftModel>> listGifts;
  late WalletController wallet = Get.put(WalletController());
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    listGifts = GiftService().getListGift();
  }

  _handleDeleteStorePage(String id) {
    Alert(
      context: context,
      title: "",
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: !isDeleting,
        animationType: AnimationType.grow,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        titleStyle: TextStyle(
          color: neutral.shade900,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        descStyle: TextStyle(
          color: neutral.shade900,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      desc: "Bạn có chắn chắn muốn xoá quà này không?",
      buttons: [
        DialogButton(
          height: 45,
          border: Border.all(width: 2, color: primary.shade500),
          radius: const BorderRadius.all(Radius.circular(100)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Quay lại",
              style: TextStyle(
                  color: primary.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ),
          onPressed: () {
            if (!isDeleting) Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        DialogButton(
          height: 45,
          border: Border.all(width: 2, color: primary.shade500),
          radius: const BorderRadius.all(Radius.circular(100)),
          color: primary.shade500,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Xác nhận",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ),
          onPressed: () {
            if (isDeleting) return;
            
            setState(() {
              isDeleting = true;
            });
            
            listGifts = GiftService().deleteGift(id).then((value) async {
              await wallet.refetchWallet();
              ShowToast.success(msg: "Xoá quà thành công!");
              return value;
            }).catchError((e) {
              Logger().e(e);
              final errorMessage = e
                  .toString()
                  .split(":")[e.toString().split(":").length - 1]
                  .trim();
              ShowToast.error(msg: errorMessage);
              return listGifts;
            }).whenComplete(() {
              Navigator.of(context).pop();
              setState(() {
                isDeleting = false;
              });
            });
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Logger().i(_currentAccount.accessToken);

    return SafeArea(
      top: true,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: HexColor('DBEDFF'),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("2D9AFF"), width: 12),
                  image: const DecorationImage(
                    image: AssetImage("assets/store/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FutureBuilder(
                  future: listGifts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data ?? [];

                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2.35,
                          bottom: MediaQuery.of(context).size.width / 4,
                        ),
                        child: Column(
                          children: data
                              .map(
                                (e) => CardItem(
                                  gift: e,
                                  handleDelete: _handleDeleteStorePage,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/store/roof_store.png"),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/store/grass.png"),
          ),
          Positioned(
            left: 18,
            top: 14,
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: primary.shade400,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => primary.shade100,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 17,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primary.shade200, width: 2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/store/icon_star.png",
                          width: 25,
                        ),
                        Obx(
                          () => Text(
                            "${wallet.coin}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: neutral.shade900,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 18,
            top: 14,
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: primary.shade400,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => primary.shade100,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FormItem()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

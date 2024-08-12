// ignore_for_file: prefer_is_empty

import 'dart:async';

import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/pages/bot/card_asset_item.dart';
import 'package:chatkid_mobile/pages/bot/empty_data.dart';
import 'package:chatkid_mobile/services/asset_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BotAssetStore extends StatefulWidget {
  const BotAssetStore({super.key});

  @override
  State<BotAssetStore> createState() => _BotAssetStoreState();
}

class _BotAssetStoreState extends State<BotAssetStore>
    with SingleTickerProviderStateMixin {
  late Future<BotAssetTypeModel> botAssets;
  late Future<List<BotAssetModel>> currentSkin;
  String idLoading = '';
  late bool isBuying = false;
  late TabController _tabController;
  late List<BotAssetModel> selectedItem = [];
  int _selectedIndex = 0;
  final MeController me = Get.find();

  final List<BotAssetModel> DEFAULT_SKIN = [
    BotAssetModel(
        id: "1eeca81b-5502-4883-a8c6-be3a38549311",
        name: "oiiiii",
        imageUrl:
            "https://storage.googleapis.com/kid-talkie/BigAsset/Layer4_00.png",
        previewImageUrl:
            "https://storage.googleapis.com/kid-talkie/SmallAsset/Layer4_00.png",
        position: 4,
        price: 100,
        type: "ears",
        createdAt: "2024-05-27T22:49:09.493Z",
        updatedAt: "2024-05-28T23:24:17.831Z",
        status: "Equipped"),
    BotAssetModel(
        id: "07d9a3f1-e6a0-4147-8ebb-2cf5c97b6e7b",
        name: "conan gray",
        imageUrl:
            "https://storage.googleapis.com/kid-talkie/BigAsset/Layer5_00.png",
        previewImageUrl:
            "https://storage.googleapis.com/kid-talkie/SmallAsset/Layer7_00.png",
        position: 5,
        price: 100,
        type: "eyes",
        createdAt: "2024-05-21T21:17:15.088Z",
        updatedAt: "2024-05-28T22:07:09.818Z",
        status: "Equipped"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: _selectedIndex, length: 6, vsync: this);
    botAssets = BotAssetService().getStoreAsset();

    currentSkin = BotAssetService().getCurrentSkin();

    _tabController.animation?.addListener(() {
      int indexChange = _tabController.offset.round();
      int index = _tabController.index + indexChange;

      if (index != _selectedIndex) {
        setState(() => _selectedIndex = index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onSelectItem(BotAssetModel item) {
    if (selectedItem.length > 0 && item.id == selectedItem[0].id) {
      setState(() {
        selectedItem = [];
      });
    } else {
      setState(() {
        idLoading = item.id;
        selectedItem = [item];
      });
      Timer(
        const Duration(milliseconds: 300),
        () => setState(() {
          idLoading = '';
        }),
      );
    }
  }

  void _handleBuyAsset() {
    if (selectedItem.length == 0) return;
    Alert(
      context: context,
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              "BẠN MUỐN MUA TRANG BỊ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: neutral.shade900,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NÀY VỚI GIÁ ${selectedItem[0].price}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: neutral.shade900,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Image.asset(
                  "assets/icons/diamond_icon.png",
                  width: 16,
                ),
                Text(
                  " ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: neutral.shade900,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: !isBuying,
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
      content: Image.network(
        selectedItem[0].previewImageUrl ?? '',
        width: (MediaQuery.of(context).size.width - 56) / 2,
        height: (MediaQuery.of(context).size.width - 56) / 2,
      ),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          onPressed: () {
            if (!isBuying) Navigator.of(context, rootNavigator: true).pop();
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
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          onPressed: () {
            if (isBuying) return;

            setState(() {
              isBuying = true;
            });
            botAssets = BotAssetService()
                .buySkin(selectedItem[0].id)
                .then((value) async {
              await me.refetch();
              setState(() {
                selectedItem = [];
              });
              ShowToast.success(msg: "Mua trang phục thành công 🎉");
              return value;
            }).catchError((e) {
              Logger().e(e);
              final errorMessage = e
                  .toString()
                  .split(":")[e.toString().split(":").length - 1]
                  .trim();
              ShowToast.error(msg: errorMessage);
              return botAssets;
            }).whenComplete(() {
              Navigator.of(context).pop();
              setState(() {
                isBuying = false;
              });
            });
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: secondary.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: FutureBuilder(
                  future: currentSkin,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      late List<BotAssetModel> currentSkin = [
                        ...DEFAULT_SKIN,
                        ...selectedItem
                      ];
                      if (selectedItem.length > 0 &&
                          selectedItem[0].position == 4) {
                        currentSkin = [DEFAULT_SKIN[1], selectedItem[0]];
                      }
                      if (selectedItem.length > 0 &&
                          selectedItem[0].position == 5) {
                        currentSkin = [DEFAULT_SKIN[0], selectedItem[0]];
                      }
                      currentSkin.sort(
                          (a, b) => (a.position ?? 0) - (b.position ?? 0));
                      return Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2 -
                                AppBar().preferredSize.height / 2 +
                                10,
                            decoration: BoxDecoration(color: secondary.shade50),
                          ),
                          Positioned(
                            left: 0,
                            bottom: -70,
                            child: Image.asset(
                              "assets/bots/floor.png",
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          ...currentSkin.map(
                            (item) => Positioned(
                              left: 0,
                              bottom: 60,
                              child: Image.network(
                                item.imageUrl ?? "",
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            top: 14,
                            child: IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: secondary.shade400,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => secondary.shade100,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                            top: 16,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: primary.shade200,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Wrap(
                                      spacing: 8,
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/diamond_icon.png",
                                          width: 20,
                                        ),
                                        Obx(() => Text("${me.profile.value.diamond ?? 0}"))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 9,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => primary.shade50,
                                ),
                                side: BorderSide(
                                    width: 2.0, color: primary.shade500),
                              ),
                              child: SvgIcon(
                                icon: "asset/hanger",
                                size: 24,
                                color: primary.shade500,
                              ),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width / 4,
                            bottom: 12,
                            child: FullWidthButton(
                              isDisabled: selectedItem.length == 0,
                              onPressed: () => _handleBuyAsset(),
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "Mua trang bị",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      Logger().e(snapshot.error);
                      return Container();
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2 -
                            AppBar().preferredSize.height / 2,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: secondary.shade700,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 -
                      AppBar().preferredSize.height / 2,
                  decoration: BoxDecoration(
                    color: secondary.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        controller: _tabController,
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: secondary.shade700,
                        indicator: BoxDecoration(
                            color: secondary.shade300,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        tabs: [
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/emoji',
                                size: 30,
                                color: _selectedIndex == 0
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/hat',
                                size: 23,
                                color: _selectedIndex == 1
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/eyes',
                                size: 30,
                                color: _selectedIndex == 2
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/necklace',
                                size: 29,
                                color: _selectedIndex == 3
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/cloak',
                                size: 30,
                                color: _selectedIndex == 4
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                          Tab(
                            icon: SvgIcon(
                                icon: 'asset/background',
                                size: 24,
                                color: _selectedIndex == 5
                                    ? secondary.shade700
                                    : Colors.white),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: botAssets,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as BotAssetTypeModel;
                            return Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondary.shade300,
                                ),
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            spacing: 12,
                                            children: [
                                              ...(data.emoji ?? []).map(
                                                (e) => e.position == -1
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 2,
                                                                bottom: 8),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/asset/shelf.svg',
                                                          fit: BoxFit.contain,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                        ),
                                                      )
                                                    : CardAssetItem(
                                                        isSellSelected:
                                                            selectedItem.length >
                                                                    0 &&
                                                                selectedItem[0]
                                                                        .id ==
                                                                    e.id,
                                                        idLoading: idLoading,
                                                        isSell: true,
                                                        botAsset: e,
                                                        onClick: _onSelectItem,
                                                      ),
                                              ),
                                              Visibility(
                                                visible:
                                                    (data.emoji ?? []).length ==
                                                        0,
                                                child: const EmptyAssetData(),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          spacing: 12,
                                          children: [
                                            ...(data.hat ?? []).map(
                                              (e) => e.position == -1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 8),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/asset/shelf.svg',
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    )
                                                  : CardAssetItem(
                                                      isSellSelected:
                                                          selectedItem.length >
                                                                  0 &&
                                                              selectedItem[0]
                                                                      .id ==
                                                                  e.id,
                                                      idLoading: idLoading,
                                                      isSell: true,
                                                      botAsset: e,
                                                      onClick: _onSelectItem,
                                                    ),
                                            ),
                                            Visibility(
                                              maintainSize: false,
                                              visible:
                                                  (data.hat ?? []).length == 0,
                                              child: const EmptyAssetData(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          spacing: 12,
                                          children: [
                                            ...(data.eyes ?? []).map(
                                              (e) => e.position == -1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 8),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/asset/shelf.svg',
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    )
                                                  : CardAssetItem(
                                                      isSellSelected:
                                                          selectedItem.length >
                                                                  0 &&
                                                              selectedItem[0]
                                                                      .id ==
                                                                  e.id,
                                                      idLoading: idLoading,
                                                      isSell: true,
                                                      botAsset: e,
                                                      onClick: _onSelectItem,
                                                    ),
                                            ),
                                            Visibility(
                                              visible:
                                                  (data.eyes ?? []).length == 0,
                                              child: const EmptyAssetData(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          spacing: 12,
                                          children: [
                                            ...(data.necklace ?? []).map(
                                              (e) => e.position == -1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 8),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/asset/shelf.svg',
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    )
                                                  : CardAssetItem(
                                                      isSellSelected:
                                                          selectedItem.length >
                                                                  0 &&
                                                              selectedItem[0]
                                                                      .id ==
                                                                  e.id,
                                                      idLoading: idLoading,
                                                      isSell: true,
                                                      botAsset: e,
                                                      onClick: _onSelectItem,
                                                    ),
                                            ),
                                            Visibility(
                                              visible: (data.necklace ?? [])
                                                      .length ==
                                                  0,
                                              child: const EmptyAssetData(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          spacing: 12,
                                          children: [
                                            ...(data.cloak ?? []).map(
                                              (e) => e.position == -1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 8),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/asset/shelf.svg',
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    )
                                                  : CardAssetItem(
                                                      isSellSelected:
                                                          selectedItem.length >
                                                                  0 &&
                                                              selectedItem[0]
                                                                      .id ==
                                                                  e.id,
                                                      idLoading: idLoading,
                                                      isSell: true,
                                                      botAsset: e,
                                                      onClick: _onSelectItem,
                                                    ),
                                            ),
                                            Visibility(
                                              visible:
                                                  (data.cloak ?? []).length ==
                                                      0,
                                              child: const EmptyAssetData(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          spacing: 12,
                                          children: [
                                            ...(data.background ?? []).map(
                                              (e) => e.position == -1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              bottom: 8),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/asset/shelf.svg',
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                    )
                                                  : CardAssetItem(
                                                      isSellSelected:
                                                          selectedItem.length >
                                                                  0 &&
                                                              selectedItem[0]
                                                                      .id ==
                                                                  e.id,
                                                      idLoading: idLoading,
                                                      isSell: true,
                                                      botAsset: e,
                                                      onClick: _onSelectItem,
                                                    ),
                                            ),
                                            Visibility(
                                              visible: (data.background ?? [])
                                                      .length ==
                                                  0,
                                              child: const EmptyAssetData(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            Logger().e(snapshot.error);
                            return Container();
                          } else {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2 -
                                  AppBar().preferredSize.height / 2 -
                                  80,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

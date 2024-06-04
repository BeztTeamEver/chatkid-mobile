import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/pages/bot/card_asset_item.dart';
import 'package:chatkid_mobile/services/asset_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

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
  late TabController _tabController;
  int _selectedIndex = 0;

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
        position: 6,
        price: 100,
        type: "eyes",
        createdAt: "2024-05-21T21:17:15.088Z",
        updatedAt: "2024-05-28T22:07:09.818Z",
        status: "Equipped"),
  ];

  final currentUser = LocalStorage.instance.getUser();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: _selectedIndex, length: 6, vsync: this);
    botAssets = BotAssetService().getStoreAsset();

    currentSkin = BotAssetService().getCurrentSkin();

    Logger().i(currentUser.accessToken);

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

  void _onSelectItem(String id, String status) {
    setState(() {
      idLoading = id;
      currentSkin = BotAssetService().selectAssetItem(id, status);
    });
    Timer(
      const Duration(milliseconds: 300),
      () => setState(() {
        botAssets = BotAssetService().getBotAssets();
      }),
    );
    Timer(
      const Duration(milliseconds: 800),
      () => setState(() {
        idLoading = '';
      }),
    );
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
                        final data = snapshot.data as List<BotAssetModel>;
                        return Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2 -
                                  AppBar().preferredSize.height / 2 +
                                  10,
                              decoration:
                                  BoxDecoration(color: secondary.shade50),
                            ),
                            Positioned(
                              left: 0,
                              bottom: -70,
                              child: Image.asset(
                                "assets/bots/floor.png",
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            ...DEFAULT_SKIN
                                .map(
                                  (item) => Positioned(
                                    left: 0,
                                    bottom: 60,
                                    child: Image.network(
                                      item.imageUrl ?? "",
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                                .toList(),
                            Positioned(
                              left: 18,
                              top: 14,
                              child: IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: secondary.shade400,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
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
                                      border: Border.all(color: primary.shade200),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      child: Wrap(
                                        spacing: 8,
                                        direction: Axis.horizontal,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          Image.asset("assets/icons/diamond_icon.png", width: 20,),
                                          Text('1000')
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
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                    (states) => primary.shade50,
                                  ),
                                  side: BorderSide(
                                      width: 2.0, color: primary.shade500),
                                ),
                                child: SvgIcon(
                                  icon: "asset/hanger",
                                  size: 24,
                                  color: primary.shade700,
                                ),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width / 4,
                              bottom: 12,
                              child: FullWidthButton(
                                onPressed: () {},
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
                    }),
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
                                            runSpacing: 12,
                                            spacing: 12,
                                            children: [
                                              ...(data.ears ?? []).map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    (data.ears?.length ?? 0) >
                                                        0,
                                                child: const SvgIcon(
                                                  icon: "asset/shelf",
                                                ),
                                              ),
                                              ...(data.emoji ?? []).map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
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
                                          runSpacing: 12,
                                          spacing: 12,
                                          children: (data.hat ?? [])
                                              .map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          runSpacing: 12,
                                          spacing: 12,
                                          children: (data.eyes ?? [])
                                              .map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          runSpacing: 12,
                                          spacing: 12,
                                          children: (data.necklace ?? [])
                                              .map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          runSpacing: 12,
                                          spacing: 12,
                                          children: (data.cloak ?? [])
                                              .map(
                                                (e) => CardAssetItem(
                                                  idLoading: idLoading,
                                                  botAsset: e,
                                                  onClick: _onSelectItem,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          runSpacing: 12,
                                          spacing: 12,
                                          children: (data.background ?? [])
                                              .map(
                                                (e) => e.position == -1
                                                    ? Container(
                                                        width: double.infinity,
                                                        height: 4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: secondary
                                                              .shade200,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                4.0),
                                                          ),
                                                        ),
                                                      )
                                                    : CardAssetItem(
                                                        idLoading: idLoading,
                                                        botAsset: e,
                                                        onClick: _onSelectItem,
                                                      ),
                                              )
                                              .toList(),
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

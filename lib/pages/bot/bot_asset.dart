import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/pages/bot/card_asset_item.dart';
import 'package:chatkid_mobile/services/asset_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class BotAsset extends StatefulWidget {
  const BotAsset({super.key});

  @override
  State<BotAsset> createState() => _BotAssetState();
}

class _BotAssetState extends State<BotAsset>
    with SingleTickerProviderStateMixin {
  late Future<BotAssetTypeModel> botAssets;
  late Future<List<BotAssetModel>> currentSkin;
  String idLoading = '';
  late TabController _tabController;
  int _selectedIndex = 0;

  final currentUser = LocalStorage.instance.getUser();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: _selectedIndex, length: 6, vsync: this);
    botAssets = BotAssetService().getBotAssets();

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
    setState(() {
      idLoading = item.id;
      currentSkin = BotAssetService().selectAssetItem(item.id, item.status ?? '');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                AppBar().preferredSize.height / 2,
                            decoration: BoxDecoration(color: primary.shade50),
                          ),
                          ...data
                              .map((item) => Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Image.network(
                                      item.imageUrl ?? "",
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  2 -
                                              AppBar().preferredSize.height / 2,
                                      fit: BoxFit.contain,
                                    ),
                                  ))
                              .toList(),
                          Positioned(
                              left: 18,
                              top: 14,
                              child: IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: primary.shade400,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                    (states) => primary.shade100,
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
                              ))
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2 -
                  AppBar().preferredSize.height / 2,
              decoration: BoxDecoration(
                  color: primary.shade200,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: <Widget>[
                  TabBar(
                    controller: _tabController,
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: primary.shade700,
                    indicator: BoxDecoration(
                        color: primary.shade300,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    tabs: [
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/emoji',
                            size: 30,
                            color: _selectedIndex == 0
                                ? primary.shade700
                                : Colors.white),
                      ),
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/hat',
                            size: 23,
                            color: _selectedIndex == 1
                                ? primary.shade700
                                : Colors.white),
                      ),
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/eyes',
                            size: 30,
                            color: _selectedIndex == 2
                                ? primary.shade700
                                : Colors.white),
                      ),
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/necklace',
                            size: 29,
                            color: _selectedIndex == 3
                                ? primary.shade700
                                : Colors.white),
                      ),
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/cloak',
                            size: 30,
                            color: _selectedIndex == 4
                                ? primary.shade700
                                : Colors.white),
                      ),
                      Tab(
                        icon: SvgIcon(
                            icon: 'asset/background',
                            size: 24,
                            color: _selectedIndex == 5
                                ? primary.shade700
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
                              color: primary.shade300,
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
                                          Container(
                                            width: double.infinity,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: primary.shade200,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(4.0),
                                              ),
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
                                                    decoration: BoxDecoration(
                                                      color: primary.shade200,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(4.0),
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
          ],
        ),
      ),
    );
  }
}

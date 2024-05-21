import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/pages/profile/payment_page.dart';
import 'package:chatkid_mobile/services/subcription_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class BotAsset extends StatefulWidget {
  const BotAsset({super.key});

  @override
  State<BotAsset> createState() => _BotAssetState();
}

class _BotAssetState extends State<BotAsset>
    with SingleTickerProviderStateMixin {
  late final Future<List<SubcriptionModel>> subscriptions;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    subscriptions = SubcriptionService().getSubcriptions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          FutureBuilder(
              future: subscriptions,
              builder: (context, snapshot) {
                Logger().i(snapshot.hasData);
                if (!snapshot.hasData) {
                  // final data = snapshot.data as List<SubcriptionModel>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SvgPicture.asset(
                              'assets/robot/full_pumkin.svg',
                              width: MediaQuery.of(context).size.height / 2,
                              height: MediaQuery.of(context).size.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            color: primary.shade300,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              controller: _tabController,
                              dividerColor: primary.shade300,
                              unselectedLabelColor: Colors.white,
                              tabs: const [
                                Tab(icon: Icon(Icons.directions_car)),
                                Tab(icon: Icon(Icons.directions_transit)),
                                Tab(icon: Icon(Icons.directions_bike)),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Icon(Icons.directions_car),
                                  Icon(Icons.directions_transit),
                                  Icon(Icons.directions_bike),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
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
    );
  }
}

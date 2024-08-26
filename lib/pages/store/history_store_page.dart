import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/pages/store/history_store_tab.dart';
import 'package:chatkid_mobile/pages/store/history_target_tab.dart';
import 'package:chatkid_mobile/services/gift_service.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryStorePage extends StatefulWidget {
  final UserModel user;

  const HistoryStorePage({super.key, required this.user});

  @override
  State<HistoryStorePage> createState() => _HistoryStorePageState();
}

class _HistoryStorePageState extends State<HistoryStorePage>
    with SingleTickerProviderStateMixin {
  late List<GiftModel> historyStore;
  late List<HistoryTargetModel> historyTarget;
  late final TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final value = await Future.wait([
      GiftService().getListHistory(widget.user.id ?? ''),
      TargetService().getHistoryTarget(widget.user.id ?? ''),
    ]);
    setState(() {
      historyStore = value[0] as List<GiftModel>;
      historyTarget = value[1] as List<HistoryTargetModel>;
      isLoading = false;
    });
  }

  void updateHistoryStoreData(int idx) {
    setState(() {
      historyStore[idx].status = 'AWARDED';
    });
  }

  void updateHistoryTargetData(int idx) {
    setState(() {
      historyTarget[idx].status = 'AWARDED';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
          child: Column(
            children: [
              Row(
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
                  Text(
                    "Lịch sử đổi quà của ${widget.user.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: primary.shade200,
                    width: 1,
                  ),
                ),
                child: CustomTabBar(
                  onTabChange: (index) {
                    setState(() => _tabController.animateTo(index));
                  },
                  tabs: const ["Quà mục tiêu", "Quà từ cửa hàng"],
                  tabController: _tabController,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: isLoading
                      ? [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 70.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 70.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ]
                      : [
                          HistoryTargetTab(
                            userName: widget.user.name ?? '',
                            histories: historyTarget,
                            handleRefetch: updateHistoryTargetData,
                          ),
                          HistoryStoreTab(
                            userName: widget.user.name ?? '',
                            histories: historyStore,
                            handleRefetch: updateHistoryStoreData,
                          ),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/pages/store/history_store_tab.dart';
import 'package:chatkid_mobile/services/gift_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
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
  late Future<List<GiftModel>> histories;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    histories = GiftService().getListHistory(widget.user.id ?? '');
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
                  children: [
                    HistoryStoreTab(histories: histories),
                    // StatisticEmotionTab(statisticEmotion: statisticEmotion),
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

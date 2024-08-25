import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/statistic_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/history_chatbot_card.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/history_store_card.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/statistic_emotion_tab.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/statistic_task_tab.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/providers/history_provider.dart';
import 'package:chatkid_mobile/services/statistic_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingDetailPage extends ConsumerStatefulWidget {
  final UserModel user;

  const TrackingDetailPage({super.key, required this.user});

  @override
  ConsumerState<TrackingDetailPage> createState() => _TrackingDetailPageState();
}

class _TrackingDetailPageState extends ConsumerState<TrackingDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late DateTime firstDOW;
  late DateTime lastDOW;
  int temp = 0;
  late Future<StatisticTaskModel> statisticTask;
  late Future<List<StatisticEmotionModel>> statisticEmotion;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    handleChangeDuration(0);
  }

  void handleFetchStatistic() {
    setState(() {
      statisticTask = StatisticService().getStatisticTask(widget.user.id!,
          firstDOW.format('yyyy-MM-dd'), lastDOW.format('yyyy-MM-dd'));
      statisticEmotion = StatisticService().getStatisticEmotion(widget.user.id!,
          firstDOW.format('yyyy-MM-dd'), lastDOW.format('yyyy-MM-dd'));
    });
  }

  void handleChangeDuration(int count) {
    setState(() {
      temp += count;
      var d = DateTime.now();
      var weekDay = d.weekday;
      firstDOW = d.subtract(Duration(days: weekDay + temp - 1));
      lastDOW = firstDOW.add(const Duration(days: 6));
    });
    handleFetchStatistic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(color: neutral.shade50, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.06),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(1, 6),
                    ),
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.06),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(1, -1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Column(
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: AvatarPng(
                            imageUrl: widget.user.avatarUrl,
                            borderColor: primary.shade500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Bé ${widget.user.name}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: neutral.shade900,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HistoryChatbotCard(
                    user: widget.user,
                  ),
                  HistoryStoreCard(
                    user: widget.user,
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                  tabs: const ["Công việc", "Cảm xúc"],
                  tabController: _tabController,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 24,
                children: [
                  IconButton(
                    color: primary.shade500,
                    onPressed: () => handleChangeDuration(7),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                    ),
                  ),
                  Text(
                    "${firstDOW.format('dd/MM')} đến ${lastDOW.format('dd/MM')}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    disabledColor: neutral.shade500,
                    color: primary.shade500,
                    onPressed:
                        (temp >= 7) ? () => handleChangeDuration(-7) : null,
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    StatisticTaskTab(statisticTask: statisticTask),
                    StatisticEmotionTab(statisticEmotion: statisticEmotion),
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

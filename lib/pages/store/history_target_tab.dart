import 'package:chatkid_mobile/models/statistic_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryTargetTab extends StatefulWidget {
  final Future<StatisticTaskModel> statisticTask;

  const HistoryTargetTab({super.key, required this.statisticTask});

  @override
  State<HistoryTargetTab> createState() => _HistoryTargetTabState();
}

class _HistoryTargetTabState extends State<HistoryTargetTab> {
  final themeColorChart = [
    HexColor('#E337C7'),
    primary.shade500,
    green.shade600,
    blue.shade500,
    HexColor('#594CF0')
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.statisticTask,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data as StatisticTaskModel;
          bool isShowChart = false;
          data.statistic.forEach((element) {
            if (element.count > 0) {
              isShowChart = true;
            }
          });

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 0.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Tổng',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: neutral.shade600,
                            ),
                          ),
                          Text(
                            data.totalTasks.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: neutral.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: neutral.shade100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hoàn thành',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: neutral.shade600,
                            ),
                          ),
                          Text(
                            data.completedTasks.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: neutral.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: neutral.shade100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Bỏ qua',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: neutral.shade600,
                            ),
                          ),
                          Text(
                            data.expiredTasks.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: neutral.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 0.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.55,
                          child: AspectRatio(
                            aspectRatio: 1.3,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius:
                                      MediaQuery.of(context).size.width / 9,
                                  sections: [
                                    if (isShowChart)
                                      ...List.generate(
                                        data.statistic.length,
                                        (i) {
                                          return PieChartSectionData(
                                            color: themeColorChart[i],
                                            value: data.statistic[i].count /
                                                data.totalTasks *
                                                100,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            title: '',
                                          );
                                        },
                                      )
                                    else
                                      PieChartSectionData(
                                        color: neutral.shade200,
                                        value: 100,
                                        radius:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        title: '',
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(data.statistic.length, (i) {
                            return Row(
                              children: [
                                Text(
                                  data.statistic[i].taskCategory,
                                  style: TextStyle(
                                    color: neutral.shade700,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: themeColorChart[i],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            );
                          }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

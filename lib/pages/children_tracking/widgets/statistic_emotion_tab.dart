import 'package:chatkid_mobile/models/statistic_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatisticEmotionTab extends StatefulWidget {
  final Future<List<StatisticEmotionModel>> statisticEmotion;

  const StatisticEmotionTab({super.key, required this.statisticEmotion});

  @override
  State<StatisticEmotionTab> createState() => _StatisticEmotionTabState();
}

class _StatisticEmotionTabState extends State<StatisticEmotionTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.statisticEmotion,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data as List<StatisticEmotionModel>;

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/payment/bot-head.png",
                    width: 150,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Thống kê cảm xúc bé hiện đang trống",
                    style: TextStyle(
                      color: neutral.shade900,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 130),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: data
                  .map((item) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.09),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(1, 6),
                              ),
                            ]),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                  item.taskTypeImageUrl,
                                  width:
                                      MediaQuery.of(context).size.width / 4.45,
                                  height:
                                      MediaQuery.of(context).size.width / 4.45,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        4.45,
                                    child: Text(
                                      'x${item.taskCount}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 30,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.taskType,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children: item.feedbackEmojis
                                      .map((emoji) => Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: primary.shade200,
                                                  ),
                                                ),
                                                child: Image.network(
                                                  emoji.imageUrl,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.45,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.45,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'x${emoji.count}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: neutral.shade800,
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
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

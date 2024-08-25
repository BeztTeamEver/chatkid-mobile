import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryStoreTab extends StatelessWidget {
  final Future<List<GiftModel>> histories;

  const HistoryStoreTab({super.key, required this.histories});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: histories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data as List<GiftModel>;
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 12,
              children: data
                  .map(
                    (item) => Container(
                      width: MediaQuery.of(context).size.width - 44,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 8,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                item.imageUrl!,
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 7,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primary.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SvgIcon(
                                      icon: "coin",
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      (item.numberOfCoin ?? 0).toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateTimeUtils.getFormattedDateTime(
                                    item.createdAt ?? ''),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: neutral.shade500,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                item.title ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: neutral.shade900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
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
                  "Lịch sử đổi quà hiện đang trống",
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
      },
    );
  }
}

import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/history/history_page.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/card_title.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  final int totalItem;
  final List<HistoryModel> histories;
  final UserModel user;

  const ActivityCard({
    super.key,
    required this.user,
    required this.histories,
    required this.totalItem,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 320,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: EdgeInsets.all(20),
      children: [
        CardTitle(
            onPressDetail: () {
              Navigator.push(
                context,
                createRoute(
                  () => HistoryPage(
                    user: widget.user,
                  ),
                ),
              );
            },
            title: 'Lịch sử hoạt động (${widget.totalItem})'),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final dateTime = DateTime(2024, 2, 1, 10);
              // final date = "${dateTime.hour}: ${dateTime.}";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.histories[index].title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: neutral.shade900,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateTimeUtils.getFormatedDate(
                      dateTime,
                      DateTimeUtils.DATE_TIME_ACTIVITY_FORMAT,
                    ),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: neutral.shade600,
                        ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => index != 2
                ? Divider(
                    color: neutral.shade200,
                  )
                : Container(),
            itemCount: widget.histories.length,
          ),
        ),
      ],
    );
  }
}

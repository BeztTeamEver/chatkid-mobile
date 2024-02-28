import 'package:chatkid_mobile/pages/children_tracking/tracking_detail_page.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/card_title.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TasksCard extends StatelessWidget {
  const TasksCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 220,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.all(20),
      children: [
        CardTitle(
            onPressDetail: () {},
            title: 'Quản lý giao việc (${mockTask.length})'),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => index != mockTask.length - 1
                ? Divider(
                    color: neutral.shade200,
                  )
                : Container(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Text(mockTask[index]['content'] ?? '');
            },
          ),
        ),
      ],
    );
  }
}

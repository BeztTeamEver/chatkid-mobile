import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/children_tracking_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/material.dart';

final mockTask = [
  {
    'id': "1",
    'content': 'Minh gửi yêu cầu kiểm tra tiến độ công việc bạn đã giao',
    'title': 'Kiểm tra tiến độ công việc',
  },
  {
    'id': "2",
    'content': 'Minh gửi yêu cầu kiểm tra tiến độ công việc bạn đã giao',
    'title': 'Kiểm tra tiến độ công việc',
  },
  {
    'id': "3",
    'content': 'Minh gửi yêu cầu kiểm tra tiến độ công việc bạn đã giao',
    'title': 'Kiểm tra tiến độ công việc',
  },
];

final mockActivities = <Map<String, dynamic>>[
  {
    'id': '1',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '2',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '3',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '4',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '5',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '6',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '7',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '8',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
  {
    'id': '9',
    'content': 'Minh đã đặt câu hỏi cho botchat Bí Ngô',
    // 'createdAt': DateTime.parse('2024-01-01 10:10:10'),
    'energies': 10,
  },
];

class TrackingDetailPage extends StatefulWidget {
  final String activityId;

  const TrackingDetailPage({super.key, required this.activityId});

  @override
  State<TrackingDetailPage> createState() => _TrackingDetailPageState();
}

class _TrackingDetailPageState extends State<TrackingDetailPage> {
  final UserModel _user = LocalStorage.instance.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tracking Detail',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: headerCard(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: TasksCard(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ActivitiesCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ActivitiesCard() {
    return CustomCard(
      height: 450,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: EdgeInsets.all(20),
      children: [
        CardHeader(
            onPressDetail: () {},
            title: 'Lịch sử hoạt động (${mockActivities.length})'),
        SizedBox(
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
                    mockActivities[index]['content'] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: neutral.shade900,
                        ),
                  ),
                  SizedBox(
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
            separatorBuilder: (context, index) => index != mockActivities.length
                ? Divider(
                    color: neutral.shade200,
                  )
                : Container(),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  Widget TasksCard() {
    return CustomCard(
      height: 200,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.all(20),
      children: [
        CardHeader(
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

  Widget headerCard() {
    return CustomCard(
      height: 160,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: EdgeInsets.all(16),
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: AvatarPng(
                        imageUrl: _user.avatarUrl,
                        borderColor: primary.shade500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _user.name!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: neutral.shade900,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Cấp',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: neutral.shade800,
                          ),
                    ),
                    Text(
                      "10",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: neutral.shade900,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Bạn bè',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: neutral.shade800,
                          ),
                    ),
                    Text(
                      "20",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: neutral.shade900,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Thành tựu',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: neutral.shade800,
                          ),
                    ),
                    Text(
                      "10",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: neutral.shade900,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardHeader extends StatefulWidget {
  final String title;
  final Function()? onPressDetail;

  const CardHeader({
    super.key,
    required this.onPressDetail,
    required this.title,
  });

  @override
  State<CardHeader> createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade600,
                  fontWeight: FontWeight.bold,
                ),
          ),
          GestureDetector(
            onTap: widget.onPressDetail,
            child: Text(
              'Chi tiết',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: primary.shade600,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_modal.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/children_tracking_page.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/activity_card.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/info_card.dart';
import 'package:chatkid_mobile/pages/children_tracking/widgets/task_card.dart';
import 'package:chatkid_mobile/pages/error_page.dart';
import 'package:chatkid_mobile/providers/history_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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

class TrackingDetailPage extends ConsumerStatefulWidget {
  final UserModel user;

  const TrackingDetailPage({super.key, required this.user});

  @override
  ConsumerState<TrackingDetailPage> createState() => _TrackingDetailPageState();
}

class _TrackingDetailPageState extends ConsumerState<TrackingDetailPage> {
  @override
  Widget build(BuildContext context) {
    final histories = ref.watch(
      getHistoryProvider(
        HistoryRequestModal(
          memberId: widget.user.id!,
          paging: PagingModel(pageSize: 5, pageNumber: 0),
        ),
      ).future,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chi tiết hoạt động của ${widget.user.name}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  child: HeaderCard(user: widget.user),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   width: double.infinity,
                //   child: TasksCard(),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: FutureBuilder(
                    future: histories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString().split(':')[1],
                          ),
                        );
                      }

                      final data = snapshot.data!.items;
                      final totalItem = snapshot.data!.totalItem;

                      return Container(
                        width: double.infinity,
                        child: ActivityCard(
                          histories: data,
                          user: widget.user,
                          totalItem: totalItem,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

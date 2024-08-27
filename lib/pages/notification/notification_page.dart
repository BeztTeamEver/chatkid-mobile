import 'package:chatkid_mobile/models/notification_model.dart';
import 'package:chatkid_mobile/pages/notification/notification_detail_page.dart';
import 'package:chatkid_mobile/services/notification_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController notifications = Get.find();

  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();
  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(() async {
      final positions = _itemPositionsListener.itemPositions.value;

      if (positions.last.index == notifications.data.length - 1 &&
          notifications.data.length >= 10 &&
          notifications.isLoadMore.value) {
        if (!notifications.isLoadMore.value) {
          Logger().i("No more data");
          return;
        }
        if (positions.isEmpty) {
          return;
        }

        notifications.fetchMore();
      }
    });
  }

  _listNotificationBuilder(context, index, List<NotificationModel> value) {
    final item = value[index];

    return GestureDetector(
      onTap: () {
        if (item.type == 'SYSTEM') {
          Navigator.push(
            context,
            createRoute(
              () => NotificationDetailPage(
                notification: item,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: primary.shade100,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(78, 41, 20, 0.03),
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: AvatarPng(
                      imageUrl: item.avatarUrl,
                      borderColor: primary.shade100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.senderName,
                        style: TextStyle(
                          color: neutral.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateTimeUtils.getFormattedDateTime(
                            item.createdAt.toString()),
                        style: TextStyle(
                          color: neutral.shade600,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item.type == 'SYSTEM' ? item.title : item.body,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                "Thông báo",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                height: MediaQuery.of(context).size.height,
                child: Obx(
                  () => Column(
                    children: [
                      Expanded(
                        child: ScrollablePositionedList.builder(
                          itemBuilder: (context, index) =>
                              _listNotificationBuilder(
                                  context, index, notifications.data),
                          itemCount: notifications.data.length,
                          padding: EdgeInsets.only(
                            bottom: notifications.loading.value ? 0 : 30,
                          ),
                          scrollOffsetController: _scrollOffsetController,
                          scrollOffsetListener: _scrollOffsetListener,
                          itemScrollController: _scrollController,
                          itemPositionsListener: _itemPositionsListener,
                        ),
                      ),
                      notifications.loading.value
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: Loading(),
                            )
                          : Container(
                              child: Visibility(
                                visible: notifications.data.isEmpty,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 240,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/payment/bot-head.png",
                                          width: 150,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "Lịch sử thanh toán hiện đang trống",
                                          style: TextStyle(
                                            color: neutral.shade900,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

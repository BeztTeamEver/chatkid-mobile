import 'package:chatkid_mobile/models/notification_model.dart';
import 'package:chatkid_mobile/pages/notification/notification_detail_page.dart';
import 'package:chatkid_mobile/services/notification_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = [];
  bool _loading = true;
  bool _isLoadMore = true;
  int _pageNumber = 0;

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
    fetchNotification();
    // notifications = NotificationService().getNotifications();
    _itemPositionsListener.itemPositions.addListener(() async {
      final positions = _itemPositionsListener.itemPositions.value;
      if (!_isLoadMore) {
        Logger().i("No more data");
        return;
      }
      if (positions.isEmpty) {
        return;
      }

      if (positions.last.index == notifications.length - 1 &&
          notifications.length >= 10 &&
          _isLoadMore) {
        fetchNotification();
      }
    });
  }

  void fetchNotification() async {
    try {
      if (!_isLoadMore) {
        Logger().i("No more data");
        return;
      }

      setState(() {
        _loading = true;
      });

      await NotificationService().getNotifications(_pageNumber, 10).then(
        (value) {
          setState(() {
            _isLoadMore =
                value.totalItem > notifications.length + value.items.length;
            _pageNumber++;
            notifications.addAll(value.items);
          });
        },
      ).whenComplete(
        () => setState(
          () {
            _loading = false;
          },
        ),
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  _listNotificationBuilder(context, index, List<NotificationModel> value) {
    if (index == value.length) {
      return const SizedBox(
        height: 80,
      );
    }

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
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(78, 41, 20, 0.03),
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
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
                      borderColor: Colors.transparent,
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
                        'lúc ${item.createdAt!.hour}:${item.createdAt!.minute}, ${item.createdAt!.day}/${item.createdAt!.month}/${item.createdAt!.year}',
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
              Visibility(
                visible: item.type == 'SYSTEM',
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        item.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: neutral.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item.body,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              height: MediaQuery.of(context).size.height - 174,
              child: Column(
                children: [
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemBuilder: (context, index) => _listNotificationBuilder(
                          context, index, notifications),
                      itemCount: notifications.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      scrollOffsetController: _scrollOffsetController,
                      scrollOffsetListener: _scrollOffsetListener,
                      itemScrollController: _scrollController,
                      itemPositionsListener: _itemPositionsListener,
                    ),
                  ),
                  _loading ? const Loading() : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

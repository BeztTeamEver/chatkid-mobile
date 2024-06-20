import 'dart:ui';

import 'package:chatkid_mobile/constants/calendar.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:logger/logger.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _listContainerKey = GlobalKey();
  final _conroller = InfiniteScrollController();
  final todoHomeController = Get.find<TodoHomeStore>();
  // DateTime _selectedDate = DateTime.now();
  double _itemWidth = 0;
  double _listContainerWidth = 0;

  nextPage(
    context, {
    int days = 1,
    double itemWidth = 0,
  }) async {
    _conroller.jumpTo(
      _conroller.offset + itemWidth * days,
    );
    todoHomeController.nextDate(days: days);
  }

//TODO jump to a day

  prevPage(
    context, {
    double itemWidth = 0,
    int days = 1,
  }) async {
    Logger().i(itemWidth);
    _conroller.jumpTo(
      _conroller.offset - itemWidth * days,
    );
    todoHomeController.prevDate(days: days);
  }

  @override
  void dispose() {
    _conroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_listContainerKey.currentContext != null) {
        setState(
          () {
            _listContainerWidth = (_listContainerKey.currentContext!
                    .findRenderObject() as RenderBox)
                .size
                .width;
            _itemWidth = (_listContainerKey.currentContext!.findRenderObject()
                        as RenderBox)
                    .size
                    .width /
                7;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => prevPage(context, itemWidth: _itemWidth),
            child: Container(
              width: 24,
              height: 24,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
            ),
          ),
          Expanded(
            key: _listContainerKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double itemWidth = constraints.maxWidth / 7;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // GetBuilder<TodoHomeStore>(builder: (state) {

                    InfiniteListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: DateTime.now().getDaysInYear,
                      controller: _conroller,
                      itemBuilder: (context, index) {
                        final currentDate = DateTime.now()
                            .sub(Duration(days: 3))
                            .add(Duration(days: index));
                        return Obx(() {
                          final selectedDate =
                              todoHomeController.selectedDate.value;
                          return GestureDetector(
                            onTap: () {
                              if (selectedDate.isBefore(currentDate)) {
                                nextPage(context,
                                    days: currentDate
                                        .difference(selectedDate)
                                        .inDays,
                                    itemWidth: itemWidth);
                                      
                                return;
                              }

                              prevPage(
                                context,
                                days: selectedDate
                                    .add(Duration(days: 1))
                                    .difference(currentDate)
                                    .inDays,
                                itemWidth: itemWidth,
                              );
                            },
                            child: Container(
                              height: 48,
                              width: itemWidth,
                              decoration: BoxDecoration(
                                color: selectedDate.isSameDate(currentDate)
                                    ? primary.shade500
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: selectedDate.isSameDate(currentDate)
                                    ? [
                                        BoxShadow(
                                          color: Theme.of(context).shadowColor,
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${weekDayShort[currentDate.weekday - 1]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: selectedDate
                                              .isSameDate(currentDate)
                                          ? primary.shade100
                                          : selectedDate.isAfter(currentDate)
                                              ? neutral.shade400
                                              : neutral.shade700,
                                    ),
                                  ),
                                  Text(
                                    currentDate.format('dd'),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: selectedDate
                                              .isSameDate(currentDate)
                                          ? primary.shade100
                                          : selectedDate.isAfter(currentDate)
                                              ? neutral.shade400
                                              : neutral.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    // }),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () => nextPage(context, itemWidth: _itemWidth),
            child: Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

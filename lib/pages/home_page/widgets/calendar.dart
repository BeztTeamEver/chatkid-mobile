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

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  final _listContainerKey = GlobalKey();
  final _conroller =
      InfiniteScrollController(keepScrollOffset: true, initialScrollOffset: 48);
  late final TabController _tabController;
  final todoHomeController = Get.find<TodoHomeStore>();
  // DateTime _selectedDate = DateTime.now();
  double _itemWidth = 0;
  double _listContainerWidth = 0;
  DateTime _baseDate = DateTime.now().startOfWeek.add(Duration(days: 1));

  nextPage(
    context, {
    int days = 7,
    double itemWidth = 0,
  }) async {
    setState(() {
      _baseDate = _baseDate.add(Duration(days: days));
    });
    _tabController.animateTo(_baseDate.weekday - 1);
    todoHomeController.setDate(_baseDate);
  }

//TODO jump to a day

  prevPage(
    context, {
    double itemWidth = 0,
    int days = 7,
  }) {
    setState(() {
      _baseDate = _baseDate.subtract(Duration(days: days));
    });
    _tabController.animateTo(_baseDate.weekday - 1);
    todoHomeController.setDate(_baseDate);
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

    _tabController = TabController(
        length: 7,
        vsync: this,
        initialIndex: todoHomeController.selectedDate.value.weekday - 1);
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

  initBaseDate() {
    if (7 == todoHomeController.selectedDate.value.weekday) {
      setState(() {
        _baseDate = todoHomeController.selectedDate.value.startOfWeek
            .subDays(7)
            .add(Duration(days: 1));
      });
    } else {
      setState(() {
        _baseDate = todoHomeController.selectedDate.value.startOfWeek
            .add(Duration(days: 1));
      });
    }
    _tabController.animateTo(todoHomeController.selectedDate.value.weekday - 1);
  }

  changeToday() {
    todoHomeController.setDate(DateTime.now());
    initBaseDate();
  }

  Widget TabItem(DateTime currentDate, double itemWidth) {
    return Obx(
      () => Tab(
        child: ConsistantCalendar(
          itemWidth: itemWidth,
          selectedDate: todoHomeController.selectedDate.value,
          currentDate: currentDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initBaseDate();
    return Column(
      children: [
        Container(
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
                    final weekDays = List.generate(7, (index) {
                      return TabItem(
                        _baseDate.clone.add(Duration(days: index)),
                        itemWidth,
                      );
                    });
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: primary.shade500,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                          labelColor: Colors.white,
                          labelPadding: EdgeInsets.zero,
                          onTap: (value) {
                            todoHomeController.setDate(
                              _baseDate.clone.add(
                                Duration(days: value),
                              ),
                            );
                          },
                          tabs: weekDays,
                        ),
                        // Positioned(
                        //   width: itemWidth,
                        //   top: 2,
                        //   height: 48,
                        //   child: Container(
                        //     width: 10,
                        //     height: 48,
                        //     decoration: BoxDecoration(
                        //         color: primary.shade500,
                        //         borderRadius: BorderRadius.circular(4)),
                        //   ),
                        // ),
                        // GetBuilder<TodoHomeStore>(builder: (state) {
                        // InfiniteListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: DateTime.now().getDaysInMonth,
                        //   controller: _conroller,
                        //   itemBuilder: (context, index) {
                        //     final currentDate = DateTime.now()
                        //         .sub(Duration(days: 1))
                        //         .add(Duration(days: index));
                        //     return Obx(() {
                        //       final selectedDate =
                        //           todoHomeController.selectedDate.value;

                        // return GestureDetector(
                        //   onTap: () {
                        //     if (selectedDate.isBefore(currentDate)) {
                        //       nextPage(context,
                        //           days: currentDate
                        //               .difference(selectedDate)
                        //               .inDays,
                        //           itemWidth: itemWidth);

                        //       return;
                        //     }

                        //     prevPage(
                        //       context,
                        //       days: selectedDate
                        //           .add(Duration(days: 1))
                        //           .difference(currentDate)
                        //           .inDays,
                        //       itemWidth: itemWidth,
                        //     );
                        //   },
                        //   child: ConsistantCalendar(
                        //       itemWidth: itemWidth,
                        //       selectedDate: selectedDate,
                        //       currentDate: currentDate),

                        // );
                        //     });
                        //   },
                        // ),
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
        ),
        SizedBox(
          height: 8,
        ),
        Obx(
          () => Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      "${todoHomeController.selectedDate.value.day}",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: neutral.shade800,
                                fontSize: 46,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${todoHomeController.selectedDate.value.getWeekday + 1 == 8 ? "Chủ nhật" : "Thứ ${todoHomeController.selectedDate.value.getWeekday + 1}"}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: neutral.shade800,
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          'Tháng ${todoHomeController.selectedDate.value.format('M, yyyy')}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: neutral.shade800,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (todoHomeController.selectedDate.value
                          .isSameDate(DateTime.now())) {
                        return;
                      }
                      changeToday();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide(
                            color: todoHomeController.selectedDate.value
                                    .isSameDate(DateTime.now())
                                ? neutral.shade400
                                : primary.shade500,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      todoHomeController.selectedDate.value
                              .isSameDate(DateTime.now())
                          ? "Hôm nay"
                          : "Quay lại hôm nay",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: todoHomeController.selectedDate.value
                                    .isSameDate(DateTime.now())
                                ? neutral.shade400
                                : primary.shade500,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConsistantCalendar extends StatefulWidget {
  const ConsistantCalendar({
    super.key,
    required this.itemWidth,
    required this.selectedDate,
    required this.currentDate,
  });

  final double itemWidth;
  final DateTime selectedDate;
  final DateTime currentDate;

  @override
  State<ConsistantCalendar> createState() => _ConsistantCalendarState();
}

class _ConsistantCalendarState extends State<ConsistantCalendar> {
  @override
  Widget build(BuildContext context) {
    final textColor = widget.selectedDate.isSameDate(widget.currentDate)
        ? primary.shade100
        : widget.currentDate.isBefore(DateTime.now().subDays(1))
            ? neutral.shade400
            : neutral.shade700;
    return Container(
      height: 48,
      width: widget.itemWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 100),
            child: Text(
              "${weekDayShort[widget.currentDate.weekday - 1]}",
            ),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 100),
            child: Text(
              widget.currentDate.format('dd'),
            ),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ffi';

import 'package:chatkid_mobile/constants/calendar.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final _selectedDate = DateTime.now();

  double _itemWidth = 0;
  double _listContainerWidth = 0;
  nextPage(context) async {
    await _conroller.animateTo(
      _conroller.offset + _itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _selectedDate.add(Duration(days: 1));
    });
  }

//TODO jump to a day

  prevPage(context) async {
    await _conroller.animateTo(
      _conroller.offset - _itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _selectedDate.sub(Duration(days: 1));
    });
  }

  @override
  void dispose() {
    _conroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => prevPage(context),
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
            child: Stack(
              fit: StackFit.expand,
              children: _listContainerKey.currentState != null
                  ? [
                      _listContainerKey.currentContext != null
                          ? Positioned(
                              top: 0,
                              left: _listContainerWidth / 2 - _itemWidth / 2,
                              child: Container(
                                width: _itemWidth,
                                height: 48,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                      InfiniteListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: DateTime.now().getDaysInYear,
                        controller: _conroller,
                        anchor: 0,
                        itemBuilder: (context, index) {
                          final currentDate =
                              DateTime.now().add(Duration(days: index));
                          if (_listContainerKey.currentContext == null) {
                            Logger().i("hello");
                            return Container();
                          }
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 48,
                            width: _itemWidth,
                            decoration: BoxDecoration(
                              color: _selectedDate.isSameDay(currentDate)
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${weekDayShort[currentDate.weekday - 1]}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  currentDate.format('dd'),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ]
                  : [],
            ),
          ),
          GestureDetector(
            onTap: () => nextPage(context),
            child: Container(
              width: 24,
              height: 24,
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

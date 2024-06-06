import 'package:chatkid_mobile/constants/calendar.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_listview/infinite_listview.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _listContainerKey = GlobalKey();
  final _conroller = InfiniteScrollController();
  final _selectedDate = DateTime.now();

  nextPage(context) {
    _conroller.animateTo(
      _conroller.offset + MediaQuery.of(context).size.width / 8 + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _selectedDate.add(Duration(days: 1));
    });
  }

//TODO jump to a day

  prevPage(context) {
    _conroller.animateTo(
      _conroller.offset - MediaQuery.of(context).size.width / 8 - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _selectedDate.sub(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final listContainerWidth =
        (_listContainerKey.currentContext?.findRenderObject() as RenderBox)
            .size
            .width;
    final itemWidth = listContainerWidth / 7;
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
              children: [
                Positioned(
                  top: 0,
                  left: listContainerWidth / 2 - itemWidth + 1,
                  child: Container(
                    width: itemWidth,
                    height: 48,
                    color: Colors.red,
                  ),
                ),
                InfiniteListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: DateTime.now().getDaysInYear,
                  controller: _conroller,
                  itemBuilder: (context, index) {
                    final currentDate =
                        DateTime.now().add(Duration(days: index));
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 48,
                      width: itemWidth,
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
              ],
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

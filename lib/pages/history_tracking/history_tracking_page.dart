import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/history_tracking_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/services/history_tracking_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class HistoryTrackingPage extends StatefulWidget {
  final UserModel? user;
  final int? userIndex;
  const HistoryTrackingPage({super.key, this.userIndex, this.user});

  @override
  State<HistoryTrackingPage> createState() => _HistoryTrackingPageState();
}

class _HistoryTrackingPageState extends State<HistoryTrackingPage> {
  late final Future<List<HistoryTrackingModel>> history;
  @override
  void initState() {
    super.initState();
    // history = HistoryTrackingService().getHistory(widget.user!.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/back.svg"),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 13.0),
                      child: const Text(
                        "Chi tiết hoạt động",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: history,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<HistoryTrackingModel>;
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                createRoute(
                                  () => HomePage(),
                                ),
                              )
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(78, 41, 20, 0.03),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: SvgIcon(
                                            icon: iconAnimalList[
                                                widget.userIndex ?? 0]),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.user!.name} đã hỏi ${data[index].content}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Text(
                                            '${data[index].createdTime!.hour}:${data[index].createdTime!.minute}, ${data[index].createdTime!.day}.${data[index].createdTime!.month}.${data[index].createdTime!.year}',
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    165, 168, 187, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${data[index].content}',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: data.length);
                  }
                  if (snapshot.hasError) {
                    Logger().e(snapshot.error);
                    return Container();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

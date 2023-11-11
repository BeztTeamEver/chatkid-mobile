import 'package:chatkid_mobile/models/notification_model.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/services/notification_service.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final Future<List<NotificationModel>> notifications;
  @override
  void initState() {
    super.initState();
    notifications = NotificationService().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 13.0),
                child: const Text(
                  "Thông báo",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            FutureBuilder(
                future: notifications,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<NotificationModel>;
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
                                        offset: const Offset(0, 3))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        child: SvgPicture.asset(
                                            'assets/icons/logo.svg'),
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
                                            data[index].title ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Text(
                                            'lúc ${data[index].createAt!.hour}:${data[index].createAt!.minute}, ${data[index].createAt!.day}/${data[index].createAt!.month}/${data[index].createAt!.year}',
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

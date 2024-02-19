import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/history_tracking/history_tracking_page.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserProfileNotificationPage extends StatefulWidget {
  const UserProfileNotificationPage({super.key});

  @override
  State<UserProfileNotificationPage> createState() =>
      _UserProfileNotificationPageState();
}

class _UserProfileNotificationPageState
    extends State<UserProfileNotificationPage> {
  // late final Future<List<UserModel>> users;

  @override
  void initState() {
    super.initState();
    // users = FamilyService().getKidAccounts(null);
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
                  "Theo dõi hoạt động",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            //   FutureBuilder(
            //       future: users,
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           final data = snapshot.data as List<UserModel>;
            //           return ListView.separated(
            //               scrollDirection: Axis.vertical,
            //               itemBuilder: (context, index) {
            //                 return GestureDetector(
            //                   onTap: () => {
            //                     Navigator.push(
            //                       context,
            //                       createRoute(
            //                         () => HistoryTrackingPage(
            //                           userIndex: index,
            //                           user: data[index],
            //                         ),
            //                       ),
            //                     )
            //                   },
            //                   child: Container(
            //                     margin:
            //                         const EdgeInsets.symmetric(horizontal: 20),
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 20, vertical: 15),
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(15),
            //                         boxShadow: const [
            //                           BoxShadow(
            //                               color: Color.fromRGBO(78, 41, 20, 0.03),
            //                               spreadRadius: 0,
            //                               blurRadius: 6,
            //                               offset: const Offset(0, 3))
            //                         ]),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 border: Border.all(
            //                                     width: 2, color: Colors.green),
            //                                 borderRadius:
            //                                     BorderRadius.circular(50)),
            //                             child: SvgIcon(
            //                               icon: iconAnimalList[index],
            //                               size: 30,
            //                             ),
            //                           ),
            //                         ),
            //                         Text(
            //                           '${data[index].name} đang không hoạt động',
            //                           overflow: TextOverflow.ellipsis,
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .bodyMedium!
            //                               .copyWith(),
            //                         ),
            //                         Text(
            //                           'Có 1 hoạt động của Minh mà bạn chưa xem',
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .bodyMedium!
            //                               .copyWith(
            //                                   color: const Color.fromRGBO(
            //                                       251, 143, 4, 1)),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //               shrinkWrap: true,
            //               separatorBuilder: (context, index) => const SizedBox(
            //                     height: 10,
            //                   ),
            //               itemCount: data.length);
            //         }
            //         if (snapshot.hasError) {
            //           Logger().e(snapshot.error);
            //           return Container();
            //         } else {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       })
          ],
        ),
      ),
    );
  }
}

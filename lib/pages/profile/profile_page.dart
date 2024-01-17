import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final Future<FamilyModel> family;

  @override
  void initState() {
    super.initState();
    // family = FamilyService().getFamily(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // FutureBuilder(
            //   future: family,
            //   builder: ((context, snapshot) {
            //     if (snapshot.hasData) {
            //       final data = snapshot.data as FamilyModel;
            //       final currentUser = UserModel.fromJson(jsonDecode(
            //           LocalStorage.instance.preferences.getString('user') ??
            //               ""));
            //       final wallets = data.users
            //           .firstWhere((e) => e.id == currentUser.id)
            //           .wallets;
            //       int totalEnergy = 0;
            //       if (wallets != null && wallets.isNotEmpty) {
            //         totalEnergy = wallets.first.totalEnergy ?? 0;
            //       }

            //       return ListView(
            //         children: [
            //           SizedBox(
            //             height: 150,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 SvgIcon(
            //                   icon: iconAnimalList[0],
            //                   size: 75,
            //                 ),
            //                 Text(
            //                   currentUser.name ?? "Ẩn danh",
            //                   style: const TextStyle(
            //                       fontWeight: FontWeight.w700, fontSize: 16),
            //                 )
            //               ],
            //             ),
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Tài khoản cá nhân',
            //                 style: TextStyle(
            //                     color: Color.fromRGBO(165, 168, 187, 1),
            //                     fontWeight: FontWeight.w700),
            //               ),
            //               const SizedBox(height: 20),
            //               GestureDetector(
            //                 onTap: () => {
            //                   Navigator.push(
            //                     context,
            //                     createRoute(
            //                       () => WalletPage(
            //                           family: data, currentUser: currentUser),
            //                     ),
            //                   )
            //                 },
            //                 child: Row(
            //                   children: [
            //                     const CircleAvatar(
            //                       backgroundColor:
            //                           Color.fromRGBO(255, 155, 6, 1),
            //                       child: Icon(
            //                         Icons.wallet_outlined,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                     const SizedBox(width: 20),
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         const Text(
            //                           'Ví KidTalkie',
            //                           style: TextStyle(
            //                               fontWeight: FontWeight.w600,
            //                               fontSize: 17,
            //                               letterSpacing: 0.5),
            //                         ),
            //                         Text(
            //                           '${totalEnergy} năng lượng',
            //                           style: const TextStyle(
            //                               color:
            //                                   Color.fromRGBO(165, 168, 187, 1),
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.w600),
            //                         )
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 20,
            //               ),
            //               const Row(
            //                 children: [
            //                   CircleAvatar(
            //                     backgroundColor: Color.fromRGBO(255, 155, 6, 1),
            //                     child: Icon(
            //                       Icons.account_circle_outlined,
            //                       size: 28,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                   SizedBox(width: 20),
            //                   Text(
            //                     'Thông tin tài khoản',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600,
            //                         fontSize: 17,
            //                         letterSpacing: 0.5),
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 20,
            //               ),
            //               const Row(
            //                 children: [
            //                   CircleAvatar(
            //                     backgroundColor: Color.fromRGBO(255, 155, 6, 1),
            //                     child: Icon(
            //                       Icons.brush,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                   SizedBox(width: 20),
            //                   Text(
            //                     'Thay đổi theme',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600,
            //                         fontSize: 17,
            //                         letterSpacing: 0.5),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Tài khoản',
            //                 style: TextStyle(
            //                     color: Color.fromRGBO(165, 168, 187, 1),
            //                     fontWeight: FontWeight.w700),
            //               ),
            //               const SizedBox(height: 20),
            //               ListView.separated(
            //                   itemBuilder: (context, index) {
            //                     return Row(
            //                       children: [
            //                         SvgIcon(
            //                           icon: iconAnimalList[1],
            //                         ),
            //                         const SizedBox(width: 20),
            //                         Text(
            //                           data.users[index].name ?? "Ẩn danh",
            //                           style: const TextStyle(
            //                               fontWeight: FontWeight.w600,
            //                               fontSize: 17,
            //                               letterSpacing: 0.5),
            //                         ),
            //                       ],
            //                     );
            //                   },
            //                   shrinkWrap: true,
            //                   separatorBuilder: (context, index) =>
            //                       const SizedBox(
            //                         height: 30,
            //                       ),
            //                   itemCount: data.users.length)
            //             ],
            //           ),
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Khác',
            //                 style: TextStyle(
            //                     color: Color.fromRGBO(165, 168, 187, 1),
            //                     fontWeight: FontWeight.w700),
            //               ),
            //               const SizedBox(height: 20),
            //               GestureDetector(
            //                 onTap: () => {
            //                   Navigator.push(
            //                     context,
            //                     createRoute(
            //                       () => const StartPage(),
            //                     ),
            //                   )
            //                 },
            //                 child: const Row(
            //                   children: [
            //                     CircleAvatar(
            //                       backgroundColor:
            //                           Color.fromRGBO(255, 155, 6, 1),
            //                       child: Icon(
            //                         Icons.sync_alt_outlined,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                     SizedBox(width: 20),
            //                     Text(
            //                       'Chuyển đổi tài khoản',
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.w600,
            //                           fontSize: 17,
            //                           letterSpacing: 0.5),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ],
            //       );
            //     }
            //     if (snapshot.hasError) {
            //       Logger().e(snapshot.error);
            //       return Container();
            //     } else {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   }),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseService.instance.signOut().then((value) {
                  AuthService.signOut();
                  Navigator.of(context).pushReplacement(
                    createRoute(
                      () => const LoginPage(),
                    ),
                  );
                });
              },
              child: const Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}

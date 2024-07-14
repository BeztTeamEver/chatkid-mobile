import 'dart:convert';

import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/profile/transfer_energy.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Future<UserModel> userProfile;
  late final String userId = LocalStorage.instance.getUser().id!;
  final WalletController wallet = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProfile = ref.watch(userProvider.notifier).getUser(userId);
    final Future<FamilyModel> family = FamilyService().getFamily();
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/profile/bg_profile.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: family,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as FamilyModel;
                        final currentUser = UserModel.fromJson(jsonDecode(
                            LocalStorage.instance.preferences
                                    .getString('user') ??
                                ""));
                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: AvatarPng(
                                    imageUrl: currentUser.avatarUrl,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  currentUser.name ?? "Ẩn danh",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tài khoản cá nhân',
                                  style: TextStyle(
                                    color: Color.fromRGBO(165, 168, 187, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => {
                                    // TODO: PROFILE PAGE
                                    // Navigator.of(context).push(
                                    //   createRoute(
                                    //     () => const InfoPage(

                                    //     ),
                                    //   ),
                                    // )
                                  },
                                  child: const Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(255, 155, 6, 1),
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          size: 28,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Thông tin tài khoản',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.of(context).push(
                                      createRoute(
                                        () => WalletPage(
                                            family: data,
                                            currentUser: currentUser),
                                      ),
                                    )
                                  },
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(255, 155, 6, 1),
                                        child: Icon(
                                          Icons.wallet_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Ví KidTalkie',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                letterSpacing: 0.5),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/diamond_icon.png",
                                                width: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Obx(
                                                () => Text(
                                                  "${wallet.diamond} kim cương",
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        165, 168, 187, 1),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).push(
                                      createRoute(
                                         () => TransferEnergyPage(),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(255, 155, 6, 1),
                                        child: Icon(
                                          Icons.sync_alt_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Chuyển kim cương',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (snapshot.hasError) {
                        Logger().e(snapshot.error);
                        return Container();
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height - 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseService.instance
                              .signOut()
                              .then((value) {
                            // AuthService.signOut();
                            LocalStorage.instance.preferences
                                .remove(LocalStorageKey.USER);
                            Navigator.of(context).pushReplacement(
                              createRoute(
                                () => const StartPage(),
                              ),
                            );
                          });
                        },
                        child: const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                              child: SvgIcon(icon: "transformAccount", color: Colors.white,),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Chuyển tài khoản',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseService.instance
                              .signOut()
                              .then((value) {
                            AuthService.signOut();
                            Navigator.of(context).pushReplacement(
                              createRoute(
                                () => const LoginPage(),
                              ),
                            );
                          });
                        },
                        child: const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

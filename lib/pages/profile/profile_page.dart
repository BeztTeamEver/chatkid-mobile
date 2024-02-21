import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
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
  late Future<UserModel> userProfile;
  late final String userId = LocalStorage.instance.getUser().id!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProfile = ref.watch(userProvider.notifier).getUser(userId);
    final Future<FamilyModel> family = FamilyService().getFamily();
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(12),
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
                        LocalStorage.instance.preferences.getString('user') ??
                            ""));
                    int totalEnergy = 100;
                    return Column(
                      children: [
                        SizedBox(
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              AvatarPng(
                                imageUrl: currentUser.avatarUrl,
                                borderRadius: 40,
                                size: 88,
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
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tài khoản cá nhân',
                              style: TextStyle(
                                  color: Color.fromRGBO(165, 168, 187, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () => {},
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
                                      Text(
                                        '${totalEnergy} năng lượng',
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
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
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
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(255, 155, 6, 1),
                                  child: Icon(
                                    Icons.brush,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Thay đổi theme',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      letterSpacing: 0.5),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(255, 155, 6, 1),
                                  child: Icon(
                                    Icons.person_add_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Yêu cầu kết bạn',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      letterSpacing: 0.5),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Tài khoản bé',
                                style: TextStyle(
                                    color: Color.fromRGBO(165, 168, 187, 1),
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: data.members
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          children: [
                                            AvatarPng(
                                              imageUrl: e.avatarUrl,
                                              borderRadius: 40,
                                              size: 40,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              e.name ?? "Bé",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  letterSpacing: 0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Khác',
                              style: TextStyle(
                                  color: Color.fromRGBO(165, 168, 187, 1),
                                  fontWeight: FontWeight.w700),
                            ),
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
                                    backgroundColor:
                                        Color.fromRGBO(255, 155, 6, 1),
                                    child: Icon(
                                      Icons.sync_alt_outlined,
                                      color: Colors.white,
                                    ),
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
                                    backgroundColor:
                                        Color.fromRGBO(255, 155, 6, 1),
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
                    );
                  }
                  if (snapshot.hasError) {
                    Logger().e(snapshot.error);
                    return Container();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

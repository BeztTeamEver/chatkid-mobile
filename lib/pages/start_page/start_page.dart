import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/pages/start_page/password_login_page.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/providers/step_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  String _role = "";
  late final Future<List<UserModel>> familyUsers;
  UserModel? _selectedAccount = null;
  int _selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    familyUsers = FamilyService().getFamilyAccounts(null);
  }

  void onSelectAccount(UserModel data, int index) {
    if (data.deviceToken != null && data.deviceToken!.isNotEmpty) {
      setState(() {
        _selectedIndex = index;
        _selectedAccount = data;
      });
      return;
    }
    Navigator.push(
      context,
      createRoute(
        () => FormPage(user: data),
      ),
    );
  }

  void onContinue() {
    if (_selectedIndex == -1) {
      return;
    }
    //TODO: route to home page
    Navigator.pushReplacement(context, createRoute(() => const MainPage()));
    LocalStorage.instance.preferences.setInt('step', 2);
    LocalStorage.instance.preferences
        .setString('user', jsonEncode(_selectedAccount!.toMap()));
    Navigator.pushReplacement(
      context,
      createRoute(
        () => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(saveStepProvider(1));

    // final familyUsers = ref.watch(getFamilyProvider(null));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      Text(
                        "Các thành viên trong gia đình",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bạn được tạo tối đa 5 tài khoản cho các thành viên trong gia đình của mình ;)",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: neutral.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // TODO: render famaly accounts
                SelectButton(
                  label: "Phụ huynh",
                  icon:
                      "https://static.vecteezy.com/system/resources/previews/026/619/142/non_2x/default-avatar-profile-icon-of-social-media-user-photo-image-vector.jpg",
                  hasBackground: true,
                  borderColor: primary.shade100,
                  onPressed: () {
                    setState(() {
                      _role = "parent";
                      _selectedIndex = 1;
                    });
                  },
                  isSelected: _role == "parent",
                ),
                const SizedBox(
                  height: 10,
                ),
                SelectButton(
                  label: "Trẻ em",
                  icon:
                      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg",
                  hasBackground: true,
                  borderColor: primary.shade100,
                  isSelected: _role == "children",
                  onPressed: () {
                    setState(() {
                      _role = "children";
                      _selectedIndex = 0;
                    });
                  },
                ),
              ],
            ),
            // FutureBuilder(
            //   future: familyUsers,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       final data = snapshot.data as List<UserModel>;
            //       return ListView.separated(
            //         shrinkWrap: true,
            //         itemCount: data.length,
            //         separatorBuilder: (context, index) => const SizedBox(
            //           height: 10,
            //         ),
            //         itemBuilder: (context, index) {
            //           final icon = data[index].avatarUrl != null &&
            //                   data[index].avatarUrl != ""
            //               ? data[index].avatarUrl
            //               : iconAnimalList[index];
            //           return SizedBox(
            //             width: double.infinity,
            //             child: SelectButton(
            //               isSelected: _selectedIndex == index,
            //               borderColor: primary.shade100,
            //               hasBackground: true,
            //               icon: icon,
            //               label: data[index].name ?? "No name",
            //               onPressed: () {
            //                 onSelectAccount(data[index], index);
            //               },
            //             ),
            //           );
            //         },
            //       );
            //     }
            //     if (snapshot.hasError) {
            //       Logger().e(snapshot.error);
            //       return Container();
            //     } else {
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // ),
            const SizedBox(
              height: 40,
            ),
            FullWidthButton(
              height: 50,
              isDisabled: _selectedIndex == -1,
              onPressed: () {
                onContinue();
              },

              // style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              //       minimumSize: MaterialStateProperty.all<Size>(
              //         const Size(double.infinity, 45),
              //       ),
              //     ),
              child: const Text(
                "Xác nhận đăng nhập",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  "- hoặc -",
                  style: TextStyle(color: neutral.shade500),
                )),
            FullWidthButton(
              height: 50,
              onPressed: () {
                onContinue();
              },
              // style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              //       minimumSize: MaterialStateProperty.all<Size>(
              //         const Size(double.infinity, 45),
              //       ),
              //     ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    icon: "plus",
                    size: 16,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tạo thêm tài khoản mới",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/providers/step_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
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
    LocalStorage.instance.preferences.setInt('step', 2);
    LocalStorage.instance.preferences
        .setString('user', jsonEncode(_selectedAccount!.toMap()));
    Navigator.pushReplacement(
      context,
      createRoute(
        () => MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(saveStepProvider(1));

    // final familyUsers = ref.watch(getFamilyProvider(null));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bạn là ai?",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              // familyUsers.when(
              //   data: (data) => ListView.separated(
              //       shrinkWrap: true,
              //       itemCount: data.length,
              //       separatorBuilder: (context, index) => const SizedBox(
              //             height: 10,
              //           ),
              //       itemBuilder: (context, index) {
              //         final icon = data[index].avatarUrl != null &&
              //                 data[index].avatarUrl != ""
              //             ? data[index].avatarUrl
              //             : iconAnimalList[index];
              //         return SizedBox(
              //           width: double.infinity,
              //           child: SelectButton(
              //             borderColor: primary.shade100,
              //             hasBackground: true,
              //             icon: icon,
              //             label: data[index].name ?? "No name",
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 createRoute(
              //                   () => FormPage(user: data[index]),
              //                 ),
              //               );
              //             },
              //           ),
              //         );
              //       }),
              //   error: (error, stack) {
              //     Logger().e(error, stackTrace: stack);
              //     return Container();
              //   },
              //   loading: () => const CircularProgressIndicator(),
              // ),
              FutureBuilder(
                future: familyUsers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<UserModel>;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        final icon = data[index].avatarUrl != null &&
                                data[index].avatarUrl != ""
                            ? data[index].avatarUrl
                            : iconAnimalList[index];
                        return SizedBox(
                          width: double.infinity,
                          child: SelectButton(
                            isSelected: _selectedIndex == index,
                            borderColor: primary.shade100,
                            hasBackground: true,
                            icon: icon,
                            label: data[index].name ?? "No name",
                            onPressed: () {
                              onSelectAccount(data[index], index);
                            },
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    Logger().e(snapshot.error);
                    return Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  onContinue();
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 45),
                      ),
                    ),
                child: const Text("Xác Nhận"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

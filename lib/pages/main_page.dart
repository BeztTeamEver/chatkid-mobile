import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/enum/role.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int currentIndex = 0;
  UserModel currentAccount = UserModel.fromJson(
      jsonDecode(LocalStorage.instance.preferences.getString('user') ?? "{}"));

  @override
  void initState() {
    super.initState();
  }

  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ref.watch(userProvider.notifier).getUser(currentAccount.id!, null);
    List<Widget> menu =
        MenuList(role: currentAccount.role ?? "Children").getWidgets();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: menu,
        ),
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

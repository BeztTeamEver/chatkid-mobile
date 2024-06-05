import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/routes/home_route.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainPage extends ConsumerStatefulWidget {
  final int index;
  const MainPage({super.key, this.index = 0});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentIndex = 0;
  late UserModel _currentAccount;

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentIndex = widget.index;
      _currentAccount = LocalStorage.instance.getUser();
    });
  }

  void onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final data =
    //     ref.watch(userProvider.notifier).getUser(currentAccount.id!, null);
    List<Widget> menu =
        MenuList(role: _currentAccount.role ?? RoleConstant.Child).getWidgets();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: menu,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 0.5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            onPressed: () {
              // TODO: route to create task page
              setState(() {
                _currentIndex = 0;
              });
            },
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add_sharp,
              size: 42,
              color: Colors.white,
            ),
            backgroundColor: primary.shade500,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: SafeArea(
        maintainBottomViewPadding: false,
        child: BottomMenu(
          currentIndex: _currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}

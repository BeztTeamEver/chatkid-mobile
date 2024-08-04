import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomeRouteWrapper extends StatefulWidget {
  const HomeRouteWrapper({super.key});

  @override
  State<HomeRouteWrapper> createState() => _HomeRouteWrapperState();
}

class _HomeRouteWrapperState extends State<HomeRouteWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = LocalStorage.instance.getUser();
    final menu = MenuList(role: user.role ?? RoleConstant.Child).getMenu();

    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Container(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(createRoute(() => const ExplorePage()));
                    },
                    child: const Text('Detail'),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

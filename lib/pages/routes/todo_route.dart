import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/home_page/todo_home_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TodoRouteWrapper extends StatefulWidget {
  const TodoRouteWrapper({super.key});

  @override
  State<TodoRouteWrapper> createState() => _TodoRouteWrapperState();
}

class _TodoRouteWrapperState extends State<TodoRouteWrapper> {
  @override
  Widget build(BuildContext context) {
    // return Navigator(
    //   onGenerateRoute: (settings) {
    //     return MaterialPageRoute(
    //       settings: settings,
    //       builder: (context) {
    //         return const TodoHomePage();
    //       },
    //     );
    //   },
    // );
    return const TodoHomePage();
  }
}

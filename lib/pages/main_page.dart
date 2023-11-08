import 'package:chatkid_mobile/models/menu_model.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final data = ref.watch(postDataProvider);/
    List<Widget> menu = MenuList(role: 'child').getWidgets();

    void onTap(index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: menu,
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

import 'package:chatkid_mobile/modals/post_modal.dart';
import 'package:chatkid_mobile/pages/home_page.dart';
import 'package:chatkid_mobile/providers/post_provider.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _data = ref.watch(postDataProvider);

    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: HomePage(),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

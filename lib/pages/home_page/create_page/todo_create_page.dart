import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoCreatePage extends StatefulWidget {
  const TodoCreatePage({super.key});

  @override
  State<TodoCreatePage> createState() => _TodoCreatePageState();
}

class _TodoCreatePageState extends State<TodoCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Container(
          padding: EdgeInsets.all(8),
          child: SecondaryButton(
            child: SvgIcon(
              icon: 'chevron-left',
              color: primary.shade500,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Tạo công việc',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(),
    );
  }
}

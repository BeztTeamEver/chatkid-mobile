import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RolePage extends ConsumerStatefulWidget {
  const RolePage({super.key});

  @override
  ConsumerState<RolePage> createState() => _RolePageState();
}

class _RolePageState extends ConsumerState<RolePage> {
  String _role = "";

  setFormField(value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hãy chọn vai trò cho tài khoản",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 20,
              ),
        ),
        Text(
          "Phụ huynh có thể hỗ trợ bé tạo tài khoản",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
        ),
        const SizedBox(
          height: 40,
        ),
        SelectButton(
          label: "Phụ huynh",
          onPressed: () {
            setState(() {
              _role = "parent";
            });
          },
          isSelected: _role == "parent",
        ),
        const SizedBox(
          height: 10,
        ),
        SelectButton(
          label: "Trẻ em",
          isSelected: _role == "children",
          onPressed: () {
            setState(() {
              _role = "children";
            });
          },
        ),
      ],
    );
  }
}

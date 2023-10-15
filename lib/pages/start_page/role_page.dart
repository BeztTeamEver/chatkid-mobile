import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

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
          onPressed: () {},
          isSelected: true,
        ),
        const SizedBox(
          height: 10,
        ),
        SelectButton(label: "Trẻ em", onPressed: () {}),
      ],
    );
  }
}

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/add_mission_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CreateItemCard extends StatelessWidget {
  final Function() onAdd;
  const CreateItemCard({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        height: 82,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(4),
        child: DottedBorder(
          dashPattern: const [12, 12],
          radius: Radius.circular(10),
          strokeWidth: 2,
          borderType: BorderType.RRect,
          color: primary.shade500,
          child: Center(
            child: SvgIcon(
              icon: 'plus',
              size: 24,
              color: primary.shade500,
            ),
          ),
        ),
      ),
    );
  }
}

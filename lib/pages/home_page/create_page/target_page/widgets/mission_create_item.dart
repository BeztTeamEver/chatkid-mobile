import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/add_mission_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MissionsCreateItem extends StatefulWidget {
  const MissionsCreateItem({super.key});

  @override
  State<MissionsCreateItem> createState() => _MissionsCreateItemState();
}

class _MissionsCreateItemState extends State<MissionsCreateItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AddMissionCard extends StatelessWidget {
  const AddMissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => MissionCreatePage());
        Navigator.push(context, createRoute(() => AddMissionPage()));
      },
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

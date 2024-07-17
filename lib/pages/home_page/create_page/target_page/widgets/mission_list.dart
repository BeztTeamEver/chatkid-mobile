import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_create_item.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_item.dart';
import 'package:flutter/material.dart';

class MissionList extends StatefulWidget {
  const MissionList({super.key});

  @override
  State<MissionList> createState() => MissionListState();
}

class MissionListState extends State<MissionList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      AddMissionCard(),
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: children.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return children[index];
        },
      ),
    );
  }
}

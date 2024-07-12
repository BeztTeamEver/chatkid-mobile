import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/edit_modal.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/head_card.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/main_card.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TargetDetail extends StatefulWidget {
  const TargetDetail({super.key});

  @override
  State<TargetDetail> createState() => _TargetDetailState();
}

class _TargetDetailState extends State<TargetDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4 + 20,
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              "assets/todoPage/shining_background.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    child: HeadCard(),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  MainCard(
                    label: 'Học tiếng anh',
                    count: 4,
                    sticker: 'coin',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

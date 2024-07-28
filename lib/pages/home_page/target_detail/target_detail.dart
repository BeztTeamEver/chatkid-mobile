import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/head_card.dart';
import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/main_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TargetDetail extends StatefulWidget {
  final TargetModel target;
  const TargetDetail({super.key, required this.target});

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
          SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5 + 20,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        "assets/todoPage/shining_background.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      height: 200,
                      child: HeadCard(
                        target: widget.target,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Column(
                        children: [
                          ...widget.target.missions
                              .map((e) => MainCard(
                                  mission: e,
                                  label: e.name!,
                                  count: e.quantity!,
                                  sticker: 'coin',
                                  progress: e.progress ?? 0))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

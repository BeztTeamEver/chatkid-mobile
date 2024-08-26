import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/history/bot_card.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotHistoryDetail extends StatefulWidget {
  final HistoryBotChatModel history;
  const BotHistoryDetail({super.key, required this.history});

  @override
  State<BotHistoryDetail> createState() => _BotHitoryDetailState();
}

class _BotHitoryDetailState extends State<BotHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(primary.shade100),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primary.shade400,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Chi tiết hoạt động",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            // HistoryCard(
            //   history: widget.history,
            // ),
          ],
        ),
      ),
    );
  }
}

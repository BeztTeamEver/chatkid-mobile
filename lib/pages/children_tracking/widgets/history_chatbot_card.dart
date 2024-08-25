import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/history/history_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryChatbotCard extends StatelessWidget {
  final UserModel user;

  const HistoryChatbotCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
      onTap: () {
        Navigator.push(
          context,
          createRoute(
            () => HistoryPage(
              user: user,
            ),
          ),
        );
      },
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          child: Image.asset(
            "assets/activity/history-botchat-thumbnail.png",
            width: MediaQuery.of(context).size.width / 2 - 28,
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Lịch sử hỏi đáp chatbot",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

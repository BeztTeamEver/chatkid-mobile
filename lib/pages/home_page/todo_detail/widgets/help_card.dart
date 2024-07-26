import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/pages/chats/bot_chat_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCard extends StatefulWidget {
  const HelpCard({super.key});

  @override
  State<HelpCard> createState() => _HelpCardState();
}

class _HelpCardState extends State<HelpCard> {
  @override
  Widget build(BuildContext context) {
    final user = LocalStorage.instance.getUser();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: CustomCard(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.all(14),
        children: [
          Text(
            user.role == RoleConstant.Child
                ? "Gợi ý hỗ trợ từ botchat Bí Ngô"
                : "Gợi ý hỗ trợ dành cho trẻ ",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Option(content: "Làm sao để giữ trẻ hứng thú khi học tiếng Anh?"),
          // const SizedBox(height: 16),
          // Option(content: "Làm sao để giữ trẻ hứng thú khi học tiếng Anh?"),
          // const SizedBox(height: 16),
          // Option(content: "Làm sao để giữ trẻ hứng thú khi học tiếng Anh?"),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String content;
  const Option({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final user = LocalStorage.instance.getUser();

    return InkWell(
      radius: 26,
      onTap: user.role == RoleConstant.Child
          ? () => {
                Navigator.of(context).push(
                  createRoute(
                    () => BotChatPage(
                      botType: BotType.PUMKIN,
                      content: content,
                    ),
                  ),
                ),
              }
          : null,
      child: Row(
        children: [
          user.role == RoleConstant.Child
              ? SvgIcon(
                  icon: 'reply',
                  size: 24,
                )
              : Container(),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              content,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

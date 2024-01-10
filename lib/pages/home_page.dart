import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/pages/chat_page.dart';
import 'package:chatkid_mobile/pages/chats/bot_chat_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final currentUser = LocalStorage.instance.getUser();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xin Chào ${currentUser.name ?? ""} ^^",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: primary.shade500,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    createRoute(() => BotChatPage(botType: BotType.PUMKIN)),
                  );
                },
                children: [
                  SvgPicture.asset('assets/robot/pumkin.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Bí ngô",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    createRoute(() => BotChatPage(botType: BotType.STRAWBERRY)),
                  );
                },
                onTapColor: secondary.shade100,
                children: [
                  SvgPicture.asset('assets/robot/cherry.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Dâu tây",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

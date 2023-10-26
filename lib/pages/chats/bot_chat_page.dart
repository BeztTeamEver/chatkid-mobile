import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotChatPage extends StatefulWidget {
  final BotType botType;
  const BotChatPage({super.key, required this.botType});

  @override
  State<BotChatPage> createState() => _BotChatPageState();
}

class _BotChatPageState extends State<BotChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: primary.shade200,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: 40,
                    width: 144,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgIcon(
                          icon: 'bolt',
                          size: 24,
                        ),
                        Text(
                          "1000",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: SvgPicture.asset('assets/robot/full_pumkin.svg'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 80,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset('assets/botChatPage/heading.svg'),
            ),
          ],
        ),
      ),
    );
  }
}

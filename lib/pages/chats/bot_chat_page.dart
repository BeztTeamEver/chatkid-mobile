import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/speech_to_text.dart';
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
    final primaryColor = widget.botType == BotType.PUMKIN ? primary : secondary;
    final botName =
        widget.botType == BotType.PUMKIN ? 'full_pumkin' : 'full_cherry';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 20),
        height: 86,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgIcon(
                icon: "info",
                size: 43,
                color: primaryColor.shade500,
              ),
            ),
            SpeechToTextButton(
              color: primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgIcon(
                icon: "history",
                size: 43,
                color: primaryColor.shade500,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: primaryColor.shade200,
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
                          color: primaryColor.shade500,
                        ),
                        Text(
                          "1000",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 110),
                    child: SvgPicture.asset('assets/robot/${botName}.svg'),
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

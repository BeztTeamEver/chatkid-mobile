import 'package:chatkid_mobile/constants/gpt_voice.dart';
import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/providers/gpt_provider.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/speech_to_text.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

class BotChatPage extends ConsumerStatefulWidget {
  final BotType botType;
  const BotChatPage({super.key, required this.botType});

  @override
  ConsumerState<BotChatPage> createState() => _BotChatPageState();
}

class _BotChatPageState extends ConsumerState<BotChatPage> {
  TtsService ttsService = TtsService().instance;
  int _currentEnergy = 1000;
  //TODO: current energy
  Future<void> _onResult(String result) async {
    // _speechEnabled = await _speechToText.initialize();
    // setState(() {});
    try {
      Logger().d(result);
      final gptNotifier = ref.read(gptProvider.notifier);
      await gptNotifier.chat(result).then((value) async {
        await ttsService.speak(value);
        setState(() {
          _currentEnergy -= 1;
        });
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> _hello() async {
    await ttsService
        .speak("Xin chào, tôi là kidtalkie. Bạn có câu hỏi gì cho tôi không?");
  }

  void initTts() async {
    if (widget.botType == BotType.PUMKIN) {
      await ttsService.setVoice(GptVoice.PumkinVoice);
    } else {
      await ttsService.setVoice(GptVoice.CherryVoice);
    }
    await _hello();
  }

  @override
  void initState() {
    super.initState();
    ttsService.stop();
  }

  @override
  void dispose() {
    ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initTts();

    final primaryColor = widget.botType == BotType.PUMKIN ? primary : secondary;
    final botName =
        widget.botType == BotType.PUMKIN ? 'full_pumkin' : 'full_cherry';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 20),
        height: 96,
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
              onResult: _onResult,
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
                          _currentEnergy.toString(),
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

import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextButton extends StatefulWidget {
  final MaterialColor _color;
  final Function _onResult;
  final Function? _onSpeechResult;

  const SpeechToTextButton(
      {super.key,
      required MaterialColor color,
      required Function onResult,
      Function? onSpeechResult})
      : _color = color,
        _onSpeechResult = onSpeechResult,
        _onResult = onResult;

  @override
  State<SpeechToTextButton> createState() => _SpeechToTextButtonState();
}

class _SpeechToTextButtonState extends State<SpeechToTextButton> {
  final SpeechToText _speechToText = SpeechToText();
  final TtsService ttsService = TtsService().instance;
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    try {
      ttsService.stop();
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.confirmation,
        ),
      );
    } catch (e) {
      print('Error starting speech recognition');
      Logger().e(e.toString());
    }
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    try {
      final lastWords = _speechToText.lastRecognizedWords;
      if (lastWords.isNotEmpty) {
        await widget._onResult(lastWords);
      }
    } catch (e) {
      print('Error stopping speech recognition');
      Logger().e(e.toString());
    } finally {
      _speechToText.stop();
      setState(() {});
    }
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    widget._onSpeechResult?.call(result);
    setState(() {});
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _speechToText.isNotListening ? 152 : 168,
      height: _speechToText.isNotListening ? 70 : 96,
      padding: _speechToText.isNotListening
          ? const EdgeInsets.all(8)
          : const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: !_speechToText.isNotListening
            ? widget._color.shade100
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(64),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x144E2813),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x024E2914),
            blurRadius: 2,
            offset: Offset(0, -1),
            spreadRadius: 0,
          )
        ],
      ),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStatePropertyAll(
                widget._color.shade300,
              ),
            ),
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        child: SvgIcon(icon: 'voice_on', size: 24),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextButton extends StatefulWidget {
  final MaterialColor _color;

  const SpeechToTextButton({super.key, required MaterialColor color})
      : _color = color;

  @override
  State<SpeechToTextButton> createState() => _SpeechToTextButtonState();
}

class _SpeechToTextButtonState extends State<SpeechToTextButton> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _lastWords = '';

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
      await _speechToText.listen(
        onResult: _onSpeechResult,
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
    _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    Logger().d('onSpeechResult: $result');

    setState(() {
      _lastWords = result.recognizedWords;
    });
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
      height: _speechToText.isNotListening ? 60 : 86,
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
      child: Expanded(
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
      ),
    );
  }
}

import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceChat extends StatefulWidget {
  const VoiceChat(
      {super.key,
      required MaterialColor color,
      required Function onResult,
      Function? onSpeechResult})
      : _color = color,
        _onSpeechResult = onSpeechResult,
        _onResult = onResult;

  final MaterialColor _color;
  final Function _onResult;
  final Function? _onSpeechResult;

  @override
  State<VoiceChat> createState() => _VoiceChatState();
}

class _VoiceChatState extends State<VoiceChat> {
  final SpeechToText _speechToText = SpeechToText();
  final TtsService ttsService = TtsService().instance;
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    widget._onSpeechResult?.call(result.recognizedWords);
    setState(() {});
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    try {
      ttsService.stop();
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenMode: ListenMode.confirmation,
      );
    } catch (e) {
      print('Error starting speech recognition');
      Logger().e(e);
    }
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    try {
      final lastWords = _speechToText.lastRecognizedWords;
      if (lastWords.isNotEmpty) {
        await widget._onResult(lastWords);
      }
    } catch (e) {
      print('Error stopping speech recognition');
      Logger().e(e.toString());
    } finally {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 2,
          color: primary.shade400,
        ),
        boxShadow: List.generate(
          3,
          (index) => BoxShadow(
            color: primary.shade400.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        child: Icon(
          _speechToText.isListening ? Icons.mic_off : Icons.mic_rounded,
          size: 36,
          color: Colors.white,
        ),
      ),
    );
  }
}

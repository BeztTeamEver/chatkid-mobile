import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  final FlutterTts _flutterTts = FlutterTts();

  factory TtsService() => _instance;

  get instance => _instance;

  TtsService._internal();

  Future<void> initState() async {
    // TODO: get language device and check if language is supported
    await _instance.setLanguage("vi-VN");
    await _instance.setVolume(1.0);
    await _instance.setPitch(1.2);
    await _instance.setSpeechRate(0.6);
  }

  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  Future speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
  }

  Future setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  Future setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  Future setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  Future setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  Future stop() async {
    await _flutterTts.stop();
  }

  Future pause() async {
    await _flutterTts.pause();
  }
}

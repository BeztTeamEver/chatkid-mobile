import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart'
    hide RecognitionConfig;
import 'package:google_speech/google_speech.dart';
import 'package:logger/logger.dart';

class GoogleSpeech {
  static final instance = GoogleSpeech._internal();
  SpeechToText? _speechToText;
  late RecognitionConfig _config;

  GoogleSpeech._internal() {
    init();
    _config = RecognitionConfig(
        encoding: AudioEncoding.AMR_WB,
        recognitionMetadata: RecognitionMetadata(
            recordingDeviceType:
                RecognitionMetadata_RecordingDeviceType.SMARTPHONE,
            originalMediaType: RecognitionMetadata_OriginalMediaType.AUDIO),
        model: RecognitionModel.latest_long,
        enableAutomaticPunctuation: true,
        audioChannelCount: 1,
        useEnhanced: true,
        sampleRateHertz: 16000,
        languageCode: "vi-VN");
  }

  factory GoogleSpeech() => instance;

  void init() async {
    final String response = await rootBundle.loadString('service-account.json');
    final serviceAccount = ServiceAccount.fromString(response);
    _speechToText = SpeechToText.viaServiceAccount(serviceAccount);
  }

  List<int> getAudioContent(String path) {
    return File(path).readAsBytesSync().toList();
  }

  Future<RecognizeResponse> recognize(String path) async {
    final audioContent = getAudioContent(path);
    final response =
        await _speechToText!.recognize(_config, audioContent).then((value) {
      Logger().i(value.results);
      return value;
    }).catchError((error) {
      Logger().e(error);
    });
    return response;
  }
}

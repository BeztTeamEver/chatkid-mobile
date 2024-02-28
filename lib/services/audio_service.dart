import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer audioPlayer = AudioPlayer();
  static final AudioService _instance = AudioService._internal();

  factory AudioService() {
    return _instance;
  }

  AudioPlayer get player => audioPlayer;

  AudioService._internal() {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }
}

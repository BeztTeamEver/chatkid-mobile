import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class PlayerWave extends StatefulWidget {
  final String path;
  const PlayerWave({super.key, required this.path});

  @override
  State<PlayerWave> createState() => _PlayerWaveState();
}

class _PlayerWaveState extends State<PlayerWave> {
  PlayerController _controller = PlayerController(); // Initialise
  int _duration = 0;

  _play() async {
    await _controller.startPlayer(
        finishMode: FinishMode.stop); // Start audio player
    await _controller.stopPlayer(); // Stop audio player
    await _controller.getDuration(DurationType.max).then((value) {
      setState(() {
        _duration = value;
      });
    }); // Get duration of audio player
  }

  _pause() async {
    await _controller.pausePlayer(); // Pause audio player
  }

  _stop() async {
    await _controller.stopPlayer(); // Stop audio player
  }

  _init() async {
    await _controller.preparePlayer(
      path: widget.path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );

    _controller.updateFrequency =
        UpdateFrequency.low; // Update reporting rate of current duration.
    _controller.onPlayerStateChanged
        .listen((state) {}); // Listening to player state changes
    _controller.onCurrentDurationChanged
        .listen((duration) {}); // Listening to current duration changes
    _controller.onCurrentExtractedWaveformData
        .listen((data) {}); // Listening to latest extraction data
    _controller.onExtractionProgress
        .listen((progress) {}); // Listening to extraction progress
    _controller.onCompletion.listen((_) {}); // Listening to audio completion
    _controller.stopAllPlayers(); // Stop all registered audio players

    await _controller.getDuration(DurationType.max).then((value) {
      setState(() {
        _duration = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioFileWaveforms(
      size: Size(MediaQuery.of(context).size.width, 100.0),
      playerController: _controller,
      enableSeekGesture: true,
      waveformType: WaveformType.long,
      playerWaveStyle: const PlayerWaveStyle(
        fixedWaveColor: Colors.white54,
        liveWaveColor: Colors.blueAccent,
        spacing: 6,
      ),
    );
  }
}

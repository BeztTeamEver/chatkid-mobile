import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class RecordWave extends StatefulWidget {
  final String path;
  const RecordWave({super.key, required this.path});

  @override
  State<RecordWave> createState() => _WaveChatState();
}

class _WaveChatState extends State<RecordWave> {
  RecorderController _recordController = RecorderController(); // Initialise

  record() async {}

  _pause() async {
    await _recordController.pause(); // Pause recording
  }

  _stop() async {
    await _recordController.stop(); // Stop recording
    _recordController.refresh(); // Refresh waveform to original position
  }

  _start() async {
    await _recordController.record(
        path: widget.path); // Start recording (path is optional)
  }

  _init() async {
    // Record (path is optional)
    final hasPermission = await _recordController
        .checkPermission(); // Check mic permission (also called during record)
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _recordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioWaveforms(
      size: Size(MediaQuery.of(context).size.width, 200.0),
      recorderController: _recordController,
      enableGesture: true,
      waveStyle: WaveStyle(
        showDurationLabel: true,
        spacing: 8.0,
        showBottom: false,
        extendWaveform: true,
        showMiddleLine: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        waveColor: Colors.white,
      ),
    );
  }
}

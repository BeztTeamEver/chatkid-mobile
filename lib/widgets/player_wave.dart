import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class PlayerWave extends StatefulWidget {
  final String path;
  final Color? fixedWaveColor;
  final Color? liveWaveColor;
  final Color? color;
  const PlayerWave({
    super.key,
    required this.path,
    this.fixedWaveColor,
    this.liveWaveColor,
    this.color,
  });

  @override
  State<PlayerWave> createState() => _PlayerWaveState();
}

class _PlayerWaveState extends State<PlayerWave> {
  final PlayerController _controller = PlayerController();
  int _duration = 0;
  File? file;
  PlayerWaveStyle? playerWaveStyle;

  late final StreamSubscription<PlayerState> _playerStateSubscription;

  _play() async {
    await _controller.startPlayer(
      finishMode: FinishMode.loop,
    ); // Start audio player
    // await _controller.stopPlayer(); // Stop audio player
  }

  _pause() async {
    await _controller.pausePlayer(); // Pause audio player
  }

  _init() async {
    try {
      setState(() {
        playerWaveStyle = PlayerWaveStyle(
          fixedWaveColor: widget.fixedWaveColor ?? primary.shade200,
          liveWaveColor: widget.liveWaveColor ?? primary.shade500,
          seekLineColor: widget.fixedWaveColor ?? primary.shade600,
          spacing: 6,
        );
      });
      // read the file to the app
      final appDirectory = await getApplicationDocumentsDirectory();
      file = File("${appDirectory.path}/${widget.path}");
      if (file?.path == null) {
        return;
      }

      final data = await rootBundle.load('assets/audio/${widget.path}');
      final bytes = data.buffer.asUint8List();
      await file!.writeAsBytes(bytes);

      // prepare the player
      await _controller.preparePlayer(
        path: file!.path,
        shouldExtractWaveform: true,
        noOfSamples: playerWaveStyle!.getSamplesForWidth(200),
        volume: 1.0,
      );

      _controller.updateFrequency =
          UpdateFrequency.low; // Update reporting rate of current duration.

      // Set state for duration
      final duration = await _controller.getDuration(DurationType.max);

      _controller.onCurrentDurationChanged.listen((value) {
        setState(() {
          _duration = duration - value;
        });
      });
      // _controller.onCompletion.listen((_) {
      //   setState(() {
      //     _duration = duration;
      //   });
      // });
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
    _playerStateSubscription =
        _controller.onPlayerStateChanged.listen((event) async {
      switch (event) {
        case PlayerState.initialized:
          final duration = await _controller.getDuration(DurationType.max);
          setState(() {
            _duration = duration;
          });
          break;
        case PlayerState.paused:
          setState(() {});
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _controller.playerState.isPlaying ? _pause : _play,
            icon: Icon(
              _controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow,
              color: widget.color ?? primary.shade500,
            ),
          ),
          Expanded(
            child: AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width / 2, 60.0),
              playerController: _controller,
              enableSeekGesture: true,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: playerWaveStyle!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${_duration ~/ 1000}s",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: widget.color ?? primary.shade500,
                ),
          ),
        ],
      ),
    );
  }
}

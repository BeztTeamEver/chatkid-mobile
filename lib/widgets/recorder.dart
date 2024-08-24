import 'dart:io';

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/cache_manager.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceRecorder extends StatefulWidget {
  final Function(File? file) onRecorded;
  final Function? onSpeechResult;
  const VoiceRecorder(
      {super.key, required this.onRecorded, this.onSpeechResult});

  @override
  State<VoiceRecorder> createState() => VoiceRecorderState();
}

class VoiceRecorderState extends State<VoiceRecorder> {
  late final RecorderController controller;
  // late final AudioRecorder audioRecorder;
  final SpeechToText _speechToText = SpeechToText();
  bool isRecording = false;
  String? path = '';
  File? recordFile;

  init() async {
    // final hasPermission = await controller.checkPermission();
    // if (!hasPermission) {
    //   ErrorSnackbar.showError(
    //     context: context,
    //     err: new Exception('Please allow permission to record audio'),
    //     stack: StackTrace.current,
    //   );
    // }

    _speechToText.initialize(
      onError: (error) => Logger().e('Error: $error'),
      onStatus: (status) => Logger().i('Status: $status'),
    );
    // audioRecorder = AudioRecorder();
    controller = RecorderController()
      ..androidEncoder = AndroidEncoder.opus
      ..androidOutputFormat = AndroidOutputFormat.webm
      ..updateFrequency = const Duration(milliseconds: 50)
      ..iosEncoder = IosEncoder.kAudioFormatOpus
      ..sampleRate = 8000;
    await getApplicationDocumentsDirectory().then((value) {
      path = value.path;
      setState(() {});
      startOrStop(context);
    });
  }

  void startOrStop(BuildContext context) async {
    try {
      if (isRecording) {
        _stopListening();
        CustomCacheManager.instance.emptyCache();
        controller.reset();

        path = await controller.stop();
        if (path != null) {
          // isRecordingCompleted = true;
          final file = File(path!);
          // Logger().i(path);

          await CustomCacheManager.instance
              .putFile(
            file.path,
            file.readAsBytesSync(),
            key: "recorder",
            fileExtension: "m4a",
            eTag: "recorder",
            maxAge: const Duration(days: 1),
          )
              .then((value) {
            setState(() {
              recordFile = value;
            });

            widget.onRecorded(value);
            Logger().i('Recorded');
          });
          // setState(() {
          //   recordFile = file;
          // });

          // widget.onRecorded(file);
          // Logger().i('Recorded');
        }
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } else {
        await _startListening();
        await controller.record(); // Path is optional
        setState(() {
          recordFile = null;
        });
      }
    } catch (e, s) {
      Logger().i(e.toString(), stackTrace: s);
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  Future<void> _startListening() async {
    try {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.deviceDefault,
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
      Logger().i(lastWords);
      if (lastWords.isNotEmpty) {
        await widget.onSpeechResult?.call(lastWords);
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
    widget.onSpeechResult?.call(result);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  void dispose() {
    if (controller.isRecording) {
      controller.stop();
    }
    // audioRecorder.dispose();
    controller.dispose();
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                startOrStop(context);
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primary.shade500,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Hero(
                  tag: 'voiceChat/mic',
                  child: Icon(
                    isRecording ? Icons.mic : Icons.mic_none,
                    size: 48,
                    color: Colors.white,
                  ),
                ),

                //       child:  AnimatedContainer(
                //   duration: const Duration(milliseconds: 300),
                //   width: _speechToText.isNotListening ? 152 : 168,
                //   height: _speechToText.isNotListening ? 70 : 96,
                //   padding: _speechToText.isNotListening
                //       ? const EdgeInsets.all(8)
                //       : const EdgeInsets.all(8),
                //   decoration: ShapeDecoration(
                //     color: !_speechToText.isNotListening
                //         ? widget._color.shade100
                //         : Colors.transparent,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(64),
                //     ),
                //     shadows: const [
                //       BoxShadow(
                //         color: Color(0x144E2813),
                //         blurRadius: 8,
                //         offset: Offset(0, 4),
                //         spreadRadius: 0,
                //       ),
                //       BoxShadow(
                //         color: Color(0x024E2914),
                //         blurRadius: 2,
                //         offset: Offset(0, -1),
                //         spreadRadius: 0,
                //       )
                //     ],
                //   ),
                //   child: ElevatedButton(
                //     style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                //           backgroundColor: MaterialStatePropertyAll(
                //             widget._color.shade300,
                //           ),
                //         ),
                //     onPressed:
                //         // If not yet listening for speech start, otherwise stop
                //         _speechToText.isNotListening ? _startListening : _stopListening,
                //     child: SvgIcon(icon: 'voice_on', size: 24),
                //   ),
                // )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 100,
              child: AudioWaveforms(
                enableGesture: true,
                size: Size(MediaQuery.of(context).size.width / 2, 80),
                recorderController: controller,
                waveStyle: const WaveStyle(
                  waveColor: Colors.white,
                  extendWaveform: true,
                  durationLinesHeight: 80,
                  durationStyle: TextStyle(color: Colors.white, fontSize: 12),
                  showMiddleLine: false,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.only(left: 18),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
            // recordFile != null
            //     ? PlayerWave(
            //         path: recordFile!.path,
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({required this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => 'voiceChat/mic';
}

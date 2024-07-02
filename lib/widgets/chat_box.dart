import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/player_wave.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:logger/logger.dart';

class ChatTextBox extends StatefulWidget {
  final String? message;
  final String? icon;
  final bool? isSender;
  final String? voiceUrl;
  final UserModel? user;
  final bool useVoice;
  final bool useTextfullWidth;
  const ChatTextBox(
      {super.key,
      this.message,
      this.icon,
      this.useTextfullWidth = false,
      this.isSender,
      this.user,
      this.useVoice = true,
      this.voiceUrl});

  @override
  State<ChatTextBox> createState() => ChatTextBoxState();
}

class ChatTextBoxState extends State<ChatTextBox> {
  TtsService _ttsService = TtsService().instance;

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isSender == true ? neutral.shade100 : primary.shade600;

    final contentWidgets = [
      widget.isSender == false
          ? Container(
              width: 40,
              height: 40,
              child: AvatarPng(
                imageUrl: widget.user?.avatarUrl,
                borderColor: widget.isSender == true
                    ? primary.shade500
                    : primary.shade100,
              ),
            )
          : Container(),
      const SizedBox(
        width: 10,
      ),
      Container(
        width: MediaQuery.of(context).size.width *
            (widget.useTextfullWidth ? 0.65 : 0.5),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isSender == true ? primary.shade500 : primary.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: widget.voiceUrl != null && widget.voiceUrl != ""
            ? PlayerWave(
                path: widget.voiceUrl ?? "",
                color: color,
                fixedWaveColor: widget.isSender == true
                    ? primary.shade300
                    : primary.shade200,
                liveWaveColor: color,
              )
            : TextBox(widget: widget),
        // child: PlayerWave(
        //   path: widget.message ?? "",
        //   color: color,
        //   fixedWaveColor:
        //       widget.isSender == true ? primary.shade300 : primary.shade200,
        //   liveWaveColor: color,
        // ),
      ),
      const SizedBox(
        width: 10,
      ),
      widget.voiceUrl == null || widget.voiceUrl == ""
          ? IconButton(
              onPressed: () {
                _speak(widget.message ?? "");
              },
              icon: SvgIcon(
                icon: "volumn",
                size: 36,
                color: primary.shade500,
              ),
            )
          : Container(),
    ];

    return Row(
      mainAxisAlignment: widget.isSender == true
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: widget.isSender == true
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: widget.isSender == true
                  ? contentWidgets.reversed.toList()
                  : contentWidgets,
            ),
          ),
        ),
      ],
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.widget,
  });

  final ChatTextBox widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.message ?? "",
        textAlign: widget.isSender == true ? TextAlign.end : TextAlign.start,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color:
                  widget.isSender == true ? neutral.shade100 : primary.shade600,
            ),
      ),
    );
  }
}

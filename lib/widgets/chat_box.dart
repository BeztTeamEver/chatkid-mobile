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

class ChatTextBox extends StatefulWidget {
  final String? message;
  final String? icon;
  final bool? isSender;
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
      this.useVoice = true});

  @override
  State<ChatTextBox> createState() => ChatTextBoxState();
}

class ChatTextBoxState extends State<ChatTextBox> {
  TtsService _ttsService = TtsService().instance;
  PlayerController _playerController = PlayerController();

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
    final contentWidgets = [
      Container(
        width: 40,
        height: 40,
        child: AvatarPng(
          imageUrl: widget.user?.avatarUrl,
          borderColor:
              widget.isSender == true ? primary.shade500 : primary.shade100,
        ),
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.message ?? "",
            textAlign:
                widget.isSender == true ? TextAlign.end : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.isSender == true
                      ? neutral.shade100
                      : primary.shade600,
                ),
          ),
        ),
        // child: const PlayerWave(path: 'giun.mp3'),
      ),
      SizedBox(
        width: 10,
      ),
      widget.useVoice
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

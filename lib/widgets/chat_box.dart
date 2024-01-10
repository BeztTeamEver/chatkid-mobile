import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ChatTextBox extends StatefulWidget {
  final String? message;
  final String? icon;
  final bool? isSender;
  const ChatTextBox({super.key, this.message, this.icon, this.isSender});

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
    final contentWidgets = [
      Avatar(
        icon: widget.icon,
        size: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isSender == true ? primary.shade500 : primary.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.message ?? "",
          textAlign: widget.isSender == true ? TextAlign.end : TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: widget.isSender == true
                    ? neutral.shade100
                    : primary.shade600,
              ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      IconButton(
        onPressed: () {
          _speak(widget.message ?? "");
        },
        icon: SvgIcon(
          icon: "volumn",
          size: 36,
          color: primary.shade500,
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: widget.isSender == true
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
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
      ],
    );
  }
}

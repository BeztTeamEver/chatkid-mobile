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
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class ChatTextBox extends StatefulWidget {
  final String? message;
  final String? icon;
  final bool? isSender;
  final String? voiceUrl;
  final String? imageUrl;
  final UserModel? user;
  final bool useVoice;
  final bool useTextfullWidth;
  final double? width;
  final bool isThumbnail;
  final Function? onOpenPreview;
  final bool useSenderAvatar;
  final Color? backgroundColor;
  final bool? isUseSenderAvatar;

  const ChatTextBox(
      {super.key,
      this.message,
      this.icon,
      this.useSenderAvatar = true,
      this.backgroundColor,
      this.useTextfullWidth = false,
      this.isSender,
      this.onOpenPreview,
      this.width,
      this.user,
      this.isUseSenderAvatar = false,
      this.useVoice = true,
      this.imageUrl,
      this.isThumbnail = false,
      this.voiceUrl});

  @override
  State<ChatTextBox> createState() => ChatTextBoxState();
}

class ChatTextBoxState extends State<ChatTextBox> {
  TtsService _ttsService = TtsService().instance;
  final PlayerController _playerController = PlayerController();

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _playerController.dispose();
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isSender == true ? neutral.shade100 : primary.shade600;

    final contentWidgets = [
      widget.isSender == false || widget.isUseSenderAvatar == true
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
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        // width: widget.message == null || widget.message?.isEmpty == true
        //     ? null
        //     : MediaQuery.of(context).size.width *
        //         (widget.useTextfullWidth ? 0.65 : 0.5),
        width: widget.width,
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isSender == true ? primary.shade500 : primary.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.voiceUrl != null && widget.voiceUrl != ""
            ? PlayerWave(
                path: widget.voiceUrl ?? "",
                color: color,
                fixedWaveColor: widget.isSender == true
                    ? primary.shade300
                    : primary.shade200,
                liveWaveColor: color,
              )
            : widget.imageUrl != null && widget.imageUrl != ""
                ? GestureDetector(
                    onTap: () {
                      if (widget.onOpenPreview != null) {
                        widget.onOpenPreview!();
                        return;
                      }
                      Navigator.of(context).push(HeroDialogRoute(
                        builder: (context) =>
                            PreviewImageDialog(imageUrl: widget.imageUrl!),
                      ));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Hero(
                              tag: widget.imageUrl ?? "",
                              child: Image.network(
                                widget.imageUrl ?? "",
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : Container(
                                            width: 36,
                                            height: 36,
                                            padding: EdgeInsets.all(4),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: widget.isSender == true
                                                    ? primary.shade100
                                                    : primary.shade500,
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ),
                        widget.isThumbnail == true
                            ? Positioned(
                                child: Container(
                                  height: 36,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  padding: EdgeInsets.all(4),
                                  // color: Colors.black.withOpacity(0.5),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: primary.shade100,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : TextBox(
                    widget: widget,
                  ),
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
      widget.voiceUrl == null &&
              widget.message != null &&
              widget.message!.isNotEmpty &&
              widget.useVoice
          ? IconButton(
              onPressed: () {
                _speak(widget.message ?? "");
              },
              icon: SvgIcon(
                icon: "volumn",
                size: 28,
                color: primary.shade500,
              ),
            )
          : Container(),
    ];

    return Column(
      crossAxisAlignment: widget.isSender == true
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                (widget.useTextfullWidth ? 1 : 0.85),
          ),
          width: MediaQuery.of(context).size.width *
              (widget.useTextfullWidth ? 1 : 0.85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: widget.isSender == true
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: widget.isSender == true
                ? contentWidgets.reversed.toList()
                : contentWidgets,
          ),
        ),
        if (widget.message != null && widget.voiceUrl != null)
          const SizedBox(
            height: 10,
          ),
        if (widget.message != null && widget.voiceUrl != null)
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      content: Container(
                        width: 400,
                        color: Colors.transparent,
                        child: Text(
                          widget.message?.replaceAll(RegExp(r"[\(\)]+"), "") ??
                              "",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primary.shade500,
                                  ),
                        ),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Hiển thị văn bản",
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: primary.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
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

class PreviewImageDialog extends StatelessWidget {
  final String imageUrl;
  const PreviewImageDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.transparent,
        child: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : Container(
                        width: 36,
                        height: 36,
                        padding: EdgeInsets.all(4),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primary.shade500,
                          ),
                        ),
                      ),
          ),
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
  String? get barrierLabel {
    return "HeroDialogRoute";
  }
}

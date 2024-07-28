import 'dart:io';

import 'package:chatkid_mobile/pages/chats/widget/action_button.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/widgets/custom_bottom_sheet.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/recorder.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ParentBottomBar extends StatefulWidget {
  final bool isExpanded;
  final void Function(bool) onChangeBottomSheet;
  final void Function(File?) onRecorded;
  final TextEditingController messageController;
  final void Function(String?) onSendMessage;
  final void Function(String?) onSendImage;
  final void Function() onOpenSticker;

  const ParentBottomBar({
    super.key,
    required this.isExpanded,
    required this.onChangeBottomSheet,
    required this.onSendImage,
    required this.onRecorded,
    required this.messageController,
    required this.onSendMessage,
    required this.onOpenSticker,
  });

  @override
  State<ParentBottomBar> createState() => _ParentBottomBarState();
}

class _ParentBottomBarState extends State<ParentBottomBar> {
  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    return CustomBottomSheet(
      maxHeight: 280,
      builder: (context) => AnimatedContainer(
        height: widget.isExpanded == true ? 280 : 60,
        duration: duration,
        padding: EdgeInsets.all(10),
        curve: Curves.easeInOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: widget.isExpanded
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            ActionButton(
              icon: const SvgIcon(icon: 'photo'),
              onPressed: () async {
                final file = await FileService().pickAndUploadFile();
                if (file != null) {
                  widget.onSendImage(
                    file.url,
                  );
                }
              },
            ),
            // ActionButton(
            //   icon: SvgIcon(
            //     icon: 'sticker',
            //     color: widget.isExpanded == true ? primary.shade500 : null,
            //   ),
            //   onPressed: widget.onOpenSticker,
            // ),
            Hero(
              tag: 'voiceChat/mic',
              child: ActionButton(
                icon: const SvgIcon(icon: 'microphone_on'),
                onPressed: () {
                  Navigator.push(
                    context,
                    HeroDialogRoute(
                        builder: (context) => VoiceRecorder(
                              onRecorded: widget.onRecorded,
                            )),
                  );
                },
              ),
              placeholderBuilder: (context, heroSize, child) {
                return Container(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 34,
                child: InputField(
                  name: 'message',
                  controller: widget.messageController,
                  autoFocus: false,
                  height: 32,
                  fontSize: 12,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  onTap: () => widget.onChangeBottomSheet(false),
                  onSubmit: (value) => widget.onSendMessage(value),
                  hint: "Aa",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

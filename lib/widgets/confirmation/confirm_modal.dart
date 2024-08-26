import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class ConfirmModal extends StatefulWidget {
  final String title;
  final String content;
  final String? imageUrl;
  final Function? onCancel;
  final Function? onConfirm;
  final String confirmText;
  final String cancelText;
  final Widget? contentWidget;
  final Color? backgroundColor;
  final bool? isLoading;
  const ConfirmModal(
      {super.key,
      this.backgroundColor,
      required this.title,
      required this.content,
      this.imageUrl,
      this.contentWidget,
      this.onCancel,
      this.onConfirm,
      this.confirmText = "Xác nhận",
      this.isLoading,
      this.cancelText = "Quay lại"});

  @override
  State<ConfirmModal> createState() => _ConfirmModalState();
}

class _ConfirmModalState extends State<ConfirmModal> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor ?? Colors.white,
      surfaceTintColor: widget.backgroundColor ?? Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.4,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  color: neutral.shade800,
                ),
          ),
          if (widget.imageUrl != null)
            Image.network(
              widget.imageUrl!,
              width: 200,
              height: 200,
            ),
          if (widget.contentWidget != null) widget.contentWidget!,
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final buttonWidth = constraints.maxWidth / 2 - 5;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLoading) {
                          return;
                        }
                        if (widget.onCancel != null) {
                          widget.onCancel!();
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButtonTheme.of(context).style!.copyWith(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: isLoading
                                      ? neutral.shade500
                                      : primary.shade500,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            shadowColor: MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                          ),
                      child: Text(
                        widget.cancelText,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: isLoading
                                      ? neutral.shade500
                                      : primary.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                      ),
                    ),
                  ), // Ca
                  Container(
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isLoading) {
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          if (widget.onConfirm != null) {
                            await widget.onConfirm!();
                          }
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          Logger().e(e);
                          setState(() {
                            isLoading = false;
                          });
                        } finally {}
                      },
                      style: ElevatedButtonTheme.of(context).style!.copyWith(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 4,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              isLoading ? neutral.shade500 : primary.shade500,
                            ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading != true
                              ? Container()
                              : Container(
                                  width: 32,
                                  height: 32,
                                  child: CustomCircleProgressIndicator()),
                          Text(
                            widget.confirmText,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ), //
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

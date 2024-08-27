import 'dart:io';

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final GestureTapCallback? onTap;
  final Color? onTapColor;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final String? backgroundImage;
  final Color? backgroundColor;
  final Function? onLongPressed;
  final String? heroTag;
  final BoxConstraints? constraints;
  final Widget? actionButton;

  const CustomCard({
    super.key,
    this.onTap,
    this.onTapColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.backgroundImage,
    this.backgroundColor = Colors.white,
    required this.children,
    this.width,
    this.padding,
    this.height,
    this.constraints,
    this.onLongPressed,
    this.actionButton,
    this.heroTag,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final isFile = File(widget.backgroundImage ?? "").existsSync();

    return Card(
      color: widget.backgroundColor,
      child: InkWell(
        onLongPress: widget.onLongPressed as void Function()?,
        splashColor: widget.onTapColor ?? primary.shade100,
        overlayColor:
            MaterialStateProperty.all(widget.onTapColor ?? primary.shade100),
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              width: 140,
              child: widget.backgroundImage != null
                  ? Hero(
                      tag: widget.heroTag ?? "",
                      child: widget.backgroundImage!.contains("http")
                          ? Image.network(
                              widget.backgroundImage!,
                              fit: BoxFit.fill,
                            )
                          : isFile
                              ? Image.file(
                                  File(widget.backgroundImage!),
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  widget.backgroundImage!,
                                  fit: BoxFit.fill,
                                ),
                    )
                  : Container(),
            ),
            Container(
              padding: widget.padding ?? const EdgeInsets.all(10),
              height: widget.height,
              width: widget.width,
              constraints: widget.constraints,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.mainAxisAlignment,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: widget.children,
              ),
            ),
            widget.actionButton != null
                ? Positioned(
                    top: 2,
                    right: 10,
                    child: widget.actionButton!,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

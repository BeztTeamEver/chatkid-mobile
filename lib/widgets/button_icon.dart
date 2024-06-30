import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class ButtonIcon extends StatefulWidget {
  final Function onPressed;
  final String icon;
  final double? iconSize;
  final double? padding;
  final Color? color;
  final Color? backgroundColor;
  final OutlinedBorder? shape;

  const ButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.padding,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.shape,
  });

  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(
        widget.padding ?? 0.0,
      ),
      iconSize: widget.iconSize ?? 20,
      onPressed: () {
        widget.onPressed();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          widget.backgroundColor ?? Colors.transparent,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          widget.shape ?? const CircleBorder(),
        ),
      ),
      icon: SvgIcon(
        icon: widget.icon,
        size: widget.iconSize ?? 20,
        color: widget.color,
      ),
    );
  }
}

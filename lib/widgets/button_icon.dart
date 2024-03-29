import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonIcon extends StatefulWidget {
  final Function onPressed;
  final String icon;
  final double? iconSize;
  final double? padding;

  const ButtonIcon(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.padding,
      this.iconSize});

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
      iconSize: 16,
      onPressed: () {
        widget.onPressed();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
      ),
      icon: SvgIcon(
        icon: widget.icon,
        size: widget.iconSize ?? 20,
      ),
    );
  }
}

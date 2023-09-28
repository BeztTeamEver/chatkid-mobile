import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatefulWidget {
  final String icon;
  final double size;
  final Color? color;

  const SvgIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  State<SvgIcon> createState() => _SvgIconState();
}

class _SvgIconState extends State<SvgIcon> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${widget.icon}.svg',
      colorFilter: widget.color != null
          ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
          : null,
      height: widget.size,
    );
  }
}

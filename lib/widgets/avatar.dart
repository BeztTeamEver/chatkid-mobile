import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String? _icon;
  final double _size;
  const Avatar({super.key, String? icon, double? size})
      : _icon = icon,
        _size = size ?? 64;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._size,
      height: widget._size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: primary.shade400,
              width: 2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: SvgIcon(
            icon: widget._icon ?? 'animal/bear',
            size: 18,
          ),
        ),
      ),
    );
  }
}

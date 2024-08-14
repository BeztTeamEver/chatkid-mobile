import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class LabelColor {
  static final Color PRIMARY = primary.shade100;
  static final Color POSITIVE = green.shade100;
  static final Color NEGATIVE = red.shade100;
  static final Color WARNING = yellow.shade100;
  static final Color NEUTRAL = neutral.shade100;
  static final Color INFO = blue.shade100;
}

class LabelTextColor {
  static final Color PRIMARY = primary.shade900;
  static final Color POSITIVE = green.shade900;
  static final Color NEGATIVE = red.shade900;
  static final Color WARNING = yellow.shade900;
  static final Color NEUTRAL = neutral.shade900;
  static final Color INFO = blue.shade900;
}

class ColorMap {
  Color labelColor;
  Color labelTextColor;

  ColorMap({required this.labelColor, required this.labelTextColor});
}

enum LabelType { PRIMARY, POSITIVE, NEGATIVE, WARNING, NEUTRAL, INFO }

class Label extends StatefulWidget {
  final LabelType type;
  final double? width;
  final String label;
  const Label({super.key, required this.type, required this.label, this.width});

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorMap colorMap;
    switch (widget.type) {
      case LabelType.PRIMARY:
        colorMap = ColorMap(
            labelColor: LabelColor.PRIMARY,
            labelTextColor: LabelTextColor.PRIMARY);
        break;
      case LabelType.POSITIVE:
        colorMap = ColorMap(
            labelColor: LabelColor.POSITIVE,
            labelTextColor: LabelTextColor.POSITIVE);
        break;
      case LabelType.NEGATIVE:
        colorMap = ColorMap(
            labelColor: LabelColor.NEGATIVE,
            labelTextColor: LabelTextColor.NEGATIVE);
        break;
      case LabelType.WARNING:
        colorMap = ColorMap(
            labelColor: LabelColor.WARNING,
            labelTextColor: LabelTextColor.WARNING);
        break;
      case LabelType.NEUTRAL:
        colorMap = ColorMap(
            labelColor: LabelColor.NEUTRAL,
            labelTextColor: LabelTextColor.NEUTRAL);
        break;
      case LabelType.INFO:
        colorMap = ColorMap(
            labelColor: LabelColor.INFO, labelTextColor: LabelTextColor.INFO);
        break;
    }
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: colorMap.labelColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorMap.labelTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final int index;
  final double height;
  final double dotSize;
  final int lenght;
  final Color? selectedColor;
  final Color? unselectedColor;
  const Indicator(
      {super.key,
      required this.index,
      this.lenght = 3,
      this.selectedColor,
      this.unselectedColor,
      this.height = 8,
      this.dotSize = 8});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.lenght,
        (index) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            width: widget.index == index ? 16 + widget.dotSize : widget.dotSize,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.index == index
                  ? widget.selectedColor ?? Theme.of(context).primaryColor
                  : widget.unselectedColor ?? neutral.shade200,
              borderRadius: BorderRadius.circular(widget.height),
            ),
          ),
        ),
      ),
    );
  }
}

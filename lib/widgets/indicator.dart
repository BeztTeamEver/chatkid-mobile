import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final int index;
  final int lenght;
  const Indicator({super.key, required this.index, this.lenght = 3});

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
            width: widget.index == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: widget.index == index
                  ? Theme.of(context).primaryColor
                  : neutral.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

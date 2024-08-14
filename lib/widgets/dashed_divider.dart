import 'package:flutter/material.dart';

class DashedDirection {
  static const horizontal = Axis.horizontal;
  static const vertical = Axis.vertical;
}

class DashedDivider extends StatefulWidget {
  final double dashWidth;
  final double dashHeight;
  final Color color;
  final Axis direction;
  const DashedDivider(
      {super.key,
      this.direction = DashedDirection.horizontal,
      this.dashWidth = 5.0,
      this.dashHeight = 1.0,
      this.color = Colors.black});

  @override
  State<DashedDivider> createState() => _DashedDividerState();
}

class _DashedDividerState extends State<DashedDivider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final boxHeight = constraints.constrainHeight();

        int dashCount = (boxWidth / (2 * widget.dashWidth)).floor();
        if (widget.direction == DashedDirection.vertical) {
          dashCount = (boxHeight / (2 * widget.dashHeight)).floor();
        }
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: widget.direction,
          verticalDirection: VerticalDirection.down,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: widget.dashWidth,
              height: widget.dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: widget.color),
              ),
            );
          }),
        );
      },
    );
  }
}

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final GestureTapCallback? onTap;
  final Color? onTapColor;
  const CustomCard({
    super.key,
    this.onTap,
    this.onTapColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          splashColor: widget.onTapColor ?? primary.shade100,
          overlayColor:
              MaterialStateProperty.all(widget.onTapColor ?? primary.shade100),
          onTap: widget.onTap,
          child: SizedBox(
            height: 159,
            child: Column(
              mainAxisAlignment: widget.mainAxisAlignment,
              crossAxisAlignment: widget.crossAxisAlignment,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}

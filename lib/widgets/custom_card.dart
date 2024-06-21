import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatefulWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final GestureTapCallback? onTap;
  final Color? onTapColor;
  final double? height;
  final EdgeInsets? padding;
  final String? backgroundImage;
  final Function? onLongPressed;
  const CustomCard({
    super.key,
    this.onTap,
    this.onTapColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.backgroundImage,
    required this.children,
    this.padding,
    this.height,
    this.onLongPressed,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: widget.backgroundImage != null
                  ? Image.network(
                      widget.backgroundImage!,
                      fit: BoxFit.contain,
                    )
                  : Container(),
              width: 200,
            ),
            Container(
              padding: widget.padding ?? const EdgeInsets.all(10),
              height: widget.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.mainAxisAlignment,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

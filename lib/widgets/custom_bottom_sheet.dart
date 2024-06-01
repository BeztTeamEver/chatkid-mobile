import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final double? height;
  final double maxHeight;

  const CustomBottomSheet({
    super.key,
    required this.builder,
    this.height,
    this.maxHeight = 200,
  });

  @override
  State<CustomBottomSheet> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<CustomBottomSheet>
    with TickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 300);

  static AnimationController createAnimationController(TickerProvider vsync,
      {AnimationStyle? sheetAnimationStyle}) {
    return AnimationController(
      duration:
          sheetAnimationStyle?.duration ?? const Duration(milliseconds: 300),
      reverseDuration: sheetAnimationStyle?.reverseDuration ??
          const Duration(milliseconds: 300),
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () => {},
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
      ),
      shadowColor: primary.shade500,
      elevation: 0,
      // shape: ShapeBorder.lerp(
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     ),
      //   ),
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     ),
      //   ),
      //   1,
      // ),
      // animationController: createAnimationController(this,
      //     sheetAnimationStyle: AnimationStyle(
      //       duration: _duration,
      //       reverseDuration: _duration,
      //       curve: Curves.easeInOut,
      //       reverseCurve: Curves.easeInOut,
      //     )),
      // enableDrag: false,
      builder: widget.builder,
    );
  }
}

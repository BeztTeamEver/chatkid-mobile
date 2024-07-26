import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class ProgressBar extends StatefulWidget {
  final double value;
  const ProgressBar({super.key, this.value = 0});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      upperBound: widget.value,
      vsync: this,
      value: 0,
    );
    _controller.animateTo(
      widget.value,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
    );
    _colorAnimation = ColorTween(
      begin: primary.shade500,
      end: primary.shade500,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            child: LinearProgressIndicator(
              minHeight: 20,
              valueColor: _colorAnimation,
              value: _controller.value,
              borderRadius: BorderRadius.circular(18),
              backgroundColor: neutral.shade200,
            ),
          ),
        ),
        Positioned(
          child: Text(
            "${(_controller.value.toDouble() * 100).toInt()}%",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 16,
              color: primary.shade900,
              shadows: [
                const Shadow(
                  blurRadius: 2.4,
                  color: Colors.white,
                  offset: Offset(-0.1, -0.2),
                ),
                const Shadow(
                  blurRadius: 2.4,
                  color: Colors.white,
                  offset: Offset(0.1, 0.2),
                ),
                const Shadow(
                  blurRadius: 2.4,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

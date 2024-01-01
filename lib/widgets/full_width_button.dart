import 'package:animated_svg/animated_svg.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullWidthButton extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final int? duration;

  final Function onPressed;

  const FullWidthButton({
    super.key,
    this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.duration,
  });

  @override
  State<FullWidthButton> createState() => _FullWidthButtonState();
}

class _FullWidthButtonState extends State<FullWidthButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final SvgController _svgController;
  int _opacity = 255;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration ?? 200),
      vsync: this,
    );
    _svgController = AnimatedSvgController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _svgController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
    _svgController.forward();
    setState(() {
      _opacity = 100;
      _isPressed = true;
    });
  }

  void _endAnimation() {
    _controller.reverse();
    _svgController.reverse();
    setState(() {
      _opacity = 255;
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double shadowHeight = widget.height != null ? widget.height! - 4 : 42;
    final double containerHeight = widget.height != null ? widget.height! : 46;
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: GestureDetector(
        onTap: () => widget.onPressed(),
        onTapDown: (details) {
          _startAnimation();
        },
        onTapCancel: () {
          _endAnimation();
        },
        onTapUp: (details) {
          _endAnimation();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.duration ?? 200),
          width: widget.width ?? 350,
          height: widget.height ?? 46,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: widget.duration ?? 200),
                  width: widget.width ?? 350,
                  height: containerHeight,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 3,
                        child: AnimatedContainer(
                          duration:
                              Duration(milliseconds: widget.duration ?? 200),
                          width: widget.width ?? 350,
                          height: shadowHeight,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 2.40,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            shadows: [
                              BoxShadow(
                                color: neutral.shade300,
                                blurRadius: _isPressed ? 0 : 2,
                                offset: const Offset(0, 5),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration:
                            Duration(milliseconds: widget.duration ?? 200),
                        left: 0,
                        top: _isPressed ? 6 : 0,
                        child: AnimatedContainer(
                          duration:
                              Duration(milliseconds: widget.duration ?? 200),
                          width: widget.width ?? 350,
                          height: _isPressed ? shadowHeight - 4 : shadowHeight,
                          decoration: ShapeDecoration(
                            color: primary.shade400,
                            shape: RoundedRectangleBorder(
                              // side: BorderSide(
                              //   width: 2.40,
                              //   strokeAlign: BorderSide.strokeAlignOutside,
                              //   color: Colors.white,
                              // ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration:
                            Duration(milliseconds: widget.duration ?? 200),
                        top: _isPressed ? 2 : 0,
                        left: 0,
                        child: AnimatedContainer(
                          duration:
                              Duration(milliseconds: widget.duration ?? 200),
                          width: widget.width ?? 350,
                          height: shadowHeight,
                          decoration: BoxDecoration(
                            color: _isPressed
                                ? primary.shade600
                                : primary.shade400,
                            borderRadius: BorderRadius.circular(22),
                            border: !_isPressed
                                ? Border(
                                    left: BorderSide(color: primary.shade600),
                                    top: BorderSide(color: primary.shade600),
                                    right: BorderSide(color: primary.shade600),
                                    bottom: BorderSide(
                                        width: 4, color: primary.shade600),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                          duration:
                              Duration(milliseconds: widget.duration ?? 200),
                          left: 0,
                          top: _isPressed ? 2 : 0,
                          child: SizedBox(
                            width: widget.width ?? 350,
                            height: shadowHeight,
                            child: Center(
                              child: widget.child,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 3,
                top: 30,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(2.16),
                  child: Container(
                    width: 4.54,
                    height: 5.28,
                    decoration: ShapeDecoration(
                      color: _isPressed ? primary.shade400 : primary.shade600,
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

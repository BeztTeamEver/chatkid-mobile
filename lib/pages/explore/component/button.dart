import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ButtonBlogAnimated extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Function onPressed;
  final String text;
  final String icon;

  const ButtonBlogAnimated({
    super.key,
    this.primaryColor = const Color(0xFF06E1FF),
    this.secondaryColor = const Color(0xFF02A3E7),
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  State<ButtonBlogAnimated> createState() => _ButtonBlogAnimatedState();
}

class _ButtonBlogAnimatedState extends State<ButtonBlogAnimated> {
  bool _isPressed = false;
  final _duration = 100;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: _duration),
      child: GestureDetector(
        onTap: () => {widget.onPressed()},
        onTapDown: (details) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapCancel: () {
          Future.delayed(Duration(milliseconds: _duration), () {
            setState(() {
              _isPressed = false;
            });
          });
        },
        onTapUp: (details) {
          Future.delayed(Duration(milliseconds: _duration), () {
            setState(() {
              _isPressed = false;
            });
          });
        },
        child: AnimatedPadding(
          duration: Duration(milliseconds: _duration),
          padding: _isPressed
              ? const EdgeInsets.only(top: 3)
              : const EdgeInsets.only(top: 0),
          child: Container(
            decoration: ShapeDecoration(
              color: widget.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: const Color.fromRGBO(117, 43, 1, 0.16),
                  // blurRadius: 0,
                  offset: _isPressed ? const Offset(0, 2) : const Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: AnimatedPadding(
              duration: Duration(milliseconds: _duration),
              padding: _isPressed
                  ? const EdgeInsets.only(bottom: 1)
                  : const EdgeInsets.only(bottom: 4),
              child: Container(
                width: 96,
                padding:
                    const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.primaryColor,
                ),
                child: Column(children: [
                  SvgIcon(
                      icon: widget.icon, size: 32, color: Colors.white),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

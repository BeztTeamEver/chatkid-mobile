import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final Function onTap;
  final Widget child;
  const SecondaryButton({super.key, required this.onTap, required this.child});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onTap(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
        backgroundColor: MaterialStateProperty.all(
          primary.shade100,
        ),
      ),
      child: widget.child,
    );
  }
}

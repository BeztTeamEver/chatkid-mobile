import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabButton extends StatefulWidget {
  final bool isSelected;
  final String label;
  final Function onTap;

  const TabButton(
      {super.key,
      this.isSelected = false,
      this.label = '',
      required this.onTap});

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: ElevatedButton(
          onPressed: () => widget.onTap(),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
            backgroundColor: MaterialStateProperty.all(
              widget.isSelected ? primary.shade500 : primary.shade200,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color: widget.isSelected ? primary.shade900 : primary.shade700,
            ),
          ),
        ),
      ),
    );
  }
}

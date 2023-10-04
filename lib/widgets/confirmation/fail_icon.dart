import 'dart:ffi';

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FailIcon extends StatefulWidget {
  const FailIcon({super.key});

  @override
  State<FailIcon> createState() => _FailIconState();
}

class _FailIconState extends State<FailIcon> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // duration: const Duration(milliseconds: 400),
      width: 120,
      height: 120,
      child: SizedBox(
        // duration: const Duration(milliseconds: 400),
        width: 120,
        height: 120,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // duration: Duration(milliseconds: 300),
                width: 120,
                height: 120,
                decoration: ShapeDecoration(
                  color: red.shade500,
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 9.32,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: red.shade100,
                    ),
                  ),
                ),
                child: const Center(
                  child: SvgIcon(
                    icon: "fail",
                    color: Colors.white,
                    size: 94,
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

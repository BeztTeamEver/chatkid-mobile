import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class SuccessfullIcon extends StatefulWidget {
  const SuccessfullIcon({super.key});

  @override
  State<SuccessfullIcon> createState() => _SuccessfullIconState();
}

class _SuccessfullIconState extends State<SuccessfullIcon>
    with TickerProviderStateMixin {
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 120,
      height: 120,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 120,
        height: 120,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 120,
                height: 120,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEF3B3B),
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 9.32,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFFFD9D9),
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

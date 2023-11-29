import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  color: Theme.of(context).primaryColor,
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 9.32,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: primary.shade200,
                    ),
                  ),
                ),
                child: const Center(
                  child: SvgIcon(
                    icon: "success",
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

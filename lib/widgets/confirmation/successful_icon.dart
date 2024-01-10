import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfulIcon extends StatefulWidget {
  const SuccessfulIcon({super.key});

  @override
  State<SuccessfulIcon> createState() => _SuccessfulIconState();
}

class _SuccessfulIconState extends State<SuccessfulIcon>
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
      width: 100,
      height: 100,
      child: SizedBox(
        // duration: const Duration(milliseconds: 400),
        width: 100,
        height: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // duration: Duration(milliseconds: 300),
                width: 100,
                height: 100,
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

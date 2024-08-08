import 'package:flutter/material.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomCircleProgressIndicator({
    super.key,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}

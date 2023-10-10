import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        children: [
          Text("Bạn là ai?"),
        ],
      )),
    ));
  }
}

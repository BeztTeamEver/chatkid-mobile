import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivationPage extends ConsumerWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return CupertinoPageScaffold(
      child: Container(
        child: Text('Activation Page'),
      ),
    );
  }
}

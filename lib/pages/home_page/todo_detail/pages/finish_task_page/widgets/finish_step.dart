import 'package:flutter/material.dart';

class FinishStep extends StatefulWidget {
  const FinishStep({super.key});

  @override
  State<FinishStep> createState() => _FinishStepState();
}

class _FinishStepState extends State<FinishStep> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Finish'),
    );
  }
}

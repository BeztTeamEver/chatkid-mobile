import 'package:flutter/material.dart';

class FeedbackVoice extends StatefulWidget {
  const FeedbackVoice({super.key});

  @override
  State<FeedbackVoice> createState() => _FeedbackVoiceState();
}

class _FeedbackVoiceState extends State<FeedbackVoice> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Feedback voice'),
    );
  }
}

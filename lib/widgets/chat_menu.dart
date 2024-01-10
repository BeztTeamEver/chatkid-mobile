import 'package:flutter/material.dart';

class ChatMenu extends StatefulWidget {
  const ChatMenu({super.key});

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Chat Menu"),
    );
  }
}

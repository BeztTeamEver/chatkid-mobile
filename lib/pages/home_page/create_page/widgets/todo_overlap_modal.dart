import 'package:flutter/widgets.dart';

class TodoOverlapModal extends StatefulWidget {
  final List<String> users;
  const TodoOverlapModal({super.key, required this.users});

  @override
  State<TodoOverlapModal> createState() => _TodoOverlapModalState();
}

class _TodoOverlapModalState extends State<TodoOverlapModal> {
  fetchTask() async {
    widget.users.map((element) {
      // return
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

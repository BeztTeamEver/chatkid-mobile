import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorSnackbar {
  static void showError(
      {required err, StackTrace? stack, required BuildContext context}) {
    Logger().e(err.toString(), stackTrace: stack);
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            err.toString(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(stack.toString()),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

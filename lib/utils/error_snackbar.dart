import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorSnackbar {
  static void showError(
      {required err, StackTrace? stack, required BuildContext context}) {
    Logger().e(err.toString(), stackTrace: stack);
    SnackBar snackBar = SnackBar(
      content: Text(
        err.toString().split(":")[1].trim(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

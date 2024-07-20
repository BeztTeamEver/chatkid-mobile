import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorSnackbar {
  static void showError(
      {required err, StackTrace? stack, required BuildContext context}) {
    Logger().e(err.toString(), stackTrace: stack);
    final errorMessage =
        err.toString().split(":")[err.toString().split(":").length - 1].trim();
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        errorMessage,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

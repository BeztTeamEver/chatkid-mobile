import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  final Exception err;
  final StackTrace? stack;
  const ErrorHandler({super.key, required this.err, this.stack});

  @override
  Widget build(BuildContext context) {
    if (err is Error) {
      ErrorSnackbar.showError(context: context, err: err);
    }
    return Container();
  }
}

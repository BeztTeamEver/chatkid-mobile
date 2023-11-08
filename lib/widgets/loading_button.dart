import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';

class LoadingButton extends StatefulWidget {
  final Function(Function stopLoading) handleOnTap;
  final String label;
  const LoadingButton(
      {super.key, required this.handleOnTap, required this.label});

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return LoadingBtn(
      height: 60,
      borderRadius: 40,
      width: double.infinity,
      loader: Container(
        padding: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.idle) {
          startLoading();
          widget.handleOnTap(() {
            stopLoading();
          });
        }
      },
      child: Text(
        widget.label,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

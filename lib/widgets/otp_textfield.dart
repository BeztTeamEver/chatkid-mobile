import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatefulWidget {
  final int length;
  final Function? onCompleted;
  final bool autoComplete;
  final bool isObscured;
  final double width;
  final double fontSize;
  final double height;
  final Function? validation;
  final bool isFocus;
  const OtpTextField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.width = 70,
    this.fontSize = 70,
    this.height = 70,
    this.isObscured = false,
    this.isFocus = true,
    this.autoComplete = false,
    this.validation,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isFocus) _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    // theme for the pin
    PinTheme defaultPinTheme = PinTheme(
      width: widget.width,
      height: widget.height,
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: widget.fontSize,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: neutral.shade500,
          ),
        ),
      ),
    );

    PinTheme selectedPinTheme = defaultPinTheme.copyWith(
      textStyle: defaultPinTheme.textStyle!.copyWith(
        color: Theme.of(context).primaryColor,
      ),
      decoration: defaultPinTheme.decoration!.copyWith(
        border: const Border(),
      ),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 2,
          color: Theme.of(context).primaryColor,
          width: double.infinity,
        )
      ],
    );

    //Focus

    return Pinput(
      focusNode: _focusNode,
      animationDuration: const Duration(milliseconds: 100),
      pinAnimationType: PinAnimationType.scale,
      cursor: cursor,
      onChanged: (value) {
        if (!widget.autoComplete) {
          return;
        }
        if (value.length == widget.length) {
          _focusNode.unfocus();
          widget.onCompleted!(value);
        }
      },
      errorTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: red.shade500,
          ),
      obscureText: widget.isObscured,
      defaultPinTheme: defaultPinTheme,
      animationCurve: Curves.easeIn,
      focusedPinTheme: selectedPinTheme,
      length: widget.length,
      onCompleted: (value) {
        _focusNode.unfocus();
        widget.onCompleted!(value);
      },
      validator: widget.validation != null
          ? (value) {
              return widget.validation!(value);
            }
          : null,
    );
  }
}

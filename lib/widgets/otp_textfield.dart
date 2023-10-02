import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatefulWidget {
  final int length;
  final Function? onCompleted;
  final Function? validation;
  const OtpTextField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.validation,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose

    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // theme for the pin
    PinTheme defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 70,
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

    _focusNode.requestFocus();

    return Pinput(
      focusNode: _focusNode,
      animationDuration: const Duration(milliseconds: 100),
      pinAnimationType: PinAnimationType.scale,
      cursor: cursor,
      defaultPinTheme: defaultPinTheme,
      animationCurve: Curves.easeIn,
      focusedPinTheme: selectedPinTheme,
      length: widget.length,
      onCompleted: (value) => widget.onCompleted!(value),
      validator: (value) => widget.validation!(value),
    );
  }
}

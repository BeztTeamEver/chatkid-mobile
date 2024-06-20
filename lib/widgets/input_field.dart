import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType type;
  final String? Function(String?)? validator;
  final controller;
  final String? errorText;
  final String name;
  final Widget? suffixIcon;
  final bool autoFocus;
  final bool? isObscure;

  const InputField({
    super.key,
    this.label = "",
    this.autoFocus = false,
    this.type = TextInputType.text,
    this.hint = "",
    required this.name,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.isObscure = false,
    required this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty
            ? Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            : Container(),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: widget.name,
          // controller: widget.controller,
          keyboardType: widget.type,
          key: widget.key,
          autofocus: widget.autoFocus,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText:
              widget.type == TextInputType.visiblePassword && widget.isObscure!
                  ? true
                  : false,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: neutral.shade500,
              ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            errorMaxLines: 2,
            errorText: widget.errorText,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}

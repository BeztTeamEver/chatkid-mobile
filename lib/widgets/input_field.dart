import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType type;
  final String? Function(String?)? validator;
  final controller;
  final String name;
  final bool autoFocus;

  const InputField({
    super.key,
    this.label = "",
    this.autoFocus = false,
    this.type = TextInputType.text,
    this.hint = "",
    required this.name,
    this.validator,
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
          controller: widget.controller,
          keyboardType: widget.type,
          autofocus: widget.autoFocus,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.type == TextInputType.visiblePassword,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: neutral.shade500,
              ),
          decoration: InputDecoration(
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}

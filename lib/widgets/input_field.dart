import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType type;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorText;
  final String name;
  final Widget? suffixIcon;
  final bool autoFocus;
  final bool? isObscure;
  final double? height;
  final GlobalKey<FormBuilderState>? formKey;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onChanged;
  final Function()? onTap;
  final Function(String?)? onChange;
  final Function(String?)? onSubmit;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    super.key,
    this.label = "",
    this.autoFocus = false,
    this.type = TextInputType.text,
    this.onChanged,
    this.hint = "",
    this.formKey,
    required this.name,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.isObscure = false,
    this.controller,
    this.height,
    this.fontSize,
    this.contentPadding,
    this.onSubmit,
    this.onTap,
    this.inputFormatters,
    this.onChange,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  _resetValidate() {
    if (widget.formKey != null &&
        widget.formKey!.currentState?.fields[widget.name] != null) {
      widget.formKey!.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.label.isNotEmpty
            ? Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            : Container(),
        widget.label.isNotEmpty ? const SizedBox(height: 10) : Container(),
        SizedBox(
          height: widget.height,
          child: FormBuilderField(
              name: widget.name,
              validator: widget.validator,
              onSaved: widget.onSubmit,
              builder: (field) {
                return TextFormField(
                  // name: widget.name,
                  controller: widget.controller,
                  keyboardType: widget.type,
                  key: widget.key,
                  autofocus: widget.autoFocus,
                  onChanged: (value) {
                    if (widget.formKey != null) {
                      _resetValidate();
                    }
                    field.didChange(value);
                    widget.onChange?.call(value);
                  },
                  validator: widget.validator,
                  inputFormatters: widget.inputFormatters,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: widget.type == TextInputType.visiblePassword &&
                          widget.isObscure!
                      ? true
                      : false,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: neutral.shade500,
                        fontSize: widget.fontSize,
                      ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onTap: widget.onTap,
                  // onEditingComplete: () {
                  //   Logger().i("Editing complete");
                  //   if (widget.onSubmit != null) {
                  //     widget.onSubmit!();
                  //   }
                  // },
                  onFieldSubmitted: (value) {
                    if (widget.onSubmit != null) {
                      widget.onSubmit!(value);
                      widget.controller?.clear();
                    }
                  },
                  initialValue: widget.controller != null
                      ? (null as String?)
                      : (field.value as String?),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    errorMaxLines: 2,
                    errorText: widget.errorText,
                    suffixIcon: widget.suffixIcon,
                    contentPadding: widget.contentPadding,
                  ),
                  // onSubmitted: (value) {
                  //   if (widget.onSubmit != null) {
                  //     widget.onSubmit!(value);
                  //     widget.controller?.clear();
                  //   }
                  // },
                );
              }),
        ),
      ],
    );
  }
}

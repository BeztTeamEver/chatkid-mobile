import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

class TextAreaInput extends StatefulWidget {
  final String? hint;
  final String name;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? fontSize;
  final FocusNode? focusNode;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextInputType type;
  final bool? isNextWhenComplete;
  final Color? borderColor;
  final String? defaultValue;
  final Color? focusBorderColor;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsets? contentPadding;
  final void Function(String name, String? value)? onChanged;
  final TextInputAction? textInputAction;
  final bool? disableErrorText;
  final String? Function(String?)? validation;

  const TextAreaInput({
    super.key,
    this.hint,
    required this.name,
    this.validation,
    this.label,
    this.maxLines = 8,
    this.minLines = 1,
    this.maxLength,
    this.textAlign,
    this.fontWeight,
    this.focusNode,
    this.onChanged,
    this.defaultValue,
    this.isNextWhenComplete = false,
    this.textInputAction = TextInputAction.next,
    this.borderColor,
    this.focusBorderColor,
    this.backgroundColor,
    this.contentPadding,
    this.disableErrorText,
    this.height,
    this.type = TextInputType.text,
    this.fontSize = 16,
  });

  @override
  State<TextAreaInput> createState() => _TextAreaInputState();
}

class _TextAreaInputState extends State<TextAreaInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: neutral.shade800,
                      fontWeight: FontWeight.bold,
                    ),
              )
            : Container(),
        widget.label != null ? const SizedBox(height: 8) : Container(),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FormBuilderTextField(
            validator: widget.validation,
            name: widget.name,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            keyboardType: widget.type,
            valueTransformer: (value) => widget.type == TextInputType.number
                ? int.tryParse(value ?? "") ?? 0
                : value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (e) {
              FocusScope.of(context).unfocus();
            },
            onTap: () {
              FocusScope.of(context).requestFocus();
            },
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade800,
                  fontWeight: widget.fontWeight ?? FontWeight.w600,
                  fontSize: widget.fontSize!.toDouble(),
                ),
            // onEditingComplete: () {
            //   if (widget.isNextWhenComplete == true) {
            //     FocusScope.of(context).nextFocus();
            //   }
            // },
            // onSaved: (newValue) {
            //   field.didChange(newValue);
            // },
            onChanged: (value) {
              // field.didChange(value);
              widget.onChanged?.call(widget.name, value);

              //TODO: fix the focus
              if (widget.isNextWhenComplete == true) {
                if (value?.length == widget.maxLength) {
                  FocusScope.of(context).nextFocus();
                }
                // if (value?.isEmpty == true) {
                //   FocusScope.of(context).previousFocus();
                // }1
              }
            },
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? neutral.shade400,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? neutral.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.focusBorderColor ?? primary.shade400,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: red.shade500,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: red.shade500,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: widget.fontSize!.toDouble(),
                color: Colors.grey,
              ),
              fillColor: widget.backgroundColor ?? Colors.white,
              hintText: widget.hint,
              counterText: "",
              // errorText: widget.disableErrorText == true ? "" : null,
              errorStyle: widget.disableErrorText == true
                  ? TextStyle(height: 0, fontSize: 0, color: Colors.transparent)
                  : TextStyle(
                      fontSize: 14,
                      color: red.shade500,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

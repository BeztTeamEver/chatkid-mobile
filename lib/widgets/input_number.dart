import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/widgets/textarea_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logger/logger.dart';

class InputNumber extends StatefulWidget {
  final String name;
  final double? height;
  final double? width;
  final double? buttonWidth;
  final String? errorText;
  final String? label;
  final String? rightLableIcon;
  final int? initValue;
  final GlobalKey<FormBuilderState> formKey;
  const InputNumber({
    super.key,
    required this.name,
    required this.formKey,
    this.height = 34,
    this.width,
    this.initValue = 1,
    this.errorText,
    this.buttonWidth = 34,
    this.label,
    this.rightLableIcon,
  });

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  increase() {
    final form = widget.formKey.currentState as FormBuilderState;
    final field = form.fields[widget.name];
    Logger().i(field?.value);
    field!.didChange(
      (int.parse(field.value ?? "0") + 1).toString(),
    );
  }

  decrease() {
    final form = widget.formKey.currentState as FormBuilderState;
    final field = form.fields[widget.name];

    if (field?.value == "0") return;
    field!.didChange(
      (int.parse(field.value ?? "0") - 1).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.label != null
            ? Row(
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    widget.label!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(width: 8),
                  widget.rightLableIcon != null
                      ? SvgIcon(
                          icon: widget.rightLableIcon!,
                          size: 24,
                        )
                      : Container(),
                ],
              )
            : Container(),
        SizedBox(height: 8),
        Container(
          height: widget.height,
          width: widget.width,
          child: Row(
            children: [
              Container(
                width: widget.buttonWidth,
                child: ButtonIcon(
                  onPressed: () {
                    decrease();
                  },
                  icon: "minus",
                  padding: 4,
                  iconSize: 18,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: primary.shade500,
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 64,
                height: widget.height,
                color: Colors.transparent,
                child: TextAreaInput(
                  name: widget.name,
                  textAlign: TextAlign.center,
                  type: TextInputType.number,
                  maxLines: 1,
                  hint: "0",
                  // focusBorderColor: Colors.transparent,
                  // onChanged: (name, value) {
                  //   final form =
                  //       widget.formKey.currentState as FormBuilderState;
                  //   final field = form.fields[widget.name];
                  //   field!.didChange(value);
                  // },
                  borderColor: Colors.transparent,
                  height: widget.height,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  backgroundColor: Colors.transparent,
                  defaultValue: widget.initValue?.toString(),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: widget.buttonWidth,
                child: ButtonIcon(
                  onPressed: () {
                    increase();
                  },
                  icon: "plus",
                  padding: 4,
                  iconSize: 18,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: primary.shade500,
                ),
              ),
            ],
          ),
        ),
        widget.errorText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.errorText!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: red.shade100,
                        fontSize: 12,
                      ),
                ),
              )
            : Container(),
      ],
    );
  }
}

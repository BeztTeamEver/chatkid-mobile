import 'package:chatkid_mobile/constants/info_form.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:pinput/pinput.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class WheelInput extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? defaultValue;
  final int? defaultSelectionIndex;
  final String? description;
  final SvgIcon? suffixIcon;
  final SvgIcon? prefixIcon;

  final Function(String?)? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSave;

  final double? optionHeight;
  final double? listHeight;

  final List<Options> options;

  const WheelInput({
    super.key,
    required this.controller,
    this.label,
    this.defaultSelectionIndex,
    this.description,
    required this.options,
    this.validator,
    this.listHeight = 300,
    this.optionHeight,
    this.prefixIcon,
    this.suffixIcon,
    this.defaultValue,
    this.hintText,
    this.onChange,
    this.onSave,
  });

  @override
  State<WheelInput> createState() => _WheelInputState();
}

class _WheelInputState extends State<WheelInput> {
  int _selectedValueIndex = 0;
  String _selectedValue = "";

  @override
  void initState() {
    super.initState();
    final defaultIndex = widget.options
        .indexWhere((element) => widget.defaultValue == element.value);
    setState(() {
      _selectedValueIndex = widget.defaultSelectionIndex ?? defaultIndex;
      _selectedValue = widget.defaultValue ?? widget.options[0].value;
    });
    if (widget.controller.text.isEmpty) {
      widget.controller.setText(widget.defaultValue ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final innerController = TextEditingController(
        text: _selectedValueIndex > -1
            ? widget.options[_selectedValueIndex].label
            : null);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {
            showMenu(widget.options, () {
              widget.controller.setText(_selectedValue ?? "");
            });
          },
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: neutral.shade500,
                fontWeight: FontWeight.bold,
              ),
          controller: innerController,
          decoration: InputDecoration(
            hintText: widget.hintText ?? "Chọn",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade400,
                ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: widget.suffixIcon ??
                  SvgIcon(
                    icon: "chevron_updown",
                    size: 24,
                    color: neutral.shade400,
                  ),
            ),
            prefixIcon: widget.prefixIcon,
          ),
          readOnly: true,
        ),
      ],
    );
  }

  showMenu(List<Options> options, Function onSelect) {
    double defaultItemSize = 64;
    String innerValue = "";
    int innerIndex = 0;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: widget.listHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.description != null
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        widget.description!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : Container(),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: widget.optionHeight ?? defaultItemSize,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 2,
                              color: primary.shade500,
                            ),
                          ),
                          color: primary.shade100,
                        ),
                      ),
                    ),
                    Center(
                      child: WheelChooser.choices(
                        unSelectTextStyle:
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: neutral.shade400,
                                ),
                        selectTextStyle: Theme.of(context).textTheme.labelLarge,
                        choices: options
                            .map(
                              (e) => WheelChoice(
                                value: e.value,
                                title: e.label,
                              ),
                            )
                            .toList(),
                        listHeight: widget.optionHeight,
                        onChoiceChanged: (value) {
                          if (widget.onChange != null) {
                            widget.onChange!(value);
                          }
                          innerValue = value;
                          innerIndex = options
                              .indexWhere((element) => element.value == value);
                        },
                        startPosition: _selectedValueIndex,
                        itemSize: widget.optionHeight ?? defaultItemSize,
                        perspective: 0.0015,
                        squeeze: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FullWidthButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedValue = innerValue;
                      _selectedValueIndex = innerIndex;
                    });
                    onSelect();
                  },
                  child: Text(
                    "Chọn",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

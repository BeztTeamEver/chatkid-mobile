import 'package:chatkid_mobile/models/option.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SelectButtonList<T> extends StatefulWidget {
  final String name;
  final String? label;
  final List<OptionModel<T>> options;
  final List<T>? selectedOption;
  final bool? isMultiple;
  final void Function(List<T>?) onSelected;

  const SelectButtonList({
    super.key,
    required this.name,
    this.label,
    required this.options,
    this.selectedOption,
    this.isMultiple = false,
    required this.onSelected,
  });

  @override
  State<SelectButtonList<T>> createState() => _SelectButtonListState<T>();
}

class _SelectButtonListState<T> extends State<SelectButtonList<T>> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<T>?>(
        name: widget.name,
        builder: (FormFieldState<List<T>?> field) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 8,
              ),
              SizedBox(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.options
                      .map(
                        (option) => OptionButton<T>(
                          option: option,
                          isSelected: field.value?.contains(option.value),
                          onTap: () {
                            if (widget.isMultiple!) {
                              final list = field.value;
                              final element = list?.firstWhereOrNull(
                                  (element) => element == option.value);
                              if (element != null) {
                                list?.remove(element);
                              } else {
                                list?.add(option.value);
                              }
                              widget.onSelected(list);
                              field.didChange(list);
                              return;
                            }
                            widget.onSelected([option.value]);
                            field.didChange([option.value]);
                          },
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          );
        });
  }
}

class OptionButton<T> extends StatefulWidget {
  final OptionModel<T> option;
  final bool? isSelected;
  final Function onTap;
  const OptionButton(
      {super.key, required this.option, this.isSelected, required this.onTap});

  @override
  State<OptionButton<T>> createState() => _OptionButtonState<T>();
}

class _OptionButtonState<T> extends State<OptionButton<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isSelected! ? primary.shade500 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: primary.shade500,
          ),
        ),
        child: Text(
          widget.option.label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: widget.isSelected! ? neutral.shade100 : neutral.shade600,
              ),
        ),
      ),
    );
  }
}

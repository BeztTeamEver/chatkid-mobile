import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final String? _icon;
  const SelectButton({super.key, String? icon}) : _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {},
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.surface,
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon != null ? SvgIcon(icon: _icon!) : Container(),
              Text(
                "Bo",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

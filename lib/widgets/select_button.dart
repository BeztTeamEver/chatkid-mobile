import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectButton extends StatelessWidget {
  final String? _icon;
  final String _label;
  final VoidCallback? _onPressed;
  final bool _hasBackground;
  final Color? _borderColor;
  const SelectButton(
      {super.key,
      String? icon,
      Color? borderColor,
      required String label,
      VoidCallback? onPressed,
      bool hasBackground = false})
      : _icon = icon,
        _label = label,
        _onPressed = onPressed,
        _hasBackground = hasBackground,
        _borderColor = borderColor;

  @override
  Widget build(BuildContext context) {
    final alignContent =
        _icon != null ? MainAxisAlignment.start : MainAxisAlignment.center;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: _borderColor ?? neutral.shade100,
          width: 2,
        ),
        color: Theme.of(context).colorScheme.surface,
        image: _hasBackground
            ? const DecorationImage(
                image: AssetImage('assets/selectButton/background.png'),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(40),
      ),
      child: ElevatedButton(
        onPressed: _onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            shadowColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            )),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: alignContent,
            children: [
              _icon != null
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _borderColor ?? neutral.shade400,
                            width: 2,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: SvgIcon(
                          icon: _icon!,
                          size: 18,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                width: 12,
              ),
              Text(
                _label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

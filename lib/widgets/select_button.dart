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
  final bool _isSelected;
  final String? _subLabel;

  const SelectButton(
      {super.key,
      String? icon,
      Color? borderColor,
      required String label,
      String subLabel = "",
      VoidCallback? onPressed,
      bool isSelected = false,
      bool hasBackground = false})
      : _icon = icon,
        _isSelected = isSelected,
        _label = label,
        _subLabel = subLabel,
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
        color: Colors.white,
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
                _isSelected ? primary.shade400 : Colors.transparent,
              ),
              shadowColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: alignContent,
            children: [
              _icon != null
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _borderColor ?? neutral.shade400,
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            _icon ?? "",
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              "assets/profile/default-avatar.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ))
                  : Container(),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_subLabel?.isNotEmpty == true)
                    Text(
                      _subLabel ?? "",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: neutral.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                    ),
                  Text(
                    _label,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: _isSelected ? Colors.white : neutral.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

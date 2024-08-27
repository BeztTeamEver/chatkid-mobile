import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SecondarySelectButton extends StatelessWidget {
  final String? _icon;
  final String? _label;
  final VoidCallback? _onPressed;
  final bool _hasBackground;
  final Color? _borderColor;
  final bool _isSelected;
  final String? _backgroundImage;
  final String? _subLabel;
  final double? _height;

  const SecondarySelectButton(
      {super.key,
      String? icon,
      Color? borderColor,
      String? label,
      String? backgroundImage,
      double height = 150,
      String subLabel = "",
      VoidCallback? onPressed,
      bool isSelected = false,
      bool hasBackground = false})
      : _icon = icon,
        _backgroundImage = backgroundImage,
        _isSelected = isSelected,
        _label = label,
        _subLabel = subLabel,
        _onPressed = onPressed,
        _height = height,
        _hasBackground = hasBackground,
        _borderColor = borderColor;

  @override
  Widget build(BuildContext context) {
    final alignContent =
        _icon != null ? MainAxisAlignment.start : MainAxisAlignment.center;
    return Column(
      children: [
        Container(
          height: _height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: _borderColor ?? neutral.shade100,
              width: 2,
            ),
            color: Colors.white,
            image: _hasBackground
                ? DecorationImage(
                    image: AssetImage(_backgroundImage ??
                        'assets/selectButton/background.png'),
                    fit: BoxFit.cover,
                  )
                : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton(
            onPressed: _onPressed,
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color:
                            _isSelected ? primary.shade200 : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_backgroundImage != null)
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      child: SvgPicture.asset(
                        _backgroundImage!,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _label != null
            ? Text(
                _label!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: neutral.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
              )
            : Container(),
      ],
    );
  }
}

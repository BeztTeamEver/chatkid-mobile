import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final bool isShowText;
  const LogoWidget({
    super.key,
    this.isShowText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgIcon(icon: 'logo', color: Theme.of(context).primaryColor, size: 64),
        isShowText ? const SizedBox(height: 20) : Container(),
        isShowText
            ? Text(
                'KidTalkie',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              )
            : Container(),
      ],
    );
  }
}

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectButton extends StatelessWidget {
  final String? _icon;
  const SelectButton({super.key, String? icon}) : _icon = icon;

  @override
  Widget build(BuildContext context) {
    final alignContent =
        _icon != null ? MainAxisAlignment.start : MainAxisAlignment.center;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: primary.shade100,
            width: 2,
          ),
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/selectButton/background.svg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            ElevatedButton(
              onPressed: () {},
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
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: _icon != null
                            ? SvgIcon(
                                icon: _icon!,
                                size: 18,
                              )
                            : Container(),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Bo",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

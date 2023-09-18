import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

final _primaryColorValue = HexColor('FF9B06').value;
final _neutralColorValue = HexColor('F8D92AA').value;

final MaterialColor primary = MaterialColor(
  _primaryColorValue,
  <int, Color>{
    50: HexColor('FFFBF5'),
    100: HexColor('FFEDD1'),
    200: HexColor('FFD38F'),
    300: HexColor('FFBE5C'),
    400: HexColor('FFAE33'),
    500: HexColor('FF9B06'),
    600: HexColor('FB8F04'),
    700: HexColor('E87903'),
    800: HexColor('031677'),
    900: HexColor('020E4B'),
  },
);

final MaterialColor neutral = MaterialColor(_neutralColorValue, <int, Color>{
  50: HexColor('FAFAFA'),
  100: HexColor('F5F5F5'),
  200: HexColor('EEEEEE'),
  300: HexColor('E0E0E0'),
  400: HexColor('BDBDBD'),
  500: HexColor('9E9E9E'),
  600: HexColor('757575'),
  700: HexColor('616161'),
  800: HexColor('424242'),
  900: HexColor('212121'),
});

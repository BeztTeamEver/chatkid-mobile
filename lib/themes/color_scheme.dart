import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _primaryColorValue = HexColor('FF9B06').value;
final _secondaryColorValue = HexColor('FF0634').value;
final _neutralColorValue = HexColor('F8D92AA').value;
final _redColorValue = HexColor('0B2FE5').value;
final _textDefaultColorValue = HexColor('303030').value;
final _greenColorValue = HexColor('0B2FE5').value;

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
    800: HexColor('C55C02'),
    900: HexColor('752B01'),
  },
);

final MaterialColor secondary =
    MaterialColor(_secondaryColorValue, <int, Color>{
  50: HexColor('FFF5F7'),
  100: HexColor('FFD1DA'),
  200: HexColor('FF8FA3'),
  300: HexColor('FF5C7A'),
  400: HexColor('FF3358'),
  500: HexColor('FF0634'),
  600: HexColor('DD042B'),
  700: HexColor('C20024'),
  800: HexColor('9D011E'),
  900: HexColor('6B0014')
});

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

final MaterialColor red = MaterialColor(_redColorValue, <int, Color>{
  50: HexColor('FEF6F6'),
  100: HexColor('FFDADA'),
  500: HexColor('F03C3C'),
  800: HexColor('B30000'),
  900: HexColor('6A0101'),
});

final MaterialColor green = MaterialColor(_greenColorValue, <int, Color>{
  50: HexColor('E3F6FF'),
  100: HexColor('CCEAFF'),
  500: HexColor('0B2FE5'),
  800: HexColor('031677'),
  900: HexColor('020E4B'),
});

final Color textDefault = Color(_textDefaultColorValue);

final TextTheme textTheme = GoogleFonts.nunitoTextTheme(
  TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textDefault,
      height: 1.5,
      letterSpacing: 0.14,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textDefault,
      height: 1.5,
      letterSpacing: 0.08,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: textDefault,
      height: 1,
      letterSpacing: 0.04,
    ),
    titleLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w900,
      color: textDefault,
      height: 1,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textDefault,
      height: 1.02,
    ),
    titleSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textDefault,
      height: 1.01,
    ),
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      color: textDefault,
      height: 1.02,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: textDefault,
      height: 1.01,
      letterSpacing: -0.28,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textDefault,
      height: 1,
      letterSpacing: 1.1,
    ),
    labelLarge: TextStyle(
      color: textDefault,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
);

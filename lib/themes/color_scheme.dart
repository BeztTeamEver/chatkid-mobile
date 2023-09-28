import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _primaryColorValue = HexColor('FF9B06').value;
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

final MaterialColor red = MaterialColor(_redColorValue, <int, Color>{
  50: HexColor('E3F6FF'),
  100: HexColor('CCEAFF'),
  500: HexColor('0B2FE5'),
  800: HexColor('031677'),
  900: HexColor('020E4B'),
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
      letterSpacing: 1.55,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textDefault, 
      height: 1.5,
      letterSpacing: 1.45,  
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: textDefault,
      height: 1,
      letterSpacing: 1.45,
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
      height: 1,
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
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textDefault,
      height: 1,
    ),
  ),
);

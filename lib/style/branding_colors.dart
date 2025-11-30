import 'package:flutter/material.dart';

class BrandingColors {
  static const Color primaryColor = Color(0xFF7678ED);
  static const Color secondaryColor = Color(0xa87678ed);
  static const Color backgroundColorLighter = Color(0xE6ECECEC);
  static const Color successColor = Color(0xff50c878);
  static const Color dangerColor = Color(0xffbd342b);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF999999);
  static const Color lightYellow = Color.fromRGBO(255, 185, 0, 0.3);
  static const Color lightGreen = Color.fromRGBO(80, 200, 120, 0.5);
  static const Color lightRed = Color.fromRGBO(255, 152, 152, 0.5);

  static final ColorScheme colorScheme =
      ColorScheme.fromSeed(seedColor: primaryColor);
}

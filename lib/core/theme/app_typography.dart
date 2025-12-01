import 'package:flutter/material.dart';

const String kFontFamilyRobotoCondensed = "RobotoCondensed";

const TextTheme kAppTypography = TextTheme(
  titleLarge: TextStyle(
    fontFamily: kFontFamilyRobotoCondensed,
    fontWeight: FontWeight.bold, // 700
    fontSize: 22,
  ),
  bodyLarge: TextStyle(
    fontFamily: kFontFamilyRobotoCondensed,
    fontWeight: FontWeight.w500, // 500 (Medium)
    fontSize: 16,
  ),
  labelSmall: TextStyle(
    fontFamily: kFontFamilyRobotoCondensed,
    fontWeight: FontWeight.normal, // 400
    fontSize: 11,
  ),
);
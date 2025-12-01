import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/core/theme/app_typography.dart';

final ThemeData kAppTheme = ThemeData(
  // Use Material 3
  useMaterial3: true,

  // Define the Color Scheme
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,

    primary: kColorOrange,        // button and active icons
    onPrimary: kColorBlack,       // Texts/icons on primary color

    secondary: kColorBeige,       // News,video,"Easy Mode" button
    onSecondary: kColorBlack,    // Texts on background

    surface: kColorWhite,         // Card, Bottom Nav Bar background
    onSurface: kColorBlack,       // Texts on Card, Bottom Nav Bar

    // For not chosen sub-text and icon
    onSurfaceVariant: kColorGray,

    // // for error states
    // error: Colors.red.shade800,
    // onError: Colors.white,
  ),

  // Defines Font Family and Text Theme
  fontFamily: kFontFamilyRobotoCondensed,
  textTheme: kAppTypography,


  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: kAppTypography.labelSmall?.copyWith(fontWeight: FontWeight.bold),
    ),
  ),
);
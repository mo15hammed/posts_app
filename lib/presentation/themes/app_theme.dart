import 'package:flutter/material.dart';
import 'package:posts_app/core/constants/sizes.dart';

class AppTheme {
  const AppTheme._();

  static const primaryColor = Color(0xff082659);
  static const secondaryColor = Color(0xff51eec2);

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: secondaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: primaryColor),
      iconColor: secondaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: secondaryColor),
        borderRadius: BorderRadius.circular(Sizes.s8),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(Sizes.s8),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: Sizes.s1,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: Sizes.s8),
      horizontalTitleGap: Sizes.s32,
      minLeadingWidth: Sizes.s0,
      minVerticalPadding: Sizes.s8,
    ),
    platform: TargetPlatform.iOS,
  );
}

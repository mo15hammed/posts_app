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
        borderRadius: BorderRadius.circular(SizeManager.s8),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(SizeManager.s8),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: SizeManager.s1,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: SizeManager.s8),
      horizontalTitleGap: SizeManager.s32,
      minLeadingWidth: SizeManager.s0,
      minVerticalPadding: SizeManager.s8,
    ),
    platform: TargetPlatform.iOS,
  );
}

import 'package:flutter/cupertino.dart';

/// Defines complete CupertinoThemeData for both light and dark modes.
/// Uses TransLink brand blue as the primary color.
class AppTheme {
  AppTheme._();

  /// TransLink blue - primary brand color for light theme.
  static const Color _primaryLight = Color(0xFF0060A9);

  /// Lighter blue variant for dark theme readability.
  static const Color _primaryDark = Color(0xFF4DA6FF);

  /// Returns the appropriate CupertinoThemeData based on the given brightness.
  ///
  /// [brightness] determines whether to return light or dark theme configuration.
  static CupertinoThemeData getTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: _primaryDark,
        scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
        barBackgroundColor: CupertinoColors.darkBackgroundGray,
        textTheme: CupertinoTextThemeData(
          primaryColor: _primaryDark,
          textStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 17.0,
          ),
          navTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
          navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _primaryLight,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemBackground,
      textTheme: CupertinoTextThemeData(
        primaryColor: _primaryLight,
        textStyle: TextStyle(
          color: CupertinoColors.black,
          fontSize: 17.0,
        ),
        navTitleTextStyle: TextStyle(
          color: CupertinoColors.black,
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
        navLargeTitleTextStyle: TextStyle(
          color: CupertinoColors.black,
          fontSize: 34.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

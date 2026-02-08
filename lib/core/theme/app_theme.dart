import 'package:flutter/material.dart';

/// Defines complete Material 3 ThemeData for both light and dark modes.
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
  static ThemeData getTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final seed = isDark ? _primaryDark : _primaryLight;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      visualDensity: VisualDensity.standard,
    );

    const radius = 16.0;
    const smallRadius = 12.0;

    final navigationBarBackgroundColor =
        isDark ? const Color(0xFF1C2027) : Colors.white;

    return base.copyWith(
      scaffoldBackgroundColor:
          isDark ? navigationBarBackgroundColor : const Color(0xFFF7F7F9),
      cardTheme: base.cardTheme.copyWith(
        color: isDark ? const Color(0xFF20242B) : Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      dialogTheme: base.dialogTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0,
        centerTitle: true,
        backgroundColor: navigationBarBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      navigationBarTheme: base.navigationBarTheme.copyWith(
        elevation: 0,
        height: 72,
        backgroundColor: navigationBarBackgroundColor,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          base.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: isDark ? const Color(0xFF20242B) : Colors.white,
        hintStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(smallRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(smallRadius),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(smallRadius),
          borderSide: BorderSide(
            color: colorScheme.primary.withValues(alpha: 0.65),
            width: 1.5,
          ),
        ),
      ),
      listTileTheme: base.listTileTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      dividerTheme: base.dividerTheme.copyWith(
        color: colorScheme.outlineVariant.withValues(alpha: isDark ? 0.35 : 0.6),
        thickness: 1,
        space: 1,
      ),
    );
  }
}

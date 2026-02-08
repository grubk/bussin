import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ---------------------------------------------------------------------------
/// Theme Provider
/// ---------------------------------------------------------------------------
/// Riverpod provider that manages and persists the user's theme preference.
/// Uses [Notifier] instead of the legacy [StateNotifierProvider] for
/// Riverpod 3.x compatibility.
///
/// Reads/writes to SharedPreferences using the key 'theme_mode'.
/// ---------------------------------------------------------------------------

/// Provider for the theme brightness, managed by [ThemeNotifier].
final themeProvider = NotifierProvider<ThemeNotifier, Brightness>(
  ThemeNotifier.new,
);

/// Notifier that manages theme brightness state.
///
/// Supports light, dark, and system default modes.
/// Persists the user's choice to SharedPreferences on every change.
class ThemeNotifier extends Notifier<Brightness> {
  /// SharedPreferences key for storing theme mode.
  static const String _themeKey = 'theme_mode';

  @override
  Brightness build() {
    // Load saved preference asynchronously on first access.
    // Start with light mode, then update once prefs are loaded.
    _loadTheme();
    return Brightness.light;
  }

  /// Loads the saved theme preference from SharedPreferences.
  /// Falls back to light mode if no preference is saved.
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);
    if (themeIndex != null) {
      state = Brightness.values[themeIndex];
    }
  }

  /// Toggles between light and dark mode.
  Future<void> toggle() async {
    state = state == Brightness.light ? Brightness.dark : Brightness.light;
    await _persistTheme();
  }

  /// Sets the theme to a specific brightness mode.
  Future<void> setMode(Brightness brightness) async {
    state = brightness;
    await _persistTheme();
  }

  /// Persists the current theme choice to SharedPreferences.
  Future<void> _persistTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, state.index);
  }
}

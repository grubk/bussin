import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/core/theme/theme_provider.dart';

/// ---------------------------------------------------------------------------
/// ThemeToggle - Three-way theme mode selector
/// ---------------------------------------------------------------------------
/// Uses [SegmentedButton] to provide a Material-style segmented control with three options:
///
///   0 = Light mode (Brightness.light)
///   1 = Dark mode (Brightness.dark)
///   2 = System (follows device setting)
///
/// State:
///   - Reads the current theme from [themeProvider]
///   - Writes changes via [ref.read(themeProvider.notifier).setMode(brightness)]
///   - Theme choice is persisted to SharedPreferences by the ThemeNotifier
///
/// The "System" option maps to the platform's current brightness at the
/// time of selection. In a full implementation, this would use
/// WidgetsBinding.instance.platformDispatcher.platformBrightness and
/// listen for system theme changes.
/// ---------------------------------------------------------------------------
class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current theme brightness from the provider.
    // This updates the UI whenever the theme changes.
    final currentBrightness = ref.watch(themeProvider);

    return ListTile(
      leading: const Icon(Icons.brightness_6_outlined),
      title: const Text('Theme'),
      trailing: SegmentedButton<int>(
        segments: const [
          ButtonSegment<int>(
            value: 0,
            label: Text('Light'),
          ),
          ButtonSegment<int>(
            value: 1,
            label: Text('Dark'),
          ),
          ButtonSegment<int>(
            value: 2,
            label: Text('System'),
          ),
        ],
        selected: <int>{currentBrightness == Brightness.light ? 0 : 1},
        onSelectionChanged: (selection) {
          if (selection.isEmpty) return;
          final newValue = selection.first;
          switch (newValue) {
            case 0:
              ref.read(themeProvider.notifier).setMode(Brightness.light);
              break;
            case 1:
              ref.read(themeProvider.notifier).setMode(Brightness.dark);
              break;
            case 2:
              final platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              ref.read(themeProvider.notifier).setMode(platformBrightness);
              break;
          }
        },
        showSelectedIcon: false,
        style: ButtonStyle(
          visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
        ),
      ),
    );
  }
}

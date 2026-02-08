import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/core/theme/theme_provider.dart';

/// ---------------------------------------------------------------------------
/// ThemeToggle - Three-way theme mode selector
/// ---------------------------------------------------------------------------
/// Uses [CupertinoSlidingSegmentedControl] to provide a native iOS-style
/// segmented control with three options:
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

    // Map the current Brightness value to the segmented control index.
    // Light = 0, Dark = 1. "System" (2) is handled specially since the
    // provider stores the resolved Brightness, not a "system" enum.
    final selectedIndex = currentBrightness == Brightness.light ? 0 : 1;

    return CupertinoListTile(
      // Sun icon representing appearance/theme settings
      leading: const Icon(CupertinoIcons.sun_max),
      title: const Text('Theme'),

      // --- Segmented control as the trailing widget ---
      // Placed in trailing position to align with iOS settings conventions.
      trailing: SizedBox(
        width: 200,
        child: CupertinoSlidingSegmentedControl<int>(
          // Map of segment indices to their display labels
          children: const {
            0: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Light', style: TextStyle(fontSize: 13)),
            ),
            1: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Dark', style: TextStyle(fontSize: 13)),
            ),
            2: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('System', style: TextStyle(fontSize: 13)),
            ),
          },

          // Currently selected segment
          groupValue: selectedIndex,

          // Handle segment selection changes
          onValueChanged: (int? newValue) {
            if (newValue == null) return;

            switch (newValue) {
              case 0:
                // Set to light mode
                ref.read(themeProvider.notifier).setMode(Brightness.light);
                break;
              case 1:
                // Set to dark mode
                ref.read(themeProvider.notifier).setMode(Brightness.dark);
                break;
              case 2:
                // "System" mode: resolve to the platform's current brightness.
                // Uses MediaQuery to detect the system theme. In a production
                // app, you'd also listen for system theme change events.
                final platformBrightness =
                    MediaQuery.platformBrightnessOf(context);
                ref
                    .read(themeProvider.notifier)
                    .setMode(platformBrightness);
                break;
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/core/theme/app_theme.dart';
import 'package:bussin/core/theme/theme_provider.dart';
import 'package:bussin/navigation/app_router.dart';
import 'package:bussin/navigation/bottom_nav_bar.dart';

/// ---------------------------------------------------------------------------
/// BussinApp - Root application widget
/// ---------------------------------------------------------------------------
/// The top-level [ConsumerWidget] that configures the [CupertinoApp].
///
/// Responsibilities:
/// - Watches [themeProvider] to apply light/dark theme dynamically
/// - Registers all named routes from [AppRouter]
/// - Sets [MainScaffold] (bottom tab bar with Map/Favorites/Settings) as home
///
/// Uses [CupertinoApp] (not MaterialApp) for a consistent iOS-style UI
/// across all screens, matching the design spec.
/// ---------------------------------------------------------------------------
class BussinApp extends ConsumerWidget {
  const BussinApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme brightness to rebuild when user toggles light/dark mode
    final brightness = ref.watch(themeProvider);

    return CupertinoApp(
      // App title shown in the OS task switcher
      title: 'Bussin!',

      // Apply the correct theme based on current brightness setting
      theme: AppTheme.getTheme(brightness),

      // Register all named routes for push navigation
      routes: AppRouter.routes,

      // Main scaffold with bottom tab bar (Map / Favorites / Settings)
      home: const MainScaffold(),

      // Disable the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,
    );
  }
}

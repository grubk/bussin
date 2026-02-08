import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/features/map/map_screen.dart';
import 'package:bussin/features/favorites/favorites_screen.dart';
import 'package:bussin/features/settings/settings_screen.dart';

/// ---------------------------------------------------------------------------
/// Bottom Navigation Bar
/// ---------------------------------------------------------------------------
/// Three-tab bottom navigation using [CupertinoTabScaffold].
///
/// Tabs:
///   0 - Map      (CupertinoIcons.map)       -> MapScreen
///   1 - Favorites (CupertinoIcons.star)      -> FavoritesScreen
///   2 - Settings  (CupertinoIcons.gear)      -> SettingsScreen
///
/// Each tab maintains its own navigation stack so the user can push
/// screens within a tab without losing state in other tabs.
///
/// The Map tab's nav bar includes action buttons for history (clock)
/// and alerts (bell with badge), handled within MapScreen itself.
/// ---------------------------------------------------------------------------

/// Main scaffold widget that wraps the app's bottom tab navigation.
///
/// Uses [CupertinoTabScaffold] with three tabs, each containing its
/// own [CupertinoTabView] for independent navigation stacks.
class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTabScaffold(
      // Configure the bottom tab bar with three items
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          // Tab 0: Map - the main map screen showing live buses
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            label: 'Map',
          ),
          // Tab 1: Favorites - bookmarked stops with live ETAs
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            label: 'Favorites',
          ),
          // Tab 2: Settings - theme, notifications, about
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear),
            label: 'Settings',
          ),
        ],
      ),
      // Build each tab's content in its own navigation context
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                // Map tab: full-screen map with bus markers, search, overlays
                return const MapScreen();
              case 1:
                // Favorites tab: list of bookmarked stops with live arrival data
                return const FavoritesScreen();
              case 2:
                // Settings tab: theme toggle, notification prefs, about section
                return const SettingsScreen();
              default:
                return const MapScreen();
            }
          },
        );
      },
    );
  }
}

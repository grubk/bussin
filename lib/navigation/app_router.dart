import 'package:flutter/material.dart';
import 'package:bussin/features/search/search_screen.dart';
import 'package:bussin/features/route_detail/route_detail_screen.dart';
import 'package:bussin/features/stop_detail/stop_detail_screen.dart';
import 'package:bussin/features/favorites/favorites_screen.dart';
import 'package:bussin/features/history/history_screen.dart';
import 'package:bussin/features/alerts/alerts_screen.dart';
import 'package:bussin/features/settings/settings_screen.dart';

/// ---------------------------------------------------------------------------
/// App Router
/// ---------------------------------------------------------------------------
/// Defines named routes for the app's navigation system.
/// All screens are accessible via named routes that can be pushed
/// onto the Material navigation stack.
/// onto the Cupertino navigation stack.
///
/// Routes:
///   /search  -> SearchScreen (full-screen modal search)
///   /route   -> RouteDetailScreen (route detail with active buses)
///   /stop    -> StopDetailScreen (stop arrivals and alerts)
///   /favorites -> FavoritesScreen (bookmarked stops)
///   /history -> HistoryScreen (previously viewed routes)
///   /alerts  -> AlertsScreen (active service alerts)
///   /settings -> SettingsScreen (app configuration)
/// ---------------------------------------------------------------------------
class AppRouter {
  /// Named route constants for type-safe navigation.
  static const String search = '/search';
  static const String routeDetail = '/route';
  static const String stopDetail = '/stop';
  static const String favorites = '/favorites';
  static const String history = '/history';
  static const String alerts = '/alerts';
  static const String settings = '/settings';

  /// Route map used by [CupertinoApp.routes].
  ///
  /// Each route builds its corresponding screen widget.
  /// Screens that require arguments (routeId, stopId) receive them
  /// via [ModalRoute.of(context)?.settings.arguments].
  static Map<String, WidgetBuilder> get routes => {
        search: (context) => const SearchScreen(),
        routeDetail: (context) {
          // Extract the routeId argument passed during navigation
          final routeId =
              ModalRoute.of(context)?.settings.arguments as String? ?? '';
          return RouteDetailScreen(routeId: routeId);
        },
        stopDetail: (context) {
          // Extract the stopId argument passed during navigation
          final stopId =
              ModalRoute.of(context)?.settings.arguments as String? ?? '';
          return StopDetailScreen(stopId: stopId);
        },
        favorites: (context) => const FavoritesScreen(),
        history: (context) => const HistoryScreen(),
        alerts: (context) => const AlertsScreen(),
        settings: (context) => const SettingsScreen(),
      };

  /// Navigates to the search screen as a full-screen modal.
  static void pushSearch(BuildContext context) {
    Navigator.of(context).pushNamed(search);
  }

  /// Navigates to the route detail screen for the given route ID.
  static void pushRouteDetail(BuildContext context, String routeId) {
    Navigator.of(context).pushNamed(routeDetail, arguments: routeId);
  }

  /// Navigates to the stop detail screen for the given stop ID.
  static void pushStopDetail(BuildContext context, String stopId) {
    Navigator.of(context).pushNamed(stopDetail, arguments: stopId);
  }

  /// Navigates to the favorites screen.
  static void pushFavorites(BuildContext context) {
    Navigator.of(context).pushNamed(favorites);
  }

  /// Navigates to the history screen.
  static void pushHistory(BuildContext context) {
    Navigator.of(context).pushNamed(history);
  }

  /// Navigates to the alerts screen.
  static void pushAlerts(BuildContext context) {
    Navigator.of(context).pushNamed(alerts);
  }

  /// Navigates to the settings screen.
  static void pushSettings(BuildContext context) {
    Navigator.of(context).pushNamed(settings);
  }
}

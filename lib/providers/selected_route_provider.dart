import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ---------------------------------------------------------------------------
/// Selected Route Provider
/// ---------------------------------------------------------------------------
/// Holds the currently viewed/selected route ID as app-wide state.
/// When null, the map shows all buses. When set to a route ID, the map
/// filters to show only that route's buses, polyline, and stops.
///
/// Side effects triggered by route selection are handled in the UI layer
/// (map screen) which watches this provider and orchestrates:
///   - Adding the route to viewing history
///   - Loading the route polyline via routeShapeProvider
///   - Filtering vehicles via vehiclesForRouteProvider
/// ---------------------------------------------------------------------------

/// Notifier that manages the currently selected route ID.
///
/// Uses [Notifier] instead of the legacy [StateProvider] for Riverpod 3.x
/// compatibility.
final selectedRouteProvider =
    NotifierProvider<SelectedRouteNotifier, String?>(
  SelectedRouteNotifier.new,
);

/// Notifier managing the selected route state.
class SelectedRouteNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  /// Selects a route by ID, causing the map to:
  ///   1. Filter bus markers to only show vehicles on this route
  ///   2. Load and display the route polyline on the map
  ///   3. Show stop markers along the route
  ///   4. Display a route label chip with an "X" to deselect
  void selectRoute(String routeId) {
    state = routeId;
  }

  /// Deselects the current route, returning the map to "all buses" mode.
  /// Hides the polyline and stop markers.
  void clearSelection() {
    state = null;
  }
}

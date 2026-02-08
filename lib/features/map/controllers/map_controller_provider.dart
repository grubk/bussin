import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:bussin/core/constants/map_constants.dart';

/// ---------------------------------------------------------------------------
/// Map Controller Provider
/// ---------------------------------------------------------------------------
/// A Riverpod NotifierProvider that holds a reference to the
/// [AnimatedMapController] from the flutter_map_animations package, enabling
/// programmatic animated map control from anywhere in the widget tree.
///
/// **Why the AnimatedMapController is created in BusMap, not here:**
/// [AnimatedMapController] requires a `vsync` parameter (a [TickerProvider]),
/// which is only available from a [StatefulWidget] mixed with
/// [TickerProviderStateMixin]. Since Riverpod Notifiers are not widgets and
/// cannot provide a TickerProvider, the AnimatedMapController must be created
/// inside the BusMap widget's State and then registered here via
/// [setAnimatedMapController].
///
/// This provider serves as a bridge: the BusMap widget creates and owns the
/// AnimatedMapController, registers it here, and then any widget in the tree
/// can call animated map methods through this provider's notifier.
///
/// Methods:
/// - [setAnimatedMapController]: Registers the AnimatedMapController from BusMap
/// - [clearAnimatedMapController]: Clears the reference on widget disposal
/// - [centerOnUser]: Animates map to user's GPS position at zoom 15
/// - [fitRouteBounds]: Animates the map to fit all route coordinates in view
/// - [animateToPosition]: Animates map to any LatLng at a specified zoom
/// ---------------------------------------------------------------------------

/// Provider exposing the [MapControllerNotifier] for programmatic map control.
///
/// The state tracks initialization status so callers can check readiness.
/// Widgets call methods on the notifier via:
///   ref.read(mapControllerProvider.notifier).someMethod()
final mapControllerProvider =
    NotifierProvider<MapControllerNotifier, MapControllerState>(
  MapControllerNotifier.new,
);

/// State class for the map controller provider.
///
/// Tracks whether the AnimatedMapController has been registered (set by BusMap)
/// so callers can check readiness before attempting map operations.
class MapControllerState {
  /// Whether the AnimatedMapController has been registered.
  final bool isInitialized;

  const MapControllerState({this.isInitialized = false});
}

/// Notifier that manages programmatic map control.
///
/// Holds a reference to the [AnimatedMapController] created and owned by BusMap.
/// The AnimatedMapController provides both animated movements (animateTo,
/// animatedFitCamera) and access to the raw MapController via its
/// `.mapController` property.
class MapControllerNotifier extends Notifier<MapControllerState> {
  /// The animated map controller, created by BusMap and registered here.
  /// Provides smooth animated pan/zoom/rotate and exposes `.mapController`
  /// for direct (non-animated) operations.
  AnimatedMapController? _animatedMapController;

  @override
  MapControllerState build() {
    // Initial state: not yet initialized (waiting for BusMap to register
    // the AnimatedMapController after its initState completes).
    return const MapControllerState(isInitialized: false);
  }

  /// Registers the [AnimatedMapController] created by the BusMap widget.
  ///
  /// Called once from BusMap's initState (via addPostFrameCallback) after
  /// the AnimatedMapController has been constructed with the widget's
  /// TickerProvider as vsync.
  ///
  /// This must be called before any map manipulation methods (centerOnUser,
  /// fitRouteBounds, etc.) will work. If called before initialization,
  /// those methods silently no-op to avoid crashes.
  void setAnimatedMapController(AnimatedMapController controller) {
    _animatedMapController = controller;

    // Update state to indicate the controller is ready for use
    state = const MapControllerState(isInitialized: true);
  }

  /// Clears the AnimatedMapController reference.
  ///
  /// Called from BusMap's dispose method to prevent the provider from holding
  /// a stale reference to a disposed controller. After this call, all map
  /// manipulation methods will silently no-op until a new controller is
  /// registered.
  void clearAnimatedMapController() {
    _animatedMapController = null;
    state = const MapControllerState(isInitialized: false);
  }

  /// Centers the map on the user's GPS position at street-level zoom.
  ///
  /// Called when the user taps the LocateMeButton. Animates smoothly
  /// to the user's position at zoom level 15, which provides enough
  /// detail to see nearby streets and stops.
  ///
  /// [position] is the user's current GPS position from the geolocator package.
  /// No-ops silently if the AnimatedMapController hasn't been registered yet.
  void centerOnUser(Position position) {
    if (_animatedMapController == null) return;

    _animatedMapController!.animateTo(
      dest: LatLng(position.latitude, position.longitude),
      zoom: 15.0,
    );
  }

  /// Fits the map viewport to contain all coordinates in a route shape,
  /// using an animated camera transition.
  ///
  /// Used when a route is selected to zoom out/in so the entire route
  /// polyline is visible on screen. Applies padding defined in
  /// [MapConstants.fitBoundsPadding] (50px) to prevent the polyline
  /// from touching the screen edges.
  ///
  /// Uses [AnimatedMapController.animatedFitCamera] for a smooth animated
  /// transition instead of an instant jump.
  ///
  /// [points] is the ordered list of LatLng coordinates forming the route path.
  /// No-ops if the list is empty or controller isn't registered.
  void fitRouteBounds(List<LatLng> points) {
    if (_animatedMapController == null || points.isEmpty) return;

    // Calculate the bounding box that contains all route coordinates,
    // then animate the camera to fit those bounds with padding.
    final bounds = LatLngBounds.fromPoints(points);

    _animatedMapController!.animatedFitCamera(
      cameraFit: CameraFit.bounds(
        bounds: bounds,
        padding: MapConstants.fitBoundsPadding,
      ),
    );
  }

  /// Animates the map to a specific position and zoom level.
  ///
  /// General-purpose method for moving the map to any location.
  /// Used by various features like "center on stop" or "center on bus".
  ///
  /// [position] is the target center coordinate.
  /// [zoom] is the target zoom level.
  /// No-ops if the AnimatedMapController hasn't been registered.
  void animateToPosition(LatLng position, double zoom) {
    if (_animatedMapController == null) return;

    _animatedMapController!.animateTo(
      dest: position,
      zoom: zoom,
    );
  }
}

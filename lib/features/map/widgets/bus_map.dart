import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:bussin/core/constants/map_constants.dart';
import 'package:bussin/core/constants/app_constants.dart';
import 'package:bussin/providers/location_provider.dart';
import 'package:bussin/providers/selected_route_provider.dart';
import 'package:bussin/data/models/vehicle_position.dart';

import 'package:bussin/features/map/widgets/route_polyline_layer.dart';
import 'package:bussin/features/map/widgets/stop_marker_layer.dart';
import 'package:bussin/features/map/widgets/bus_marker_layer.dart';
import 'package:bussin/features/map/widgets/user_location_marker.dart';
import 'package:bussin/features/map/controllers/map_controller_provider.dart';

/// ---------------------------------------------------------------------------
/// BusMap - The FlutterMap widget composing all map layers
/// ---------------------------------------------------------------------------
/// This is the core map widget that renders the OpenStreetMap tile layer and
/// overlays all transit-specific layers on top:
///
/// 1. TileLayer - OSM base tiles
/// 2. RoutePolylineLayer - Route path drawn when a route is selected
/// 3. StopMarkerLayer - Stop circles along the selected route
/// 4. BusMarkerLayer - Animated bus position markers
/// 5. UserLocationMarker - Blue pulsing dot at user's GPS position
/// 6. RichAttributionWidget - OSM + TransLink attribution
///
/// Uses [ConsumerStatefulWidget] with [TickerProviderStateMixin] because:
/// - The [AnimatedMapController] requires a [TickerProvider] for its `vsync`
///   parameter, which enables smooth animated map transitions (pan/zoom).
/// - [TickerProviderStateMixin] makes this widget's State a valid TickerProvider.
/// - The AnimatedMapController is created here and registered with the
///   [mapControllerProvider] so other widgets (e.g., LocateMeButton) can
///   programmatically move the map via the provider's notifier.
///
/// Props:
/// - [vehicles]: AsyncValue containing the list of active bus positions
/// - [selectedRouteId]: Currently selected route ID (nullable)
/// - [onBusTapped]: Callback fired when a bus marker is tapped
/// ---------------------------------------------------------------------------
class BusMap extends ConsumerStatefulWidget {
  /// The current vehicle positions to render as markers.
  /// Wrapped in AsyncValue to handle loading/error states from the stream.
  final AsyncValue<List<VehiclePositionModel>> vehicles;

  /// The currently selected route ID, or null if showing all routes.
  /// When non-null, the polyline and stop layers activate for this route.
  final String? selectedRouteId;

  /// Callback invoked when the user taps a bus marker.
  /// Receives the tapped vehicle's data so the parent can open an info sheet.
  final void Function(VehiclePositionModel vehicle) onBusTapped;

  const BusMap({
    super.key,
    required this.vehicles,
    required this.selectedRouteId,
    required this.onBusTapped,
  });

  @override
  ConsumerState<BusMap> createState() => _BusMapState();
}

/// State for [BusMap].
///
/// Mixes in [TickerProviderStateMixin] to serve as the `vsync` for
/// [AnimatedMapController]. This is required because AnimatedMapController
/// creates [AnimationController] instances internally, and those need a
/// [TickerProvider] to drive their animations.
class _BusMapState extends ConsumerState<BusMap> with TickerProviderStateMixin {
  /// The animated map controller that wraps a raw [MapController] and provides
  /// smooth animated movements (pan, zoom, rotate) via the flutter_map_animations
  /// package. Created in [initState] with `this` as the vsync TickerProvider.
  late final AnimatedMapController _animatedMapController;

  @override
  void initState() {
    super.initState();

    // Create the AnimatedMapController with this widget's State as the
    // TickerProvider (vsync). The AnimatedMapController internally creates
    // a MapController if none is provided, so we let it manage its own.
    // Animation duration of 500ms with easeOut curve for a snappy, natural feel.
    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    // Register the AnimatedMapController with the Riverpod provider after the
    // first frame, so other widgets can trigger map movements (e.g., the
    // LocateMeButton calling centerOnUser, or route selection fitting bounds).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(mapControllerProvider.notifier)
          .setAnimatedMapController(_animatedMapController);
    });
  }

  @override
  void dispose() {
    // Clear the provider's reference first to prevent any late calls
    // to a disposed controller.
    ref.read(mapControllerProvider.notifier).clearAnimatedMapController();

    // Dispose the AnimatedMapController, which stops any running animations
    // and disposes internal AnimationControllers. It also disposes the
    // internally-created MapController since we didn't pass one in.
    _animatedMapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the user's GPS position stream for the blue dot marker.
    // Returns null while loading or on error (marker won't render).
    final userPosition = ref.watch(currentLocationProvider).value;

    // Extract the vehicle list from AsyncValue, defaulting to empty list
    // during loading or error states so the map still renders.
    final vehicleList = widget.vehicles.value ?? [];

    return FlutterMap(
      // Use the AnimatedMapController's internal mapController so that
      // animated movements are properly wired to this FlutterMap instance.
      mapController: _animatedMapController.mapController,
      options: MapOptions(
        // Center the map on Vancouver, BC on first load
        initialCenter: MapConstants.vancouverCenter,
        initialZoom: MapConstants.defaultZoom,

        // Clamp zoom to prevent zooming out to world view or past tile detail
        minZoom: MapConstants.minZoom,
        maxZoom: MapConstants.maxZoom,
      ),
      children: [
        // ---- Layer 1: Base map tiles (OpenStreetMap) ----
        // The bottom-most layer providing the geographic context.
        // Uses OSM tiles which are free and require no API key,
        // but do require a user agent string for tile policy compliance.
        TileLayer(
          urlTemplate: MapConstants.tileUrl,
          userAgentPackageName: MapConstants.userAgentPackage,
        ),

        // ---- Layer 2: Route polyline (selected route path) ----
        // Draws the geographic path of the currently selected route.
        // Renders nothing (empty SizedBox) when no route is selected.
        RoutePolylineLayer(routeId: widget.selectedRouteId),

        // ---- Layer 3: Stop markers along the selected route ----
        // Small gray circles at each stop on the route.
        // Renders nothing when no route is selected.
        StopMarkerLayer(routeId: widget.selectedRouteId),

        // ---- Layer 4: Bus position markers ----
        // Animated markers showing each active bus's real-time position.
        // Markers smoothly interpolate between old and new positions
        // during polling updates for fluid visual movement.
        BusMarkerLayer(
          vehicles: vehicleList,
          onBusTapped: widget.onBusTapped,
        ),

        // ---- Layer 5: User GPS location (blue pulsing dot) ----
        // Shows the user's current position with a pulsing animation.
        // Renders nothing if location permission is denied or unavailable.
        UserLocationMarker(position: userPosition),

        // ---- Layer 6: Attribution (required by OSM and TransLink ToS) ----
        // Displays attribution text for OpenStreetMap tiles and TransLink data.
        // Uses RichAttributionWidget for a collapsible attribution panel.
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
            TextSourceAttribution(AppConstants.translinkAttribution),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/shape_providers.dart';

/// ---------------------------------------------------------------------------
/// RoutePolylineLayer - Draws the route path on the map
/// ---------------------------------------------------------------------------
/// When a route is selected, this layer fetches the route's shape data
/// (an ordered list of LatLng coordinates from GTFS shape tables) and
/// renders it as a polyline overlay on the map.
///
/// The polyline uses TransLink's brand blue (#0060A9) at 4.0 stroke width,
/// providing a clear visual path without obscuring other map features.
///
/// Behavior:
/// - If [routeId] is null (no route selected): renders an empty SizedBox
///   so the layer takes no visual space and the map shows freely.
/// - If [routeId] is non-null: watches [routeShapeProvider(routeId)] which
///   returns a FutureProvider<List<LatLng>>. Shows nothing while loading,
///   and the polyline once data is available.
///
/// This is a [ConsumerWidget] (stateless) because it has no animation
/// or controller lifecycle -- it just reads provider data and renders.
/// ---------------------------------------------------------------------------
class RoutePolylineLayer extends ConsumerWidget {
  /// The route ID to draw the polyline for, or null if no route is selected.
  final String? routeId;

  const RoutePolylineLayer({
    super.key,
    required this.routeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Guard: no route selected ---
    // Return an empty widget so this layer doesn't render anything.
    // Using SizedBox.shrink() for minimal overhead in the widget tree.
    if (routeId == null) {
      return const SizedBox.shrink();
    }

    // --- Fetch the route shape from the provider ---
    // routeShapeProvider is a FutureProvider.family keyed by routeId.
    // It returns an ordered List<LatLng> representing the route's path.
    final shapeAsync = ref.watch(routeShapeProvider(routeId!));

    return shapeAsync.when(
      // --- Loading state: render nothing while shape data is being fetched ---
      loading: () => const SizedBox.shrink(),

      // --- Error state: silently render nothing ---
      // Shape data is non-critical; the map is still usable without it.
      // Errors are logged upstream in the repository layer.
      error: (_, __) => const SizedBox.shrink(),

      // --- Data state: render the polyline ---
      data: (points) {
        // Guard against empty shape data (e.g., route has no shape in GTFS)
        if (points.isEmpty) {
          return const SizedBox.shrink();
        }

        return PolylineLayer(
          polylines: [
            Polyline(
              // The ordered coordinates forming the route's geographic path
              points: points,

              // TransLink brand blue color for the route line
              color: const Color(0xFF0060A9),

              // 4.0 pixel stroke width provides visibility without being
              // too thick and obscuring underlying map features
              strokeWidth: 4.0,
            ),
          ],
        );
      },
    );
  }
}

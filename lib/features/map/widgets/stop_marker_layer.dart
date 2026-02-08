import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:bussin/providers/stop_providers.dart';
import 'package:bussin/navigation/app_router.dart';

/// ---------------------------------------------------------------------------
/// StopMarkerLayer - Small circle markers at each stop along a selected route
/// ---------------------------------------------------------------------------
/// When a route is selected, this layer loads all stops served by that route
/// (from GTFS static data via [stopsForRouteProvider]) and renders them as
/// small gray circles with white borders on the map.
///
/// The markers are intentionally small (8px) to avoid cluttering the map
/// while still providing visual reference points along the route polyline.
///
/// Behavior:
/// - If [routeId] is null: renders nothing (no route is selected)
/// - If [routeId] is non-null: watches stopsForRouteProvider(routeId)
///   and renders a MarkerLayer with one small circle per stop
/// - On tap: navigates to the StopDetailScreen for that stop via AppRouter
///
/// This is a [ConsumerWidget] because it only reads provider data (no
/// animation controllers or local state needed).
/// ---------------------------------------------------------------------------
class StopMarkerLayer extends ConsumerWidget {
  /// The selected route ID, or null if no route is active.
  /// When null, this layer renders nothing.
  final String? routeId;

  const StopMarkerLayer({
    super.key,
    required this.routeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Guard: no route selected ---
    // Nothing to render when the user hasn't selected a specific route.
    if (routeId == null) {
      return const SizedBox.shrink();
    }

    // --- Fetch stops for the selected route ---
    // stopsForRouteProvider performs a JOIN across trips, stop_times, and stops
    // tables to find all stops on this route, ordered by stop sequence.
    final stopsAsync = ref.watch(stopsForRouteProvider(routeId!));

    return stopsAsync.when(
      // Show nothing while stops are being loaded from SQLite
      loading: () => const SizedBox.shrink(),

      // Silently handle errors -- stops are supplementary info
      error: (_, __) => const SizedBox.shrink(),

      // --- Render stop markers ---
      data: (stops) {
        final markers = stops.map((stop) {
          return Marker(
            // Position the marker at the stop's geographic coordinates
            point: LatLng(stop.stopLat, stop.stopLon),
            width: 16,
            height: 16,

            child: GestureDetector(
              // Navigate to the stop detail screen when tapped.
              // The stop detail screen shows live arrivals and alerts
              // for this specific stop.
              onTap: () => AppRouter.pushStopDetail(context, stop.stopId),

              // --- Stop marker visual: small gray circle ---
              // 8px diameter gray circle with a white border for contrast.
              // Intentionally small to not obscure the route polyline
              // or bus markers.
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Medium gray fill that works on both light and dark map areas
                    color: CupertinoColors.systemGrey,
                    border: Border.all(
                      color: CupertinoColors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList();

        return MarkerLayer(markers: markers);
      },
    );
  }
}

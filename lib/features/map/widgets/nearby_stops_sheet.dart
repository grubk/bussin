import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/core/constants/map_constants.dart';
import 'package:bussin/core/utils/distance_utils.dart';
import 'package:bussin/core/utils/time_utils.dart';
import 'package:bussin/providers/nearby_stops_provider.dart';
import 'package:bussin/providers/trip_update_providers.dart';
import 'package:bussin/navigation/app_router.dart';

/// ---------------------------------------------------------------------------
/// NearbyStopsSheet - Draggable bottom sheet showing nearby stops
/// ---------------------------------------------------------------------------
/// A Cupertino-styled draggable bottom sheet that lists transit stops within
/// 500m of the user's current GPS position, sorted by distance (closest first).
///
/// Each stop item displays:
/// - Stop name (e.g., "UBC Exchange Bay 7")
/// - Distance from user (e.g., "150m", "1.2km")
/// - Next 2-3 bus arrivals with ETA countdown (e.g., "2 min", "15 min")
///
/// State consumed:
/// - [nearbyStopsProvider]: Combined GPS + stop data yielding nearby stops
/// - [etasForStopProvider]: Real-time arrival predictions per stop
///
/// Interactions:
/// - Tap on a stop row: navigates to StopDetailScreen via AppRouter
/// - If location is unavailable: shows an informational message
///
/// This is a [ConsumerWidget] because it reads provider data but has no
/// animation controllers or local state.
/// ---------------------------------------------------------------------------
class NearbyStopsSheet extends ConsumerWidget {
  const NearbyStopsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the nearby stops data, which combines GPS position + stop list
    final nearbyAsync = ref.watch(nearbyStopsProvider);

    return Container(
      // Constrain the sheet height to 60% of the screen
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        // Cupertino-style sheet with rounded top corners
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // --- Drag handle ---
          // A small gray pill at the top indicating the sheet is draggable.
          // Standard iOS bottom sheet affordance.
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey3,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),

          // --- Header row ---
          // "Nearby Stops" title with a distance radius indicator on the right.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nearby Stops',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Distance radius indicator shows the search radius
                // so users understand the scope of the results.
                Text(
                  'Within ${DistanceUtils.formatDistance(MapConstants.nearbyRadiusMeters)}',
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // --- Separator line ---
          Container(
            height: 0.5,
            color: CupertinoColors.separator,
          ),

          // --- Stop list content ---
          // Handles loading, error, and data states from the nearby stops provider.
          Expanded(
            child: nearbyAsync.when(
              // --- Loading state ---
              // Shows a centered activity indicator while GPS position
              // or stop data is being loaded.
              loading: () => const Center(
                child: CupertinoActivityIndicator(),
              ),

              // --- Error state (likely location unavailable) ---
              // Shows a friendly message when GPS is denied or unavailable.
              // Uses the location icon to visually communicate the issue.
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.location_slash,
                        size: 48,
                        color: CupertinoColors.systemGrey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Location Unavailable',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enable location services to see nearby stops.',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey.resolveFrom(context),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // --- Data state: list of nearby stops ---
              data: (nearbyStops) {
                // Handle empty results (no stops within radius)
                if (nearbyStops.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'No stops found within 500m.\nTry moving to a different area.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }

                // Build a scrollable list of stop rows
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: nearbyStops.length,
                  // Thin separator line between stop rows
                  separatorBuilder: (_, __) => Container(
                    height: 0.5,
                    margin: const EdgeInsets.only(left: 16),
                    color: CupertinoColors.separator,
                  ),
                  itemBuilder: (context, index) {
                    final (stop, distance) = nearbyStops[index];
                    return _NearbyStopRow(
                      stopId: stop.stopId,
                      stopName: stop.stopName,
                      distance: distance,
                      onTap: () => AppRouter.pushStopDetail(context, stop.stopId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _NearbyStopRow - Individual stop row in the nearby stops list
/// ---------------------------------------------------------------------------
/// Displays a single stop with its name, distance, and live arrivals.
///
/// Layout:
/// ┌──────────────────────────────────────────┐
/// │ Stop Name                         150m   │
/// │ Route 49 · 2 min | Route 99 · 15 min     │
/// └──────────────────────────────────────────┘
class _NearbyStopRow extends ConsumerWidget {
  final String stopId;
  final String stopName;
  final double distance;
  final VoidCallback onTap;

  const _NearbyStopRow({
    required this.stopId,
    required this.stopName,
    required this.distance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch live ETAs for this specific stop from the trip updates stream.
    // etasForStopProvider filters all trip updates to find arrivals at this stop.
    final etasAsync = ref.watch(etasForStopProvider(stopId));

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top row: stop name + distance ---
            Row(
              children: [
                // Stop name (expands to fill available space)
                Expanded(
                  child: Text(
                    stopName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.label,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                // Distance from user, formatted as "150m" or "1.2km"
                Text(
                  DistanceUtils.formatDistance(distance),
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // --- Bottom row: next 2-3 arrivals with ETA ---
            // Shows the soonest buses arriving at this stop.
            etasAsync.when(
              loading: () => const Text(
                'Loading arrivals...',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 13,
                ),
              ),
              error: (_, __) => const Text(
                'No arrival data',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 13,
                ),
              ),
              data: (etas) {
                if (etas.isEmpty) {
                  return const Text(
                    'No upcoming arrivals',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 13,
                    ),
                  );
                }

                // Take the first 3 arrivals and format them as ETA strings
                final upcomingEtas = etas.take(3).map((eta) {
                  if (eta.predictedArrival == null) return null;

                  // Calculate seconds until arrival from now
                  final secondsAway = eta.predictedArrival!
                      .difference(DateTime.now())
                      .inSeconds;

                  // Only show future arrivals (positive seconds)
                  if (secondsAway < 0) return null;

                  return TimeUtils.formatEta(secondsAway);
                }).whereType<String>();

                if (upcomingEtas.isEmpty) {
                  return const Text(
                    'No upcoming arrivals',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 13,
                    ),
                  );
                }

                // Join arrival times with " | " separator
                return Text(
                  upcomingEtas.join(' | '),
                  style: const TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

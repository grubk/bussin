import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/data/models/trip_update.dart';
import 'package:bussin/core/utils/time_utils.dart';
import 'package:bussin/providers/selected_route_provider.dart';

/// ---------------------------------------------------------------------------
/// Arrival List Tile
/// ---------------------------------------------------------------------------
/// A single row in the stop detail screen's upcoming arrivals list.
/// Each tile represents one bus arrival prediction at the current stop.
///
/// Displays:
///   - Route number badge (colored circle/pill matching the GTFS route color)
///   - Headsign/destination text (e.g., "To UBC")
///   - Predicted arrival countdown (e.g., "2 min", "15 min", "Now")
///   - Delay indicator: green "On time" or red "+3 min late"
///
/// On tap: sets the selectedRouteProvider to this route's ID and pops
/// back to the map screen, which will then filter to show only this route.
/// ---------------------------------------------------------------------------
class ArrivalListTile extends ConsumerWidget {
  /// The stop time update containing predicted arrival time and delay.
  final StopTimeUpdateModel stopTimeUpdate;

  /// The GTFS route ID for this arrival (used for badge color and selection).
  final String routeId;

  /// The route short name to display in the badge (e.g., "049", "99").
  final String routeShortName;

  /// Optional headsign/destination text for this trip.
  final String? headsign;

  /// Hex color code from GTFS route data (without '#' prefix).
  /// Used for the route badge background color.
  final String? routeColor;

  const ArrivalListTile({
    super.key,
    required this.stopTimeUpdate,
    required this.routeId,
    required this.routeShortName,
    this.headsign,
    this.routeColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate the arrival countdown from the predicted arrival time.
    // Shows "N/A" if no predicted arrival is available.
    final now = DateTime.now();
    final arrivalText = _formatArrivalCountdown(stopTimeUpdate, now);

    // Format the delay indicator using the shared utility.
    final delayText = stopTimeUpdate.arrivalDelay != null
        ? TimeUtils.formatDelay(stopTimeUpdate.arrivalDelay!)
        : null;

    // Delay color: green for on-time/early, red for late.
    final delayColor = _getDelayColor(stopTimeUpdate.arrivalDelay);

    // Parse the route color for the badge.
    final badgeColor = _parseRouteColor(routeColor);

    return GestureDetector(
      onTap: () {
        // Set the selected route so the map filters to this route's buses,
        // then pop back to the map screen.
        ref.read(selectedRouteProvider.notifier).selectRoute(routeId);
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // ----------------------------------------------------------------
            // Route number badge (colored pill)
            // ----------------------------------------------------------------
            Container(
              constraints: const BoxConstraints(minWidth: 48.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  routeShortName,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12.0),

            // ----------------------------------------------------------------
            // Headsign / destination text
            // ----------------------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headsign ?? 'Route $routeShortName',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Delay indicator text (only shown if delay data exists).
                  if (delayText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        delayText,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: delayColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ----------------------------------------------------------------
            // Arrival countdown (e.g., "2 min", "Now")
            // ----------------------------------------------------------------
            Text(
              arrivalText,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats the arrival countdown relative to [now].
  ///
  /// Uses [TimeUtils.formatEta] which returns contextual strings like
  /// "Now", "< 1 min", "2 min", etc. Returns "N/A" if no prediction exists.
  String _formatArrivalCountdown(StopTimeUpdateModel stopTime, DateTime now) {
    final predicted = stopTime.predictedArrival;
    if (predicted == null) return 'N/A';

    final secondsAway = predicted.difference(now).inSeconds;
    // If the bus has already passed, show "Due" instead of negative minutes.
    if (secondsAway < 0) return 'Due';
    return TimeUtils.formatEta(secondsAway);
  }

  /// Returns the color for a delay value:
  ///   Green = on time or early, Red = late, Grey = unknown.
  Color _getDelayColor(int? delay) {
    if (delay == null) return CupertinoColors.systemGrey;
    if (delay <= 0) return CupertinoColors.activeGreen;
    final minutes = (delay.abs() / 60).round();
    if (minutes == 0) return CupertinoColors.activeGreen;
    return CupertinoColors.destructiveRed;
  }

  /// Parses a GTFS hex color string into a Flutter [Color].
  /// Falls back to TransLink brand blue (#0060A9) if parsing fails.
  Color _parseRouteColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return const Color(0xFF0060A9);
    }
    try {
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (_) {
      return const Color(0xFF0060A9);
    }
  }
}

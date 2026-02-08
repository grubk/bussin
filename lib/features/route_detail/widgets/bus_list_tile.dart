import 'package:flutter/cupertino.dart';

import 'package:bussin/data/models/vehicle_position.dart';
import 'package:bussin/core/utils/time_utils.dart';

/// ---------------------------------------------------------------------------
/// Bus List Tile
/// ---------------------------------------------------------------------------
/// A single card representing one active bus operating on a route.
/// Displayed in the "Active Buses" section of the route detail screen.
///
/// Shows:
///   - Vehicle label/number (the bus number riders see on the bus)
///   - Current speed converted from m/s to km/h
///   - Delay indicator: "On time" (green), "+X min late" (red),
///     or "-X min early" (green)
///   - Tap callback for navigation (e.g., center map on this bus)
///
/// Uses Cupertino styling to match the iOS-native design language.
/// ---------------------------------------------------------------------------
class BusListTile extends StatelessWidget {
  /// The real-time vehicle position data for this bus.
  final VehiclePositionModel vehicle;

  /// Overall delay in seconds for this bus's trip.
  /// Positive = late, negative = early, null = unknown.
  final int? delaySeconds;

  /// Callback invoked when the user taps this tile.
  final VoidCallback? onTap;

  const BusListTile({
    super.key,
    required this.vehicle,
    this.delaySeconds,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Convert speed from m/s (GTFS-RT default) to km/h for display.
    // If speed is null (not reported by the vehicle), show "N/A".
    final speedKmh = vehicle.speed != null
        ? (vehicle.speed! * 3.6).toStringAsFixed(0)
        : null;

    // Format the delay into a human-readable string using our utility.
    final delayText = delaySeconds != null
        ? TimeUtils.formatDelay(delaySeconds!)
        : 'Unknown';

    // Determine the color for the delay indicator:
    //   Green = on time or early, Red = late, Grey = unknown.
    final delayColor = _getDelayColor(delaySeconds);

    return GestureDetector(
      onTap: onTap,
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
            // Bus icon + vehicle label
            // ----------------------------------------------------------------
            const Icon(
              CupertinoIcons.bus,
              size: 24.0,
              color: CupertinoColors.systemGrey,
            ),
            const SizedBox(width: 10.0),

            // Vehicle label (bus number displayed on the physical bus).
            // Falls back to the vehicle ID if no label is available.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus ${vehicle.vehicleLabel ?? vehicle.vehicleId}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2.0),

                  // Speed display: shows current speed in km/h.
                  Text(
                    speedKmh != null ? '$speedKmh km/h' : 'Speed N/A',
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------------------
            // Delay indicator badge
            // ----------------------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: delayColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                delayText,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: delayColor,
                ),
              ),
            ),

            const SizedBox(width: 4.0),

            // Chevron indicating the tile is tappable.
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16.0,
              color: CupertinoColors.systemGrey3,
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the appropriate color for a delay value:
  ///   - Green: on time (0) or early (negative)
  ///   - Red: late (positive, more than ~30 seconds)
  ///   - Grey: unknown (null)
  Color _getDelayColor(int? delay) {
    if (delay == null) return CupertinoColors.systemGrey;
    if (delay <= 0) return CupertinoColors.activeGreen;
    // Only show red if the bus is meaningfully late (>30 seconds).
    final minutes = (delay.abs() / 60).round();
    if (minutes == 0) return CupertinoColors.activeGreen;
    return CupertinoColors.destructiveRed;
  }
}

import 'package:flutter/cupertino.dart';

import 'package:bussin/data/models/trip_update.dart';
import 'package:bussin/core/utils/time_utils.dart';

/// ---------------------------------------------------------------------------
/// ETA Timeline
/// ---------------------------------------------------------------------------
/// A vertical timeline widget showing a bus's upcoming stops with predicted
/// arrival times. Used on the route detail screen to visualize where a
/// specific bus is along its trip.
///
/// Visual structure:
///   - A vertical line connecting all stops
///   - Circular dots at each stop position
///   - Past stops are grayed out (stop sequence < current sequence)
///   - Future stops display the predicted arrival time
///   - Delay is shown in red (late) or green (early) next to each time
///
/// The [currentStopSequence] parameter determines which stops are "past"
/// vs. "future" based on the bus's current position in the trip.
/// ---------------------------------------------------------------------------
class EtaTimeline extends StatelessWidget {
  /// Ordered list of stop time updates for this trip.
  /// Each entry contains a stop ID, sequence number, predicted time, and delay.
  final List<StopTimeUpdateModel> stopTimeUpdates;

  /// The bus's current position in the stop sequence.
  /// Stops with sequence <= this value are considered "past" (grayed out).
  /// Null if the current position is unknown.
  final int? currentStopSequence;

  /// Optional map of stop IDs to human-readable stop names.
  /// If not provided, raw stop IDs are displayed instead.
  final Map<String, String>? stopNames;

  const EtaTimeline({
    super.key,
    required this.stopTimeUpdates,
    this.currentStopSequence,
    this.stopNames,
  });

  @override
  Widget build(BuildContext context) {
    // If there are no stop time updates, show a placeholder message.
    if (stopTimeUpdates.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No stop predictions available',
          style: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 14.0,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Build a timeline entry for each stop in the trip.
          for (int i = 0; i < stopTimeUpdates.length; i++)
            _buildTimelineEntry(
              context,
              stopTimeUpdates[i],
              isFirst: i == 0,
              isLast: i == stopTimeUpdates.length - 1,
            ),
        ],
      ),
    );
  }

  /// Builds a single row in the vertical timeline for one stop.
  ///
  /// Each row consists of:
  ///   Left side: the vertical line segment + dot
  ///   Right side: stop name, predicted time, and delay indicator
  Widget _buildTimelineEntry(
    BuildContext context,
    StopTimeUpdateModel stopTime, {
    required bool isFirst,
    required bool isLast,
  }) {
    // Determine whether this stop is in the past (bus has already passed it).
    final isPast = currentStopSequence != null &&
        stopTime.stopSequence <= currentStopSequence!;

    // Is this the stop the bus is currently at or approaching?
    final isCurrent = currentStopSequence != null &&
        stopTime.stopSequence == currentStopSequence;

    // Color scheme: past stops are grayed out, current is highlighted,
    // future stops use the default text color.
    final dotColor = isCurrent
        ? CupertinoColors.activeBlue
        : isPast
            ? CupertinoColors.systemGrey3
            : CupertinoColors.activeBlue.withOpacity(0.6);

    final textColor = isPast
        ? CupertinoColors.systemGrey3
        : CupertinoColors.label.resolveFrom(context);

    // Format the predicted arrival time, or show "--:--" if unavailable.
    final timeText = stopTime.predictedArrival != null
        ? TimeUtils.formatScheduledTime(stopTime.predictedArrival!)
        : '--:--';

    // Format the delay indicator for this stop.
    final delayText = stopTime.arrivalDelay != null
        ? TimeUtils.formatDelay(stopTime.arrivalDelay!)
        : null;

    // Delay color: green for on-time/early, red for late.
    final delayColor = _getDelayColor(stopTime.arrivalDelay);

    // Resolve the stop name from the provided map, or fall back to stop ID.
    final displayName = stopNames?[stopTime.stopId] ?? 'Stop ${stopTime.stopId}';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ----------------------------------------------------------------
          // Left column: vertical line + dot
          // ----------------------------------------------------------------
          SizedBox(
            width: 30.0,
            child: Column(
              children: [
                // Vertical line segment above the dot (hidden for first stop).
                Expanded(
                  child: Container(
                    width: isFirst ? 0.0 : 2.0,
                    color: isPast
                        ? CupertinoColors.systemGrey4
                        : CupertinoColors.activeBlue.withOpacity(0.3),
                  ),
                ),

                // Dot at the stop position. Current stop gets a larger dot.
                Container(
                  width: isCurrent ? 14.0 : 10.0,
                  height: isCurrent ? 14.0 : 10.0,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    // Add a border ring to the current stop for emphasis.
                    border: isCurrent
                        ? Border.all(
                            color: CupertinoColors.activeBlue,
                            width: 2.0,
                          )
                        : null,
                  ),
                ),

                // Vertical line segment below the dot (hidden for last stop).
                Expanded(
                  child: Container(
                    width: isLast ? 0.0 : 2.0,
                    color: isPast
                        ? CupertinoColors.systemGrey4
                        : CupertinoColors.activeBlue.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10.0),

          // ----------------------------------------------------------------
          // Right column: stop name, time, and delay
          // ----------------------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Stop name.
                  Expanded(
                    child: Text(
                      displayName,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Predicted arrival time.
                  Text(
                    timeText,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),

                  // Delay indicator (only shown if delay data exists).
                  if (delayText != null) ...[
                    const SizedBox(width: 6.0),
                    Text(
                      delayText,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: delayColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
}

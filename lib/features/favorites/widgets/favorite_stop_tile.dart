import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/data/models/favorite_stop.dart';
import 'package:bussin/data/models/trip_update.dart';
import 'package:bussin/providers/trip_update_providers.dart';
import 'package:bussin/core/utils/time_utils.dart';
import 'package:bussin/navigation/app_router.dart';

/// ---------------------------------------------------------------------------
/// FavoriteStopTile - A single favorite stop with live arrival data
/// ---------------------------------------------------------------------------
/// Renders one row in the favorites list, displaying:
///   1. Stop name as the primary text
///   2. Next 2-3 bus arrivals with route badges and countdown times
///   3. Swipe-left to delete via [Dismissible]
///
/// State consumed:
///   - [etasForStopProvider(stopId)]: real-time ETAs for this stop from
///     the GTFS-RT trip updates feed, polled every 30 seconds.
///
/// Interactions:
///   - Tap: navigates to [StopDetailScreen] via [AppRouter.pushStopDetail]
///   - Swipe left: triggers the [onDismissed] callback for delete confirmation
/// ---------------------------------------------------------------------------
class FavoriteStopTile extends ConsumerWidget {
  /// The favorite stop data model (from SQLite favorites table).
  final FavoriteStop favorite;

  /// Callback invoked when the user swipes left to dismiss this tile.
  /// The parent screen handles showing the confirmation dialog.
  final VoidCallback onDismissed;

  const FavoriteStopTile({
    super.key,
    required this.favorite,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch live ETAs for this stop. The provider filters the global
    // trip updates stream to only include stop time updates matching
    // this stop's ID, sorted by soonest arrival first.
    final etasAsync = ref.watch(etasForStopProvider(favorite.stopId));

    // Wrap in Dismissible for swipe-to-delete functionality.
    // The endToStart direction matches iOS convention (swipe left to delete).
    return Dismissible(
      key: ValueKey(favorite.stopId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),

      // Red background with trash icon revealed during swipe
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: CupertinoColors.systemRed,
        child: const Icon(
          CupertinoIcons.trash,
          color: CupertinoColors.white,
        ),
      ),

      // --- Tile content: tappable row with stop info and ETAs ---
      child: GestureDetector(
        // Navigate to the stop detail screen on tap
        onTap: () => AppRouter.pushStopDetail(context, favorite.stopId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            // Subtle bottom border between list items
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.separator,
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Stop name ---
              Text(
                favorite.stopName,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // --- Live arrival data ---
              // Renders the next 2-3 arrivals as route badges with countdowns,
              // or shows loading/error/no-data states.
              etasAsync.when(
                // Show arrival badges when data is available
                data: (etas) => _buildArrivalRow(etas),

                // Small spinner while ETAs load
                loading: () => const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: CupertinoActivityIndicator(radius: 8),
                ),

                // Subtle error message if ETAs fail to load
                error: (_, __) => const Text(
                  'Unable to load arrivals',
                  style: TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a horizontal row of the next 2-3 bus arrivals.
  ///
  /// Each arrival shows a small colored route badge followed by the
  /// countdown time (e.g., "3 min", "Now"). Limited to 3 arrivals
  /// to keep the tile compact.
  Widget _buildArrivalRow(List<StopTimeUpdateModel> etas) {
    // No upcoming arrivals for this stop
    if (etas.isEmpty) {
      return const Text(
        'No upcoming arrivals',
        style: TextStyle(
          fontSize: 13,
          color: CupertinoColors.systemGrey,
        ),
      );
    }

    // Take only the first 3 soonest arrivals to keep the tile compact
    final displayEtas = etas.take(3).toList();

    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: displayEtas.map((eta) {
        // Calculate the countdown string from predicted arrival time
        final arrivalText = _formatArrivalCountdown(eta);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Route badge - small colored pill with the stop sequence
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                eta.stopSequence.toString(),
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 4),

            // Countdown time text
            Text(
              arrivalText,
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  /// Converts a [StopTimeUpdateModel]'s predicted arrival into a
  /// human-readable countdown string using [TimeUtils.formatEta].
  ///
  /// Returns "Scheduled" if no predicted arrival time is available
  /// (meaning only static schedule data exists, no real-time prediction).
  String _formatArrivalCountdown(StopTimeUpdateModel eta) {
    final predicted = eta.predictedArrival;
    if (predicted == null) return 'Scheduled';

    final secondsAway = predicted.difference(DateTime.now()).inSeconds;

    // Use the shared TimeUtils formatter for consistent ETA display
    // across the app (handles "Now", "< 1 min", "X min" cases)
    return TimeUtils.formatEta(secondsAway.clamp(0, 99999));
  }
}

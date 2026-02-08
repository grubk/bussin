import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/data/models/bus_stop.dart';
import 'package:bussin/data/models/favorite_stop.dart';
import 'package:bussin/providers/favorites_provider.dart';

/// ---------------------------------------------------------------------------
/// Stop Info Header
/// ---------------------------------------------------------------------------
/// Top section of the stop detail screen showing the stop's identity and
/// a favorite toggle button. Displays:
///   - Stop name in large text
///   - Stop code (the 5-digit number on the physical bus stop sign)
///   - Star button to add/remove the stop from favorites
///
/// This widget reads from Riverpod providers directly because the favorite
/// toggle requires writing state (adding/removing favorites), making it
/// a ConsumerWidget.
/// ---------------------------------------------------------------------------
class StopInfoHeader extends ConsumerWidget {
  /// The stop model containing name, code, coordinates, etc.
  final BusStop stop;

  const StopInfoHeader({super.key, required this.stop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch whether this stop is currently in the user's favorites list.
    // Uses the isFavoriteProvider which derives from the favoritesProvider.
    final isFavorite = ref.watch(isFavoriteProvider(stop.stopId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------------------
          // Left side: stop name and stop code
          // ----------------------------------------------------------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stop name displayed prominently.
                Text(
                  stop.stopName,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4.0),

                // Stop code: the 5-digit number riders use to look up
                // schedules via phone or text. Displayed with a '#' prefix
                // for clarity (e.g., "#51479").
                if (stop.stopCode != null && stop.stopCode!.isNotEmpty)
                  Text(
                    '#${stop.stopCode}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),

          // ----------------------------------------------------------------
          // Right side: favorite toggle button (star icon)
          // ----------------------------------------------------------------
          CupertinoButton(
            padding: EdgeInsets.zero,
            // Toggle favorite status on tap.
            onPressed: () => _toggleFavorite(ref, isFavorite),
            child: Icon(
              // Filled star when favorited, outline star when not.
              isFavorite
                  ? CupertinoIcons.star_fill
                  : CupertinoIcons.star,
              size: 28.0,
              color: isFavorite
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }

  /// Adds or removes this stop from the user's favorites list.
  ///
  /// When adding: creates a [FavoriteStop] model with the current timestamp
  /// and inserts it into SQLite via the favorites notifier.
  /// When removing: deletes the stop from SQLite by stop ID.
  void _toggleFavorite(WidgetRef ref, bool isCurrentlyFavorite) {
    if (isCurrentlyFavorite) {
      // Remove from favorites by stop ID.
      ref.read(favoritesProvider.notifier).removeFavorite(stop.stopId);
    } else {
      // Add to favorites with full stop data for offline display.
      ref.read(favoritesProvider.notifier).addFavorite(
            FavoriteStop(
              stopId: stop.stopId,
              stopName: stop.stopName,
              stopLat: stop.stopLat,
              stopLon: stop.stopLon,
              createdAt: DateTime.now(),
            ),
          );
    }
  }
}

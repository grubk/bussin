import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:bussin/data/models/route_history_entry.dart';
import 'package:bussin/providers/selected_route_provider.dart';

/// ---------------------------------------------------------------------------
/// HistoryEntryTile - A single route history entry
/// ---------------------------------------------------------------------------
/// Renders one row in the history list, displaying:
///   1. Route number badge (colored pill) on the left
///   2. Route name (long name) as the primary text
///   3. Time the route was last viewed (formatted with intl, e.g. "2:30 PM")
///
/// Interactions:
///   - Tap: sets [selectedRouteProvider] to this route's ID (so the map
///     filters to show this route) and pops the history screen to return
///     to the map.
/// ---------------------------------------------------------------------------
class HistoryEntryTile extends ConsumerWidget {
  /// The route history entry data model from SQLite.
  final RouteHistoryEntry entry;

  const HistoryEntryTile({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Format the "viewed at" timestamp to a user-friendly time string.
    // Uses the intl package's DateFormat for locale-aware formatting.
    final viewedTimeText = DateFormat('h:mm a').format(entry.viewedAt);

    return GestureDetector(
      // On tap: select this route on the map and navigate back
      onTap: () {
        // Update the selected route provider so the map filters to this route.
        // Uses the NotifierProvider API: ref.read(...notifier).selectRoute()
        ref.read(selectedRouteProvider.notifier).selectRoute(entry.routeId);

        // Pop the history screen to return to the map, which will now
        // show the selected route's buses, polyline, and stops.
        Navigator.of(context).pop();
      },
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
        child: Row(
          children: [
            // --- Route number badge ---
            // Colored pill showing the route's short name (e.g., "049", "R4").
            // Uses TransLink blue as the default badge color.
            _RouteBadge(routeShortName: entry.routeShortName),
            const SizedBox(width: 12),

            // --- Route name and viewed time ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route long name (full descriptive name)
                  Text(
                    entry.routeLongName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // Time the route was last viewed
                  Text(
                    'Viewed at $viewedTimeText',
                    style: const TextStyle(
                      fontSize: 13,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),

            // --- Forward chevron indicating tappable ---
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: CupertinoColors.systemGrey3,
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _RouteBadge - Colored pill displaying a route's short name
/// ---------------------------------------------------------------------------
/// Used to visually identify routes with a compact colored badge.
/// Matches the route badge styling used throughout the app.
class _RouteBadge extends StatelessWidget {
  /// The route's short display name (e.g., "049", "099", "R4").
  final String routeShortName;

  const _RouteBadge({required this.routeShortName});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 44),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        // TransLink blue as default badge color
        color: CupertinoColors.activeBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        routeShortName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

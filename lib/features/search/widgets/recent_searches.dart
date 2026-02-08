import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/data/models/route_history_entry.dart';
import 'package:bussin/providers/history_provider.dart';

/// ---------------------------------------------------------------------------
/// RecentSearches
/// ---------------------------------------------------------------------------
/// Shown in the search screen content area when the search query is empty.
///
/// Displays the user's most recently viewed routes (up to 10) so they can
/// quickly re-select a route without typing. Each row shows a route badge
/// and the route name, matching the same visual pattern used in
/// [SearchResultTile.route].
///
/// Data source: [historyProvider] (async, loaded from SQLite).
/// On tap: fires [onRouteTap] with the route ID so the parent screen can
/// update [selectedRouteProvider] and pop.
/// ---------------------------------------------------------------------------

/// TransLink brand blue -- used as the badge background color for recent
/// route entries (GTFS route color is not stored in history entries).
const Color _kTransLinkBlue = Color(0xFF0060A9);

/// Maximum number of recent entries to display.
const int _kMaxRecentEntries = 10;

class RecentSearches extends ConsumerWidget {
  /// Callback invoked when the user taps a recent route entry.
  /// Receives the route ID of the tapped entry.
  final void Function(String routeId) onRouteTap;

  const RecentSearches({
    super.key,
    required this.onRouteTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the history provider to reactively rebuild when history changes
    // (e.g. after a new route is viewed and the user re-opens search).
    final historyAsync = ref.watch(historyProvider);

    return historyAsync.when(
      // -- Loading state: show a spinner while SQLite reads history ----------
      loading: () => const Center(
        child: CupertinoActivityIndicator(),
      ),

      // -- Error state: silently show empty (history is non-critical) --------
      error: (error, stackTrace) => const SizedBox.shrink(),

      // -- Data state: render the recent entries list -----------------------
      data: (entries) {
        if (entries.isEmpty) {
          return _buildEmptyState();
        }

        // Take only the most recent N entries. The provider already returns
        // entries sorted by viewedAt descending, so we just limit the count.
        final recentEntries = entries.length > _kMaxRecentEntries
            ? entries.sublist(0, _kMaxRecentEntries)
            : entries;

        return ListView(
          // Dismiss the keyboard when the user scrolls through recent items.
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            // -- Section header -----------------------------------------------
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Text(
                'Recent',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.systemGrey,
                  // Uppercase section header matching iOS grouped list style.
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // -- Recent route entries -----------------------------------------
            ...recentEntries.map(
              (entry) => _buildRecentRow(entry),
            ),
          ],
        );
      },
    );
  }

  // -------------------------------------------------------------------------
  // Sub-widgets
  // -------------------------------------------------------------------------

  /// Builds a single row for a recent route history entry.
  ///
  /// Layout mirrors [SearchResultTile.route]: colored badge on the left,
  /// route name in the center, chevron on the right.
  Widget _buildRecentRow(RouteHistoryEntry entry) {
    return GestureDetector(
      onTap: () => onRouteTap(entry.routeId),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // -- Route badge --------------------------------------------------
            // History entries don't store the GTFS route color, so we always
            // use TransLink blue for the badge background.
            Container(
              constraints: const BoxConstraints(minWidth: 48.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kTransLinkBlue,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                entry.routeShortName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(width: 12.0),

            // -- Route name ---------------------------------------------------
            Expanded(
              child: Text(
                entry.routeLongName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15.0),
              ),
            ),

            const SizedBox(width: 8.0),

            // -- Chevron indicator --------------------------------------------
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

  /// Empty state shown when the user has no route viewing history yet.
  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.search,
              size: 48.0,
              color: CupertinoColors.systemGrey3,
            ),
            SizedBox(height: 12.0),
            Text(
              'Search for a route or stop',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Your recently viewed routes will appear here.',
              style: TextStyle(
                color: CupertinoColors.systemGrey2,
                fontSize: 13.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

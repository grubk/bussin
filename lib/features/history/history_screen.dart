import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/history_provider.dart';
import 'package:bussin/features/history/widgets/history_entry_tile.dart';

/// ---------------------------------------------------------------------------
/// HistoryScreen - Previously viewed routes list
/// ---------------------------------------------------------------------------
/// Shows a chronological list of routes the user has previously selected
/// on the map, with the most recently viewed route at the top.
///
/// Features:
///   - "Clear" button in the nav bar to wipe all history
///   - List of [HistoryEntryTile] widgets showing route info and view time
///   - Tapping an entry re-selects the route on the map and pops back
///   - Empty state when no routes have been viewed yet
///
/// State consumed:
///   - [historyProvider]: AsyncNotifier backed by SQLite with auto-pruning
///     (max 50 entries) and upsert behavior (re-viewing updates timestamp)
/// ---------------------------------------------------------------------------
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch history provider to reactively rebuild when entries change.
    // AsyncValue because history is loaded from SQLite on first access.
    final historyAsync = ref.watch(historyProvider);

    return CupertinoPageScaffold(
      // --- Navigation bar with title and clear button ---
      navigationBar: CupertinoNavigationBar(
        middle: const Text('History'),

        // "Clear" button in the trailing position to delete all history.
        // Only enabled when history data is loaded and non-empty.
        trailing: historyAsync.when(
          data: (entries) => entries.isNotEmpty
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _confirmClearHistory(context, ref),
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                )
              : null, // Hide button when history is empty
          loading: () => null,
          error: (_, __) => null,
        ),
      ),

      // --- Main content: async state handling ---
      child: SafeArea(
        child: historyAsync.when(
          // --- Loading state ---
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),

          // --- Error state ---
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Failed to load history:\n$error',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          // --- Data state: list of history entries or empty state ---
          data: (entries) {
            // Empty state when no routes have been viewed
            if (entries.isEmpty) {
              return const _EmptyHistoryView();
            }

            // Scrollable list of history entry tiles
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return HistoryEntryTile(entry: entries[index]);
              },
            );
          },
        ),
      ),
    );
  }

  /// Shows a Cupertino confirmation dialog before clearing all history.
  ///
  /// Uses a destructive action button to clearly indicate this is
  /// an irreversible operation that removes all route viewing history.
  void _confirmClearHistory(BuildContext context, WidgetRef ref) {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Clear History'),
        content: const Text(
          'Are you sure you want to clear all route viewing history? '
          'This action cannot be undone.',
        ),
        actions: [
          // Cancel - dismiss without action
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          // Clear - wipe all history from SQLite and state
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Clear All'),
            onPressed: () {
              ref.read(historyProvider.notifier).clearHistory();
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _EmptyHistoryView - Shown when no routes have been viewed yet
/// ---------------------------------------------------------------------------
/// Centered message encouraging the user to explore routes on the map.
class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clock icon matching the history navigation icon
            Icon(
              CupertinoIcons.clock,
              size: 48,
              color: CupertinoColors.systemGrey3,
            ),
            SizedBox(height: 16),

            // Primary message
            Text(
              'No route history yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.systemGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // Instructional sub-text
            Text(
              'Routes you view on the map will appear here',
              style: TextStyle(
                fontSize: 15,
                color: CupertinoColors.systemGrey2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

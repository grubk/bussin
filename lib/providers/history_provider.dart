import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/data/models/route_history_entry.dart';
import 'package:bussin/data/repositories/history_repository.dart';

/// ---------------------------------------------------------------------------
/// History Providers
/// ---------------------------------------------------------------------------
/// These providers manage the user's route viewing history. History entries
/// are persisted in SQLite with auto-pruning (max 50 entries) and upsert
/// behavior (viewing the same route again updates the timestamp).
/// ---------------------------------------------------------------------------

/// Singleton instance of [HistoryRepository].
///
/// Provides CRUD operations on the route_history SQLite table.
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});

/// Manages the list of route history entries with async persistence.
///
/// Uses [AsyncNotifier] to load history from SQLite on initialization
/// and exposes methods to add entries and clear all history.
/// The repository handles upsert logic and auto-pruning internally.
final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<RouteHistoryEntry>>(
  HistoryNotifier.new,
);

/// Notifier that manages route history state with SQLite persistence.
///
/// The [build] method loads all history entries from the database,
/// ordered by most recently viewed first.
class HistoryNotifier extends AsyncNotifier<List<RouteHistoryEntry>> {
  /// Loads route viewing history from SQLite.
  @override
  Future<List<RouteHistoryEntry>> build() async {
    final repo = ref.read(historyRepositoryProvider);
    return repo.getHistory();
  }

  /// Adds or updates a route entry in the viewing history.
  ///
  /// Implements upsert behavior: if the route already exists in history,
  /// updates the viewed_at timestamp. Otherwise, inserts a new entry.
  /// After mutation, reloads the full list from the database.
  Future<void> addToHistory(RouteHistoryEntry entry) async {
    final repo = ref.read(historyRepositoryProvider);
    await repo.addToHistory(entry);

    // Reload from database to reflect upsert + auto-pruning
    state = AsyncData(await repo.getHistory());
  }

  /// Clears all route viewing history and refreshes the state.
  Future<void> clearHistory() async {
    final repo = ref.read(historyRepositoryProvider);
    await repo.clearHistory();

    // Update state to empty list immediately
    state = const AsyncData([]);
  }
}

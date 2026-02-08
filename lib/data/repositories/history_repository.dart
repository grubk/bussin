import 'package:bussin/core/constants/app_constants.dart';
import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/models/route_history_entry.dart';

/// Repository for CRUD operations on the user's route viewing history.
///
/// History entries are stored in SQLite and auto-pruned to keep at most
/// [AppConstants.maxHistoryEntries] (50) entries. When a route is viewed
/// again, the existing entry's timestamp is updated (upsert behavior).
class HistoryRepository {
  HistoryRepository();

  /// Fetches the route viewing history, ordered by most recent first.
  ///
  /// Limited to [AppConstants.maxHistoryEntries] entries.
  Future<List<RouteHistoryEntry>> getHistory() async {
    final rows = await LocalDatabaseService.db.query(
      'route_history',
      orderBy: 'viewed_at DESC',
      limit: AppConstants.maxHistoryEntries,
    );
    return rows.map(_mapRowToEntry).toList();
  }

  /// Adds or updates a route entry in the viewing history.
  ///
  /// Implements upsert behavior: if the route_id already exists in
  /// history, updates the viewed_at timestamp. Otherwise, inserts a
  /// new entry. After insertion, prunes old entries to stay within
  /// the maximum limit.
  Future<void> addToHistory(RouteHistoryEntry entry) async {
    // Check if this route already exists in history
    final existing = await LocalDatabaseService.db.query(
      'route_history',
      where: 'route_id = ?',
      whereArgs: [entry.routeId],
      limit: 1,
    );

    if (existing.isNotEmpty) {
      // Update the timestamp of the existing entry
      await LocalDatabaseService.db.update(
        'route_history',
        {'viewed_at': entry.viewedAt.toIso8601String()},
        where: 'route_id = ?',
        whereArgs: [entry.routeId],
      );
    } else {
      // Insert a new history entry
      await LocalDatabaseService.db.insert('route_history', {
        'route_id': entry.routeId,
        'route_short_name': entry.routeShortName,
        'route_long_name': entry.routeLongName,
        'viewed_at': entry.viewedAt.toIso8601String(),
      });
    }

    // Auto-prune: delete oldest entries beyond the maximum limit
    await _pruneHistory();
  }

  /// Clears all route viewing history entries.
  Future<void> clearHistory() async {
    await LocalDatabaseService.db.delete('route_history');
  }

  /// Removes the oldest history entries when the count exceeds the limit.
  ///
  /// Keeps only the most recent [AppConstants.maxHistoryEntries] entries
  /// by deleting rows with the oldest viewed_at timestamps.
  Future<void> _pruneHistory() async {
    final countResult = await LocalDatabaseService.db.rawQuery(
      'SELECT COUNT(*) as count FROM route_history',
    );
    final count = countResult.first['count'] as int;

    if (count > AppConstants.maxHistoryEntries) {
      // Delete the oldest entries that exceed the limit
      await LocalDatabaseService.db.rawDelete('''
        DELETE FROM route_history
        WHERE id NOT IN (
          SELECT id FROM route_history
          ORDER BY viewed_at DESC
          LIMIT ?
        )
      ''', [AppConstants.maxHistoryEntries]);
    }
  }

  /// Maps a database row to a [RouteHistoryEntry] domain model.
  RouteHistoryEntry _mapRowToEntry(Map<String, dynamic> row) {
    return RouteHistoryEntry(
      id: row['id'] as int?,
      routeId: row['route_id'] as String,
      routeShortName: row['route_short_name'] as String,
      routeLongName: row['route_long_name'] as String,
      viewedAt: DateTime.parse(row['viewed_at'] as String),
    );
  }
}

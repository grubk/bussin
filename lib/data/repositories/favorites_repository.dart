import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/models/favorite_stop.dart';

/// Repository for CRUD operations on the user's favorite stops.
///
/// Favorites are stored in the local SQLite database and persist across
/// app sessions. Each favorite stores the stop's location data so it
/// can be displayed without querying the GTFS stops table.
class FavoritesRepository {
  FavoritesRepository();

  /// Fetches all favorite stops, ordered by most recently added first.
  Future<List<FavoriteStop>> getFavorites() async {
    final rows = await LocalDatabaseService.db.query(
      'favorites',
      orderBy: 'created_at DESC',
    );
    return rows.map(_mapRowToFavorite).toList();
  }

  /// Adds a stop to the user's favorites.
  ///
  /// Inserts a new row into the favorites table. The stop_id has a
  /// UNIQUE constraint, so adding a duplicate will fail gracefully.
  Future<void> addFavorite(FavoriteStop stop) async {
    await LocalDatabaseService.db.insert('favorites', {
      'stop_id': stop.stopId,
      'stop_name': stop.stopName,
      'stop_lat': stop.stopLat,
      'stop_lon': stop.stopLon,
      'created_at': stop.createdAt.toIso8601String(),
    });
  }

  /// Removes a stop from the user's favorites by its stop ID.
  Future<void> removeFavorite(String stopId) async {
    await LocalDatabaseService.db.delete(
      'favorites',
      where: 'stop_id = ?',
      whereArgs: [stopId],
    );
  }

  /// Checks whether a stop is in the user's favorites.
  ///
  /// Returns true if the stop_id exists in the favorites table.
  Future<bool> isFavorite(String stopId) async {
    final result = await LocalDatabaseService.db.rawQuery(
      'SELECT COUNT(*) as count FROM favorites WHERE stop_id = ?',
      [stopId],
    );
    final count = result.first['count'] as int;
    return count > 0;
  }

  /// Maps a database row to a [FavoriteStop] domain model.
  FavoriteStop _mapRowToFavorite(Map<String, dynamic> row) {
    return FavoriteStop(
      id: row['id'] as int?,
      stopId: row['stop_id'] as String,
      stopName: row['stop_name'] as String,
      stopLat: (row['stop_lat'] as num).toDouble(),
      stopLon: (row['stop_lon'] as num).toDouble(),
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

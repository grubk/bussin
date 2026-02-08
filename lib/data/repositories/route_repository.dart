import 'dart:developer' as developer;
import 'package:bussin/data/datasources/gtfs_static_service.dart';
import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/models/bus_route.dart';

/// Repository that provides route data from the local SQLite cache
/// of GTFS static data.
///
/// Routes are originally imported from the GTFS static ZIP file
/// (routes.txt) and stored in the gtfs_routes table. This repository
/// queries that table and maps rows to [BusRoute] domain models.
class RouteRepository {
  /// Database service for SQLite queries.
  final LocalDatabaseService _dbService;

  /// GTFS static service for downloading and re-importing data.
  final GtfsStaticService _gtfsService;

  RouteRepository({
    required LocalDatabaseService dbService,
    required GtfsStaticService gtfsService,
  })  : _dbService = dbService,
        _gtfsService = gtfsService;

  /// Fetches all routes from the local SQLite database.
  ///
  /// Maps each database row to a [BusRoute] model.
  Future<List<BusRoute>> getAllRoutes() async {
    final rows = await LocalDatabaseService.db.query('gtfs_routes');
    return rows.map(_mapRowToRoute).toList();
  }

  /// Fetches a single route by its ID.
  ///
  /// Returns null if the route is not found in the database.
  Future<BusRoute?> getRoute(String routeId) async {
    final rows = await LocalDatabaseService.db.query(
      'gtfs_routes',
      where: 'route_id = ?',
      whereArgs: [routeId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _mapRowToRoute(rows.first);
  }

  /// Searches routes by short name or long name using SQL LIKE.
  ///
  /// Matches routes where the short name or long name contains the [query]
  /// string (case-insensitive). Limited to 20 results for performance.
  Future<List<BusRoute>> searchRoutes(String query) async {
    final stopwatch = Stopwatch()..start();
    developer.log('🔍 Searching routes for query: "$query"', name: 'RouteRepository');

    final rows = await LocalDatabaseService.db.query(
      'gtfs_routes',
      where:
          'route_short_name LIKE ? OR route_long_name LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      limit: 20,
    );
    final results = rows.map(_mapRowToRoute).toList();
    stopwatch.stop();
    developer.log(
      '✅ Route search returned ${results.length} results for "$query" (${stopwatch.elapsedMilliseconds}ms)',
      name: 'RouteRepository',
    );
    return results;
  }

  /// Forces a refresh of route data from the GTFS static ZIP file.
  ///
  /// Downloads the latest GTFS data, clears the existing tables,
  /// and re-imports routes from the routes.txt CSV.
  Future<void> refreshFromStatic() async {
    await _gtfsService.downloadAndExtractGtfsData();

    // Parse routes.txt CSV
    final routeRows = await _gtfsService.parseCsvFile('routes.txt');

    // Clear existing route data
    await LocalDatabaseService.db.delete('gtfs_routes');

    // Bulk insert new data
    final dbRows = routeRows.map((row) => {
      'route_id': row['route_id'] ?? '',
      'route_short_name': row['route_short_name'] ?? '',
      'route_long_name': row['route_long_name'] ?? '',
      'route_type': int.tryParse(row['route_type'] ?? '3') ?? 3,
      'route_color': row['route_color'],
    }).toList();

    await _dbService.bulkInsertRoutes(dbRows);
  }

  /// Maps a database row map to a [BusRoute] domain model.
  BusRoute _mapRowToRoute(Map<String, dynamic> row) {
    return BusRoute(
      routeId: row['route_id'] as String,
      routeShortName: row['route_short_name'] as String,
      routeLongName: row['route_long_name'] as String,
      routeType: row['route_type'] as int,
      routeColor: row['route_color'] as String?,
    );
  }
}

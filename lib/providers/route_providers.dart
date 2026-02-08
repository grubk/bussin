import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/data/datasources/gtfs_static_service.dart';
import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/models/bus_route.dart';
import 'package:bussin/data/repositories/route_repository.dart';

/// ---------------------------------------------------------------------------
/// Route Providers
/// ---------------------------------------------------------------------------
/// These providers expose GTFS static route data loaded from the local
/// SQLite database. Routes are downloaded once from TransLink's GTFS
/// static ZIP file and cached in SQLite. Providers include full list,
/// single lookup, and search functionality.
/// ---------------------------------------------------------------------------

/// Singleton instance of [LocalDatabaseService].
///
/// Manages the SQLite database lifecycle and provides bulk insert methods.
final localDatabaseServiceProvider = Provider<LocalDatabaseService>((ref) {
  return LocalDatabaseService();
});

/// Singleton instance of [GtfsStaticService].
///
/// Handles downloading and parsing the GTFS static ZIP file from TransLink.
final gtfsStaticServiceProvider = Provider<GtfsStaticService>((ref) {
  return GtfsStaticService();
});

/// Singleton instance of [RouteRepository].
///
/// Depends on [LocalDatabaseService] for SQLite queries and
/// [GtfsStaticService] for refreshing data from the GTFS ZIP.
final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  final dbService = ref.watch(localDatabaseServiceProvider);
  final gtfsService = ref.watch(gtfsStaticServiceProvider);
  return RouteRepository(dbService: dbService, gtfsService: gtfsService);
});

/// All transit routes loaded from SQLite.
///
/// Loaded once and cached by Riverpod. Contains all routes from the
/// GTFS static data (~250 routes for TransLink). Used for search
/// and route detail screens.
final allRoutesProvider = FutureProvider<List<BusRoute>>((ref) async {
  return ref.read(routeRepositoryProvider).getAllRoutes();
});

/// Single route lookup by route ID.
///
/// Returns the [BusRoute] matching the given [routeId], or null if
/// no route is found. Uses SQLite query with WHERE clause.
final routeProvider =
    FutureProvider.family<BusRoute?, String>((ref, routeId) async {
  return ref.read(routeRepositoryProvider).getRoute(routeId);
});

/// Route search results for a given query string.
///
/// Matches routes where the short name or long name contains the
/// query (case-insensitive). Limited to 20 results for performance.
/// Used by the search screen to display matching routes.
final routeSearchProvider =
    FutureProvider.family<List<BusRoute>, String>((ref, query) async {
  if (query.isEmpty) return [];
  return ref.read(routeRepositoryProvider).searchRoutes(query);
});

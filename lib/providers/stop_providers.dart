import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/data/models/bus_stop.dart';
import 'package:bussin/data/repositories/stop_repository.dart';
import 'package:bussin/providers/route_providers.dart';

/// ---------------------------------------------------------------------------
/// Stop Providers
/// ---------------------------------------------------------------------------
/// These providers expose GTFS static stop data from SQLite. Stops are
/// cached in-memory within the repository after the first load (~8,000 stops
/// for the TransLink network). Providers include full list, single lookup,
/// route-specific stops, and search functionality.
/// ---------------------------------------------------------------------------

/// Singleton instance of [StopRepository].
///
/// Depends on [LocalDatabaseService] and [GtfsStaticService] from
/// the route providers module (shared singletons).
final stopRepositoryProvider = Provider<StopRepository>((ref) {
  final dbService = ref.watch(localDatabaseServiceProvider);
  final gtfsService = ref.watch(gtfsStaticServiceProvider);
  return StopRepository(dbService: dbService, gtfsService: gtfsService);
});

/// All transit stops loaded from SQLite.
///
/// Loaded once and cached both by Riverpod and in the repository's
/// in-memory cache. Contains ~8,000 stops for the TransLink network.
/// Used as the base dataset for nearby-stop calculations.
final allStopsProvider = FutureProvider<List<BusStop>>((ref) async {
  return ref.read(stopRepositoryProvider).getAllStops();
});

/// Single stop lookup by stop ID.
///
/// Returns the [BusStop] matching the given [stopId], or null if not found.
/// Used by the stop detail screen to display stop info.
final stopProvider =
    FutureProvider.family<BusStop?, String>((ref, stopId) async {
  return ref.read(stopRepositoryProvider).getStop(stopId);
});

/// All stops served by a specific route, ordered by stop sequence.
///
/// Performs a SQL JOIN across trips, stop_times, and stops tables to
/// find all stops on the given route. Returns distinct stops to avoid
/// duplicates from multiple trips on the same route.
final stopsForRouteProvider =
    FutureProvider.family<List<BusStop>, String>((ref, routeId) async {
  return ref.read(stopRepositoryProvider).getStopsForRoute(routeId);
});

/// Stop search results for a given query string.
///
/// Matches stops where the name contains the query or the stop code
/// exactly matches (for numeric lookups like "51234").
/// Limited to 20 results for performance.
final stopSearchProvider =
    FutureProvider.family<List<BusStop>, String>((ref, query) async {
  if (query.isEmpty) return [];
  return ref.read(stopRepositoryProvider).searchStops(query);
});

import 'package:bussin/core/errors/exceptions.dart';
import 'package:bussin/data/datasources/translink_api_service.dart';
import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/models/trip_update.dart';
import 'package:flutter/foundation.dart';

// Generated protobuf file import
import 'package:bussin/data/models/gtfs_realtime.pb.dart';

/// Repository that fetches trip updates (ETAs and delays) from the
/// TransLink GTFS-RT V3 API, parses the protobuf response, and maps
/// it to domain models.
///
/// Trip updates contain per-stop arrival/departure predictions with
/// delay information, enabling real-time ETA displays.
class TripUpdateRepository {
  /// The API service used to fetch raw protobuf bytes from TransLink.
  final TranslinkApiService _apiService;

  /// The database service used to resolve stop IDs from trip + stop_sequence.
  final LocalDatabaseService _dbService;

  /// In-memory cache of the last successful trip update list.
  List<TripUpdateModel>? _cachedUpdates;

  TripUpdateRepository({
    required TranslinkApiService apiService,
    required LocalDatabaseService dbService,
  })  : _apiService = apiService,
        _dbService = dbService;

  /// Fetches all current trip updates from the GTFS-RT trip updates feed.
  ///
  /// Parses the binary protobuf response, iterates entities with trip update
  /// data, and maps each to a [TripUpdateModel] with its list of
  /// [StopTimeUpdateModel] entries.
  ///
  /// Caches successful results for fallback on subsequent failures.
  Future<List<TripUpdateModel>> getTripUpdates() async {
    try {
      // Fetch raw protobuf bytes from the TransLink API
      final bytes = await _apiService.fetchTripUpdates();

      // Parse the protobuf binary into a FeedMessage
      final feed = FeedMessage.fromBuffer(bytes);

      debugPrint('[TripUpdate] Parsed ${feed.entity.length} entities from GTFS-RT feed');

      final updates = <TripUpdateModel>[];
      int totalResolutions = 0;
      int successfulResolutions = 0;
      int emptyStopIds = 0;
      int totalStopTimeUpdates = 0;

      // Iterate over each entity in the feed and extract trip update data.
      for (final entity in feed.entity) {
        if (entity.hasTripUpdate()) {
          final tu = entity.tripUpdate;

          // Map each StopTimeUpdate to our domain model.
          // TransLink's GTFS-RT feed often omits stop_id, providing only
          // stop_sequence. We resolve missing stop_ids by querying the
          // gtfs_stop_times table using trip_id + stop_sequence.
          final stopTimeUpdates = <StopTimeUpdateModel>[];

          for (final stu in tu.stopTimeUpdate) {
            totalStopTimeUpdates++;
            
            // Resolve stop_id if missing (empty string means not provided)
            String stopId = stu.stopId;

            if (stopId.isEmpty) {
              emptyStopIds++;
              
              // Log first few empty cases for diagnosis
              if (emptyStopIds <= 3) {
                debugPrint('[TripUpdate] Empty stopId for trip=${tu.trip.tripId}, seq=${stu.stopSequence}, hasSeq=${stu.hasStopSequence()}');
              }
              
              if (stu.hasStopSequence()) {
                totalResolutions++;
                
                // Look up stop_id from gtfs_stop_times using trip_id + stop_sequence
                final resolved = await _dbService.getStopIdForTripSequence(
                  tu.trip.tripId,
                  stu.stopSequence,
                );
                
                if (resolved != null && resolved.isNotEmpty) {
                  successfulResolutions++;
                  stopId = resolved;
                } else {
                  stopId = '';
                }
              }
            }

            stopTimeUpdates.add(
              StopTimeUpdateModel(
                stopId: stopId,
                stopSequence: stu.stopSequence,
                predictedArrival: stu.hasArrival() && stu.arrival.hasTime()
                    ? DateTime.fromMillisecondsSinceEpoch(
                        stu.arrival.time.toInt() * 1000,
                      )
                    : null,
                predictedDeparture: stu.hasDeparture() && stu.departure.hasTime()
                    ? DateTime.fromMillisecondsSinceEpoch(
                        stu.departure.time.toInt() * 1000,
                      )
                    : null,
                arrivalDelay: stu.hasArrival() && stu.arrival.hasDelay()
                    ? stu.arrival.delay
                    : null,
                departureDelay: stu.hasDeparture() && stu.departure.hasDelay()
                    ? stu.departure.delay
                    : null,
              ),
            );
          }

          updates.add(
            TripUpdateModel(
              tripId: tu.trip.tripId,
              routeId: tu.trip.routeId,
              stopTimeUpdates: stopTimeUpdates,
              timestamp: tu.hasTimestamp()
                  ? DateTime.fromMillisecondsSinceEpoch(
                      tu.timestamp.toInt() * 1000,
                    )
                  : null,
              delay: stopTimeUpdates.isNotEmpty
                  ? stopTimeUpdates.first.arrivalDelay
                  : null,
            ),
          );
        }
      }

      debugPrint('[TripUpdate] Summary: ${updates.length} trips, $totalStopTimeUpdates total stops, $emptyStopIds empty stopIds');
      debugPrint('[TripUpdate] Resolutions: $totalResolutions attempted, $successfulResolutions successful');
      
      if (updates.isNotEmpty) {
        final firstUpdate = updates.first;
        debugPrint('[TripUpdate] Sample trip: ${firstUpdate.tripId}, routeId=${firstUpdate.routeId}, ${firstUpdate.stopTimeUpdates.length} stops');
        if (firstUpdate.stopTimeUpdates.isNotEmpty) {
          final firstStop = firstUpdate.stopTimeUpdates.first;
          debugPrint('[TripUpdate] Sample stop: stopId="${firstStop.stopId}", seq=${firstStop.stopSequence}');
        }
      }

      _cachedUpdates = updates;
      return updates;
    } on ServerException {
      if (_cachedUpdates != null) {
        return _cachedUpdates!;
      }
      rethrow;
    }
  }

  /// Collects all ETAs for a specific stop across all active trip updates.
  ///
  /// Iterates through all trip updates and finds [StopTimeUpdateModel]
  /// entries that match the given [stopId], then sorts them by predicted
  /// arrival time in ascending order.
  Future<List<StopTimeUpdateModel>> getEtasForStop(String stopId) async {
    final allUpdates = await getTripUpdates();
    final etas = <StopTimeUpdateModel>[];

    for (final update in allUpdates) {
      for (final stopTime in update.stopTimeUpdates) {
        if (stopTime.stopId == stopId) {
          etas.add(stopTime);
        }
      }
    }

    // Sort by predicted arrival time (earliest first)
    etas.sort((a, b) {
      final aTime = a.predictedArrival;
      final bTime = b.predictedArrival;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return aTime.compareTo(bTime);
    });

    return etas;
  }

  /// Finds the trip update for a specific trip ID.
  ///
  /// Returns null if no update exists for the given trip (e.g., the trip
  /// has completed or hasn't started yet).
  Future<TripUpdateModel?> getTripUpdate(String tripId) async {
    final allUpdates = await getTripUpdates();
    try {
      return allUpdates.firstWhere((update) => update.tripId == tripId);
    } catch (_) {
      return null;
    }
  }
}

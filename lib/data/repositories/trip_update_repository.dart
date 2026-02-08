import 'dart:developer' as developer;
import 'package:bussin/core/errors/exceptions.dart';
import 'package:bussin/data/datasources/translink_api_service.dart';
import 'package:bussin/data/models/trip_update.dart';

// Note: The generated protobuf file will be imported once protoc has been run.
// import 'package:bussin/data/models/gtfs_realtime.pb.dart';

/// Repository that fetches trip updates (ETAs and delays) from the
/// TransLink GTFS-RT V3 API, parses the protobuf response, and maps
/// it to domain models.
///
/// Trip updates contain per-stop arrival/departure predictions with
/// delay information, enabling real-time ETA displays.
class TripUpdateRepository {
  /// The API service used to fetch raw protobuf bytes from TransLink.
  final TranslinkApiService _apiService;

  /// In-memory cache of the last successful trip update list.
  List<TripUpdateModel>? _cachedUpdates;

  TripUpdateRepository({required TranslinkApiService apiService})
      : _apiService = apiService;

  /// Fetches all current trip updates from the GTFS-RT trip updates feed.
  ///
  /// Parses the binary protobuf response, iterates entities with trip update
  /// data, and maps each to a [TripUpdateModel] with its list of
  /// [StopTimeUpdateModel] entries.
  ///
  /// Caches successful results for fallback on subsequent failures.
  Future<List<TripUpdateModel>> getTripUpdates() async {
    final stopwatch = Stopwatch()..start();
    developer.log('⏰ Fetching trip updates / ETAs', name: 'TripUpdateRepository');

    try {
      // Fetch raw protobuf bytes from the TransLink API
      final bytes = await _apiService.fetchTripUpdates();
      developer.log('📦 Received ${bytes.length} bytes of trip update data', name: 'TripUpdateRepository');

      // Parse the protobuf binary into a FeedMessage
      // final feed = FeedMessage.fromBuffer(bytes);
      // TODO: Uncomment once protobuf classes are generated.

      final updates = <TripUpdateModel>[];

      // Iterate over each entity in the feed and extract trip update data.
      //
      // for (final entity in feed.entity) {
      //   if (entity.hasTripUpdate()) {
      //     final tu = entity.tripUpdate;
      //
      //     // Map each StopTimeUpdate to our domain model
      //     final stopTimeUpdates = tu.stopTimeUpdate.map((stu) {
      //       return StopTimeUpdateModel(
      //         stopId: stu.stopId,
      //         stopSequence: stu.stopSequence,
      //         predictedArrival: stu.hasArrival() && stu.arrival.hasTime()
      //             ? DateTime.fromMillisecondsSinceEpoch(
      //                 stu.arrival.time.toInt() * 1000,
      //               )
      //             : null,
      //         predictedDeparture: stu.hasDeparture() && stu.departure.hasTime()
      //             ? DateTime.fromMillisecondsSinceEpoch(
      //                 stu.departure.time.toInt() * 1000,
      //               )
      //             : null,
      //         arrivalDelay: stu.hasArrival() && stu.arrival.hasDelay()
      //             ? stu.arrival.delay
      //             : null,
      //         departureDelay: stu.hasDeparture() && stu.departure.hasDelay()
      //             ? stu.departure.delay
      //             : null,
      //       );
      //     }).toList();
      //
      //     updates.add(
      //       TripUpdateModel(
      //         tripId: tu.trip.tripId,
      //         routeId: tu.trip.routeId,
      //         stopTimeUpdates: stopTimeUpdates,
      //         timestamp: tu.hasTimestamp()
      //             ? DateTime.fromMillisecondsSinceEpoch(
      //                 tu.timestamp.toInt() * 1000,
      //               )
      //             : null,
      //         delay: stopTimeUpdates.isNotEmpty
      //             ? stopTimeUpdates.first.arrivalDelay
      //             : null,
      //       ),
      //     );
      //   }
      // }

      _cachedUpdates = updates;
      stopwatch.stop();
      developer.log(
        '✅ Fetched ${updates.length} trip updates (${stopwatch.elapsedMilliseconds}ms)',
        name: 'TripUpdateRepository',
      );
      return updates;
    } on ServerException catch (e) {
      stopwatch.stop();
      if (_cachedUpdates != null) {
        developer.log(
          '⚠️ Trip update fetch failed - using cached data (${_cachedUpdates!.length} updates) (${stopwatch.elapsedMilliseconds}ms)',
          name: 'TripUpdateRepository',
          error: e,
        );
        return _cachedUpdates!;
      }
      developer.log(
        '❌ Trip update fetch failed - no cached data available (${stopwatch.elapsedMilliseconds}ms)',
        name: 'TripUpdateRepository',
        error: e,
      );
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

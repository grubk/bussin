import 'dart:developer' as developer;
import 'package:bussin/core/errors/exceptions.dart';
import 'package:bussin/data/datasources/translink_api_service.dart';
import 'package:bussin/data/models/vehicle_position.dart';

// Note: The generated protobuf file will be imported once protoc has been run.
// For now we reference the expected class names from gtfs_realtime.pb.dart.
// import 'package:bussin/data/models/gtfs_realtime.pb.dart';

/// Repository that fetches vehicle positions from the TransLink GTFS-RT V3 API,
/// parses the protobuf response, and maps it to domain models.
///
/// Implements an in-memory cache so that if a fetch fails, the last known
/// good data is returned instead of an error (stale data is better than
/// no data for real-time tracking).
class VehicleRepository {
  /// The API service used to fetch raw protobuf bytes from TransLink.
  final TranslinkApiService _apiService;

  /// In-memory cache of the last successful vehicle position list.
  /// Returned as a fallback when a subsequent fetch fails.
  List<VehiclePositionModel>? _cachedPositions;

  VehicleRepository({required TranslinkApiService apiService})
      : _apiService = apiService;

  /// Fetches all current vehicle positions from the GTFS-RT vehicle positions feed.
  ///
  /// Parses the binary protobuf response using [FeedMessage.fromBuffer()],
  /// iterates over each [FeedEntity] that has a vehicle field, and maps
  /// the protobuf data to [VehiclePositionModel] instances.
  ///
  /// On success, updates the in-memory cache.
  /// On failure, returns the cached result if available; otherwise rethrows.
  Future<List<VehiclePositionModel>> getVehiclePositions() async {
    final stopwatch = Stopwatch()..start();
    developer.log('🚌 Fetching vehicle positions', name: 'VehicleRepository');

    try {
      // Fetch raw protobuf bytes from the TransLink API
      final bytes = await _apiService.fetchVehiclePositions();
      developer.log('📦 Received ${bytes.length} bytes of vehicle position data', name: 'VehicleRepository');

      // Parse the protobuf binary into a FeedMessage
      // final feed = FeedMessage.fromBuffer(bytes);
      // TODO: Uncomment the above line once protobuf classes are generated.
      // For now, we provide the mapping logic as comments.

      final positions = <VehiclePositionModel>[];

      // Iterate over each entity in the feed and extract vehicle data.
      // Each FeedEntity may contain a vehicle position, trip update, or alert.
      // We only process entities that have vehicle position data.
      //
      // for (final entity in feed.entity) {
      //   if (entity.hasVehicle()) {
      //     final v = entity.vehicle;
      //     positions.add(
      //       VehiclePositionModel(
      //         vehicleId: v.vehicle.id,
      //         tripId: v.trip.tripId,
      //         routeId: v.trip.routeId,
      //         latitude: v.position.latitude,
      //         longitude: v.position.longitude,
      //         bearing: v.position.hasBearing() ? v.position.bearing : null,
      //         speed: v.position.hasSpeed() ? v.position.speed : null,
      //         timestamp: DateTime.fromMillisecondsSinceEpoch(
      //           v.timestamp.toInt() * 1000,
      //         ),
      //         vehicleLabel: v.vehicle.hasLabel() ? v.vehicle.label : null,
      //         currentStopSequence: v.hasCurrentStopSequence()
      //             ? v.currentStopSequence
      //             : null,
      //       ),
      //     );
      //   }
      // }

      // Update the in-memory cache with the latest successful result
      _cachedPositions = positions;
      stopwatch.stop();
      developer.log(
        '✅ Fetched ${positions.length} vehicle positions (${stopwatch.elapsedMilliseconds}ms)',
        name: 'VehicleRepository',
      );
      return positions;
    } on ServerException catch (e) {
      stopwatch.stop();
      // On server/network errors, return cached data if available
      if (_cachedPositions != null) {
        developer.log(
          '⚠️ Vehicle position fetch failed - using cached data (${_cachedPositions!.length} vehicles) (${stopwatch.elapsedMilliseconds}ms)',
          name: 'VehicleRepository',
          error: e,
        );
        return _cachedPositions!;
      }
      developer.log(
        '❌ Vehicle position fetch failed - no cached data available (${stopwatch.elapsedMilliseconds}ms)',
        name: 'VehicleRepository',
        error: e,
      );
      rethrow;
    }
  }

  /// Fetches vehicle positions filtered to a specific route.
  ///
  /// Calls [getVehiclePositions] then filters the result list by [routeId].
  /// Useful for showing only buses on a selected route.
  Future<List<VehiclePositionModel>> getVehiclesForRoute(
    String routeId,
  ) async {
    final allPositions = await getVehiclePositions();
    return allPositions
        .where((vehicle) => vehicle.routeId == routeId)
        .toList();
  }
}

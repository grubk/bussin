import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:bussin/core/constants/map_constants.dart';
import 'package:bussin/core/utils/distance_utils.dart';
import 'package:bussin/data/models/bus_stop.dart';
import 'package:bussin/providers/location_provider.dart';
import 'package:bussin/providers/stop_providers.dart';

/// ---------------------------------------------------------------------------
/// Nearby Stops Provider
/// ---------------------------------------------------------------------------
/// Derives from [currentLocationProvider] and [allStopsProvider] to compute
/// a list of transit stops within the configured radius (500m) of the
/// user's current GPS position, sorted by distance ascending.
///
/// Recalculates only when the user's position changes significantly
/// (controlled by the geolocator's 10m distance filter upstream).
/// ---------------------------------------------------------------------------

/// A stop paired with its distance from the user in meters.
///
/// Used by the nearby stops sheet to display stop name + distance label.
typedef NearbyStop = (BusStop stop, double distanceMeters);

/// Stops within [MapConstants.nearbyRadiusMeters] (500m) of the user.
///
/// Combines the user's live GPS position with the full stop list,
/// calculates Haversine distance for each stop, filters by radius,
/// and sorts by distance ascending.
///
/// Returns [AsyncValue<List<NearbyStop>>] so the UI can handle
/// loading/error states (e.g., location unavailable, stops not loaded).
///
/// Auto-disposes when no widget is watching, releasing the GPS stream.
final nearbyStopsProvider =
    Provider.autoDispose<AsyncValue<List<NearbyStop>>>((ref) {
  // Watch both the live GPS position and the cached stop list
  final locationAsync = ref.watch(currentLocationProvider);
  final stopsAsync = ref.watch(allStopsProvider);

  // Both must have data before we can compute nearby stops
  if (locationAsync is AsyncLoading || stopsAsync is AsyncLoading) {
    return const AsyncLoading();
  }

  if (locationAsync is AsyncError) {
    return AsyncError(
      locationAsync.error!,
      locationAsync.stackTrace!,
    );
  }

  if (stopsAsync is AsyncError) {
    return AsyncError(
      stopsAsync.error!,
      stopsAsync.stackTrace!,
    );
  }

  // In Riverpod 3.x, .valueOrNull was renamed to .value (now nullable)
  final position = locationAsync.value;
  final allStops = stopsAsync.value;

  if (position == null || allStops == null) {
    return const AsyncLoading();
  }

  // Convert Position to LatLng for distance calculations
  final userLocation = LatLng(position.latitude, position.longitude);

  // Filter stops within the nearby radius using Haversine distance
  final nearbyStops = <NearbyStop>[];

  for (final stop in allStops) {
    final stopLocation = LatLng(stop.stopLat, stop.stopLon);
    // Use DistanceUtils static method for Haversine calculation
    final distance = DistanceUtils.haversineDistance(userLocation, stopLocation);

    if (distance <= MapConstants.nearbyRadiusMeters) {
      nearbyStops.add((stop, distance));
    }
  }

  // Sort by distance ascending (closest stops first)
  nearbyStops.sort((a, b) => a.$2.compareTo(b.$2));

  return AsyncData(nearbyStops);
});

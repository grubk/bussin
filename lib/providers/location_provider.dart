import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bussin/data/datasources/location_service.dart';

/// ---------------------------------------------------------------------------
/// Location Providers
/// ---------------------------------------------------------------------------
/// These providers expose the user's GPS location as a continuous stream
/// and handle location permission requests. The position stream uses a
/// 10-meter distance filter to conserve battery while still providing
/// smooth location updates for the map's blue dot marker.
/// ---------------------------------------------------------------------------

/// Singleton instance of [LocationService].
///
/// Wraps the geolocator package for permission handling, one-shot
/// position fixes, and continuous GPS streaming.
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Continuous stream of GPS position updates.
///
/// Emits a new [Position] whenever the device moves at least 10 meters.
/// The distance filter is set by the [LocationService.getPositionStream]
/// method, which uses [LocationSettings] with a 10m distance filter.
///
/// Before starting the stream, checks and requests location permission.
/// If permission is denied, the stream will emit an error.
///
/// Auto-disposes when no widget is watching, stopping GPS tracking
/// and conserving battery.
final currentLocationProvider =
    StreamProvider.autoDispose<Position>((ref) async* {
  final locationService = ref.read(locationServiceProvider);

  // Ensure we have location permission before starting the stream
  await locationService.checkAndRequestPermission();

  // Yield positions from the continuous GPS stream
  await for (final position in locationService.getPositionStream()) {
    yield position;
  }
});

/// Checks and requests location permission on first access.
///
/// Returns true if permission is granted (either "when in use" or "always").
/// Used by the UI to determine whether to show location-dependent features
/// or a prompt to enable GPS.
///
/// This is a one-shot check; for continuous permission monitoring,
/// watch [currentLocationProvider] which will error on denied permission.
final locationPermissionProvider = FutureProvider<bool>((ref) async {
  final locationService = ref.read(locationServiceProvider);
  return locationService.checkAndRequestPermission();
});

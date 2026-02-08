import 'package:geolocator/geolocator.dart';
import 'package:bussin/core/errors/exceptions.dart';

/// Wrapper around the geolocator package for GPS location access.
///
/// Handles permission requests, one-shot position fixes, and continuous
/// location streaming with a distance filter for battery efficiency.
class LocationService {
  /// Checks and requests location permission from the user.
  ///
  /// Returns true if permission is granted (either "when in use" or "always").
  /// Throws [LocationException] if permission is permanently denied.
  Future<bool> checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
        message: 'Location services are disabled. Please enable GPS.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission from the user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException(
          message: 'Location permission was denied.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        message: 'Location permission is permanently denied. '
            'Please enable it in device Settings.',
      );
    }

    return true;
  }

  /// Gets a one-shot GPS position fix with high accuracy.
  ///
  /// Times out after 30 seconds if no fix is obtained.
  /// Throws [LocationException] on failure.
  Future<Position> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );
    } catch (e) {
      throw LocationException(message: 'Failed to get position: $e');
    }
  }

  /// Returns a continuous stream of GPS position updates.
  ///
  /// [distanceFilter] controls the minimum distance in meters the device
  /// must move before a new position is emitted (default: 10m).
  /// This filter conserves battery by avoiding excessive updates.
  Stream<Position> getPositionStream({int distanceFilter = 10}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      ),
    );
  }

  /// Checks if GPS location services are enabled at the system level.
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }
}

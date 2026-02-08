import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:bussin/data/models/bus_stop.dart';

/// Geographic distance calculation utilities using the Haversine formula.
/// Used for finding nearby stops and displaying distance to user.
class DistanceUtils {
  DistanceUtils._();

  /// Earth's radius in meters for Haversine calculation.
  static const double _earthRadiusM = 6371000.0;

  /// Calculates the great-circle distance between two coordinates using Haversine.
  ///
  /// Returns the distance in meters between [a] and [b].
  /// This formula accounts for Earth's curvature and is accurate for short distances.
  static double haversineDistance(LatLng a, LatLng b) {
    final dLat = _toRadians(b.latitude - a.latitude);
    final dLon = _toRadians(b.longitude - a.longitude);

    final sinDLat = sin(dLat / 2);
    final sinDLon = sin(dLon / 2);

    final h = sinDLat * sinDLat +
        cos(_toRadians(a.latitude)) *
            cos(_toRadians(b.latitude)) *
            sinDLon *
            sinDLon;

    return 2 * _earthRadiusM * asin(sqrt(h));
  }

  /// Filters a list of bus stops to only those within [radiusM] meters of [center].
  ///
  /// Uses Haversine distance for accurate geographic filtering.
  static List<BusStop> stopsWithinRadius(
    LatLng center,
    double radiusM,
    List<BusStop> stops,
  ) {
    return stops.where((stop) {
      final stopLocation = LatLng(stop.stopLat, stop.stopLon);
      return haversineDistance(center, stopLocation) <= radiusM;
    }).toList();
  }

  /// Formats a distance in meters to a human-readable string.
  ///
  /// Returns "150m" for distances under 1000m, or "1.2km" for larger distances.
  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()}m';
    }
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  /// Converts degrees to radians for trigonometric calculations.
  static double _toRadians(double degrees) => degrees * pi / 180;
}

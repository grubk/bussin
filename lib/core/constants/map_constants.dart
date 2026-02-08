import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';

/// Map display constants centered on Vancouver, BC.
/// Uses OpenStreetMap tiles which require no API key.
class MapConstants {
  MapConstants._();

  /// Geographic center of Vancouver, BC for initial map position.
  static final LatLng vancouverCenter = LatLng(49.2827, -123.1207);

  /// Default zoom level showing the Greater Vancouver area.
  static const double defaultZoom = 13.0;

  /// Minimum zoom level (prevents zooming out too far).
  static const double minZoom = 10.0;

  /// Maximum zoom level (street-level detail).
  static const double maxZoom = 18.0;

  /// OpenStreetMap tile server URL template.
  static const String tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  /// User agent package name for OSM tile policy compliance.
  static const String userAgentPackage = 'com.bussin.app';

  /// Radius in meters for detecting nearby transit stops.
  static const double nearbyRadiusMeters = 500.0;

  /// Padding applied when fitting map bounds to a route shape.
  static const EdgeInsets fitBoundsPadding = EdgeInsets.all(50.0);
}

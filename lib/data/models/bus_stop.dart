import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_stop.freezed.dart';
part 'bus_stop.g.dart';

/// A transit stop from the GTFS static data (stops.txt).
///
/// Represents a physical stop location in the TransLink network.
/// Includes geographic coordinates for map marker placement.
@freezed
abstract class BusStop with _$BusStop {
  const factory BusStop({
    /// Unique stop identifier from GTFS.
    required String stopId,

    /// Human-readable stop name (e.g., "UBC Exchange Bay 7").
    required String stopName,

    /// Latitude coordinate of the stop.
    required double stopLat,

    /// Longitude coordinate of the stop.
    required double stopLon,

    /// 5-digit stop number used by riders (displayed on stop signs).
    String? stopCode,

    /// Parent station ID for stops grouped within a station complex.
    String? parentStation,
  }) = _BusStop;

  factory BusStop.fromJson(Map<String, dynamic> json) =>
      _$BusStopFromJson(json);
}

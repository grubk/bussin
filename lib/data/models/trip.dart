import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

/// A scheduled trip from GTFS static data (trips.txt).
///
/// Links a route to a shape and direction. Each trip represents one
/// complete run of a vehicle along a route on a specific service day.
@freezed
abstract class TripModel with _$TripModel {
  const factory TripModel({
    /// Unique trip identifier.
    required String tripId,

    /// Route ID this trip belongs to.
    required String routeId,

    /// Service ID determining which days this trip runs.
    required String serviceId,

    /// Destination display text (e.g., "UBC", "Metrotown").
    String? tripHeadsign,

    /// Travel direction: 0 = outbound, 1 = inbound.
    int? directionId,

    /// Shape ID linking to the geographic path for polyline rendering.
    String? shapeId,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}

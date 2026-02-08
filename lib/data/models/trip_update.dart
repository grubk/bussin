import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_update.freezed.dart';
part 'trip_update.g.dart';

/// Domain model for trip-level delay and ETA information.
///
/// Contains per-stop arrival predictions from the GTFS-RT trip updates feed.
/// Each trip update corresponds to one active vehicle on a specific trip.
@freezed
abstract class TripUpdateModel with _$TripUpdateModel {
  const factory TripUpdateModel({
    /// Trip ID this update corresponds to.
    required String tripId,

    /// Route ID for this trip.
    required String routeId,

    /// List of predicted stop times along the trip.
    required List<StopTimeUpdateModel> stopTimeUpdates,

    /// Timestamp when this prediction was generated.
    DateTime? timestamp,

    /// Overall trip delay in seconds (positive = late, negative = early).
    int? delay,
  }) = _TripUpdateModel;

  factory TripUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$TripUpdateModelFromJson(json);
}

/// Predicted arrival/departure time at a specific stop within a trip.
///
/// Combines the scheduled time with real-time delay predictions
/// from the GTFS-RT trip updates feed.
@freezed
abstract class StopTimeUpdateModel with _$StopTimeUpdateModel {
  const factory StopTimeUpdateModel({
    /// Stop ID where this prediction applies.
    required String stopId,

    /// Sequential position of this stop within the trip.
    required int stopSequence,

    /// Predicted arrival time at this stop (from GTFS-RT StopTimeEvent.time).
    DateTime? predictedArrival,

    /// Predicted departure time from this stop.
    DateTime? predictedDeparture,

    /// Arrival delay in seconds (positive = late, negative = early).
    int? arrivalDelay,

    /// Departure delay in seconds.
    int? departureDelay,
  }) = _StopTimeUpdateModel;

  factory StopTimeUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$StopTimeUpdateModelFromJson(json);
}

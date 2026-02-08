import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_time.freezed.dart';
part 'stop_time.g.dart';

/// Scheduled arrival/departure time at a stop for a specific trip (stop_times.txt).
///
/// Times use "HH:MM:SS" format and can exceed 24:00:00 for overnight trips
/// (e.g., "25:30:00" means 1:30 AM the next day).
@freezed
abstract class StopTimeModel with _$StopTimeModel {
  const factory StopTimeModel({
    /// Trip ID this stop time belongs to.
    required String tripId,

    /// Stop ID where this scheduled time applies.
    required String stopId,

    /// Scheduled arrival time in "HH:MM:SS" format.
    required String arrivalTime,

    /// Scheduled departure time in "HH:MM:SS" format.
    required String departureTime,

    /// Sequential position of this stop within the trip.
    required int stopSequence,
  }) = _StopTimeModel;

  factory StopTimeModel.fromJson(Map<String, dynamic> json) =>
      _$StopTimeModelFromJson(json);
}

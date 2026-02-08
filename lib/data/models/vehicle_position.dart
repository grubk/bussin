import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_position.freezed.dart';
part 'vehicle_position.g.dart';

/// Domain model representing a transit vehicle's real-time position.
///
/// Created by mapping protobuf FeedEntity.vehicle data from the
/// TransLink GTFS-RT V3 vehicle positions endpoint.
@freezed
abstract class VehiclePositionModel with _$VehiclePositionModel {
  const factory VehiclePositionModel({
    /// Unique identifier for this vehicle (from protobuf vehicle.id).
    required String vehicleId,

    /// Trip ID this vehicle is currently serving.
    required String tripId,

    /// Route ID this vehicle is currently operating on.
    required String routeId,

    /// Current latitude coordinate of the vehicle.
    required double latitude,

    /// Current longitude coordinate of the vehicle.
    required double longitude,

    /// Heading direction in degrees (0-360, 0=North, 90=East).
    /// Null if not reported by the vehicle.
    double? bearing,

    /// Current speed in meters per second.
    /// Null if not reported by the vehicle.
    double? speed,

    /// Timestamp when this position was last reported by the vehicle.
    required DateTime timestamp,

    /// Stop ID the vehicle is currently at or approaching.
    String? currentStopId,

    /// Position in the trip's stop sequence (1-based index).
    int? currentStopSequence,

    /// Human-readable vehicle label (e.g., bus number displayed on the bus).
    String? vehicleLabel,
  }) = _VehiclePositionModel;

  /// Creates a VehiclePositionModel from a JSON map.
  factory VehiclePositionModel.fromJson(Map<String, dynamic> json) =>
      _$VehiclePositionModelFromJson(json);
}

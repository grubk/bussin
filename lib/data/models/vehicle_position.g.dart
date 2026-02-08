// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehiclePositionModel _$VehiclePositionModelFromJson(
  Map<String, dynamic> json,
) => _VehiclePositionModel(
  vehicleId: json['vehicleId'] as String,
  tripId: json['tripId'] as String,
  routeId: json['routeId'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  bearing: (json['bearing'] as num?)?.toDouble(),
  speed: (json['speed'] as num?)?.toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  currentStopId: json['currentStopId'] as String?,
  currentStopSequence: (json['currentStopSequence'] as num?)?.toInt(),
  vehicleLabel: json['vehicleLabel'] as String?,
);

Map<String, dynamic> _$VehiclePositionModelToJson(
  _VehiclePositionModel instance,
) => <String, dynamic>{
  'vehicleId': instance.vehicleId,
  'tripId': instance.tripId,
  'routeId': instance.routeId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'bearing': instance.bearing,
  'speed': instance.speed,
  'timestamp': instance.timestamp.toIso8601String(),
  'currentStopId': instance.currentStopId,
  'currentStopSequence': instance.currentStopSequence,
  'vehicleLabel': instance.vehicleLabel,
};

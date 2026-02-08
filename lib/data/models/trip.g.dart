// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripModel _$TripModelFromJson(Map<String, dynamic> json) => _TripModel(
  tripId: json['tripId'] as String,
  routeId: json['routeId'] as String,
  serviceId: json['serviceId'] as String,
  tripHeadsign: json['tripHeadsign'] as String?,
  directionId: (json['directionId'] as num?)?.toInt(),
  shapeId: json['shapeId'] as String?,
);

Map<String, dynamic> _$TripModelToJson(_TripModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'routeId': instance.routeId,
      'serviceId': instance.serviceId,
      'tripHeadsign': instance.tripHeadsign,
      'directionId': instance.directionId,
      'shapeId': instance.shapeId,
    };

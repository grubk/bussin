// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripUpdateModel _$TripUpdateModelFromJson(Map<String, dynamic> json) =>
    _TripUpdateModel(
      tripId: json['tripId'] as String,
      routeId: json['routeId'] as String,
      stopTimeUpdates: (json['stopTimeUpdates'] as List<dynamic>)
          .map((e) => StopTimeUpdateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      delay: (json['delay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TripUpdateModelToJson(_TripUpdateModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'routeId': instance.routeId,
      'stopTimeUpdates': instance.stopTimeUpdates,
      'timestamp': instance.timestamp?.toIso8601String(),
      'delay': instance.delay,
    };

_StopTimeUpdateModel _$StopTimeUpdateModelFromJson(Map<String, dynamic> json) =>
    _StopTimeUpdateModel(
      stopId: json['stopId'] as String,
      stopSequence: (json['stopSequence'] as num).toInt(),
      predictedArrival: json['predictedArrival'] == null
          ? null
          : DateTime.parse(json['predictedArrival'] as String),
      predictedDeparture: json['predictedDeparture'] == null
          ? null
          : DateTime.parse(json['predictedDeparture'] as String),
      arrivalDelay: (json['arrivalDelay'] as num?)?.toInt(),
      departureDelay: (json['departureDelay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StopTimeUpdateModelToJson(
  _StopTimeUpdateModel instance,
) => <String, dynamic>{
  'stopId': instance.stopId,
  'stopSequence': instance.stopSequence,
  'predictedArrival': instance.predictedArrival?.toIso8601String(),
  'predictedDeparture': instance.predictedDeparture?.toIso8601String(),
  'arrivalDelay': instance.arrivalDelay,
  'departureDelay': instance.departureDelay,
};

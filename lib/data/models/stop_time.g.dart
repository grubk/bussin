// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StopTimeModel _$StopTimeModelFromJson(Map<String, dynamic> json) =>
    _StopTimeModel(
      tripId: json['tripId'] as String,
      stopId: json['stopId'] as String,
      arrivalTime: json['arrivalTime'] as String,
      departureTime: json['departureTime'] as String,
      stopSequence: (json['stopSequence'] as num).toInt(),
    );

Map<String, dynamic> _$StopTimeModelToJson(_StopTimeModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'stopId': instance.stopId,
      'arrivalTime': instance.arrivalTime,
      'departureTime': instance.departureTime,
      'stopSequence': instance.stopSequence,
    };

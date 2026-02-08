// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusStop _$BusStopFromJson(Map<String, dynamic> json) => _BusStop(
  stopId: json['stopId'] as String,
  stopName: json['stopName'] as String,
  stopLat: (json['stopLat'] as num).toDouble(),
  stopLon: (json['stopLon'] as num).toDouble(),
  stopCode: json['stopCode'] as String?,
  parentStation: json['parentStation'] as String?,
);

Map<String, dynamic> _$BusStopToJson(_BusStop instance) => <String, dynamic>{
  'stopId': instance.stopId,
  'stopName': instance.stopName,
  'stopLat': instance.stopLat,
  'stopLon': instance.stopLon,
  'stopCode': instance.stopCode,
  'parentStation': instance.parentStation,
};

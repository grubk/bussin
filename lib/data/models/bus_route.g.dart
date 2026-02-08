// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusRoute _$BusRouteFromJson(Map<String, dynamic> json) => _BusRoute(
  routeId: json['routeId'] as String,
  routeShortName: json['routeShortName'] as String,
  routeLongName: json['routeLongName'] as String,
  routeType: (json['routeType'] as num).toInt(),
  routeColor: json['routeColor'] as String?,
);

Map<String, dynamic> _$BusRouteToJson(_BusRoute instance) => <String, dynamic>{
  'routeId': instance.routeId,
  'routeShortName': instance.routeShortName,
  'routeLongName': instance.routeLongName,
  'routeType': instance.routeType,
  'routeColor': instance.routeColor,
};

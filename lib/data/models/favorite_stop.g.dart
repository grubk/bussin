// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteStop _$FavoriteStopFromJson(Map<String, dynamic> json) =>
    _FavoriteStop(
      id: (json['id'] as num?)?.toInt(),
      stopId: json['stopId'] as String,
      stopName: json['stopName'] as String,
      stopLat: (json['stopLat'] as num).toDouble(),
      stopLon: (json['stopLon'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FavoriteStopToJson(_FavoriteStop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stopId': instance.stopId,
      'stopName': instance.stopName,
      'stopLat': instance.stopLat,
      'stopLon': instance.stopLon,
      'createdAt': instance.createdAt.toIso8601String(),
    };

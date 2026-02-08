// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShapePoint _$ShapePointFromJson(Map<String, dynamic> json) => _ShapePoint(
  shapeId: json['shapeId'] as String,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
  sequence: (json['sequence'] as num).toInt(),
);

Map<String, dynamic> _$ShapePointToJson(_ShapePoint instance) =>
    <String, dynamic>{
      'shapeId': instance.shapeId,
      'lat': instance.lat,
      'lon': instance.lon,
      'sequence': instance.sequence,
    };

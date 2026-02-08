// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteHistoryEntry _$RouteHistoryEntryFromJson(Map<String, dynamic> json) =>
    _RouteHistoryEntry(
      id: (json['id'] as num?)?.toInt(),
      routeId: json['routeId'] as String,
      routeShortName: json['routeShortName'] as String,
      routeLongName: json['routeLongName'] as String,
      viewedAt: DateTime.parse(json['viewedAt'] as String),
    );

Map<String, dynamic> _$RouteHistoryEntryToJson(_RouteHistoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'routeShortName': instance.routeShortName,
      'routeLongName': instance.routeLongName,
      'viewedAt': instance.viewedAt.toIso8601String(),
    };

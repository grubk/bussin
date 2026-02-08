// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceAlertModel _$ServiceAlertModelFromJson(Map<String, dynamic> json) =>
    _ServiceAlertModel(
      id: json['id'] as String,
      headerText: json['headerText'] as String,
      descriptionText: json['descriptionText'] as String,
      cause: json['cause'] as String,
      effect: json['effect'] as String,
      affectedRouteIds: (json['affectedRouteIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      affectedStopIds: (json['affectedStopIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      activePeriodStart: json['activePeriodStart'] == null
          ? null
          : DateTime.parse(json['activePeriodStart'] as String),
      activePeriodEnd: json['activePeriodEnd'] == null
          ? null
          : DateTime.parse(json['activePeriodEnd'] as String),
    );

Map<String, dynamic> _$ServiceAlertModelToJson(_ServiceAlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'headerText': instance.headerText,
      'descriptionText': instance.descriptionText,
      'cause': instance.cause,
      'effect': instance.effect,
      'affectedRouteIds': instance.affectedRouteIds,
      'affectedStopIds': instance.affectedStopIds,
      'activePeriodStart': instance.activePeriodStart?.toIso8601String(),
      'activePeriodEnd': instance.activePeriodEnd?.toIso8601String(),
    };

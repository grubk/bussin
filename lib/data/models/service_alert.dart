import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_alert.freezed.dart';
part 'service_alert.g.dart';

/// Domain model for a TransLink service disruption or alert.
///
/// Alerts include detours, service reductions, cancellations, and other
/// disruptions parsed from the GTFS-RT service alerts feed.
@freezed
abstract class ServiceAlertModel with _$ServiceAlertModel {
  const factory ServiceAlertModel({
    /// Unique identifier for this alert.
    required String id,

    /// Alert title/header text (extracted from TranslatedString).
    required String headerText,

    /// Full alert description (extracted from TranslatedString).
    required String descriptionText,

    /// Cause of the disruption (e.g., CONSTRUCTION, ACCIDENT, WEATHER).
    required String cause,

    /// Effect on service (e.g., DETOUR, REDUCED_SERVICE, NO_SERVICE).
    required String effect,

    /// List of route IDs affected by this alert.
    List<String>? affectedRouteIds,

    /// List of stop IDs affected by this alert.
    List<String>? affectedStopIds,

    /// Start time of the alert's active period.
    DateTime? activePeriodStart,

    /// End time of the alert's active period.
    DateTime? activePeriodEnd,
  }) = _ServiceAlertModel;

  factory ServiceAlertModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceAlertModelFromJson(json);
}

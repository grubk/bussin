import 'package:bussin/core/errors/exceptions.dart';
import 'package:bussin/data/datasources/translink_api_service.dart';
import 'package:bussin/data/models/service_alert.dart';

// Note: The generated protobuf file will be imported once protoc has been run.
import 'package:bussin/data/models/gtfs_realtime.pb.dart';

/// Repository that fetches service alerts from the TransLink GTFS-RT V3 API,
/// parses the protobuf response, and maps it to domain models.
///
/// Service alerts contain disruption, detour, and cancellation information
/// that affects specific routes or stops.
class AlertRepository {
  /// The API service used to fetch raw protobuf bytes from TransLink.
  final TranslinkApiService _apiService;

  /// In-memory cache of the last successful alert list.
  List<ServiceAlertModel>? _cachedAlerts;

  AlertRepository({required TranslinkApiService apiService})
      : _apiService = apiService;

  /// Fetches all current service alerts from the GTFS-RT alerts feed.
  ///
  /// Parses the binary protobuf response, iterates entities with alert
  /// data, and maps each to a [ServiceAlertModel].
  ///
  /// Alert text fields (header, description) are extracted from protobuf
  /// [TranslatedString] objects, preferring the English translation.
  ///
  /// Caches successful results for fallback on subsequent failures.
  Future<List<ServiceAlertModel>> getServiceAlerts() async {
    try {
      // Fetch raw protobuf bytes from the TransLink API
      final bytes = await _apiService.fetchServiceAlerts();

      // Parse the protobuf binary into a FeedMessage
      final feed = FeedMessage.fromBuffer(bytes);

      final alerts = <ServiceAlertModel>[];

      // Iterate over each entity and extract alert data.
      // Alert text fields are TranslatedString objects containing
      // a list of translations; we prefer the English one.
      
      for (final entity in feed.entity) {
        if (entity.hasAlert()) {
          final a = entity.alert;

          // Extract English text from TranslatedString, falling back to first translation
          final headerText = _extractTranslatedString(a.headerText);
          final descriptionText = _extractTranslatedString(a.descriptionText);

          // Collect affected route IDs and stop IDs from informedEntity list
          final affectedRouteIds = <String>[];
          final affectedStopIds = <String>[];
          for (final informed in a.informedEntity) {
            if (informed.hasRouteId()) {
              affectedRouteIds.add(informed.routeId);
            }
            if (informed.hasStopId()) {
              affectedStopIds.add(informed.stopId);
            }
          }

          // Extract active period timestamps
          DateTime? activePeriodStart;
          DateTime? activePeriodEnd;
          if (a.activePeriod.isNotEmpty) {
            final period = a.activePeriod.first;
            if (period.hasStart()) {
              activePeriodStart = DateTime.fromMillisecondsSinceEpoch(
                period.start.toInt() * 1000,
              );
            }
            if (period.hasEnd()) {
              activePeriodEnd = DateTime.fromMillisecondsSinceEpoch(
                period.end.toInt() * 1000,
              );
            }
          }

          alerts.add(
            ServiceAlertModel(
              id: entity.id,
              headerText: headerText,
              descriptionText: descriptionText,
              cause: a.cause.name,
              effect: a.effect.name,
              affectedRouteIds:
                  affectedRouteIds.isNotEmpty ? affectedRouteIds : null,
              affectedStopIds:
                  affectedStopIds.isNotEmpty ? affectedStopIds : null,
              activePeriodStart: activePeriodStart,
              activePeriodEnd: activePeriodEnd,
            ),
          );
        }
      }

      _cachedAlerts = alerts;
      return alerts;
    } on ServerException {
      if (_cachedAlerts != null) {
        return _cachedAlerts!;
      }
      rethrow;
    }
  }

  /// Filters alerts to only those affecting a specific route.
  ///
  /// Returns alerts where [affectedRouteIds] contains the given [routeId].
  Future<List<ServiceAlertModel>> getAlertsForRoute(String routeId) async {
    final allAlerts = await getServiceAlerts();
    return allAlerts
        .where((alert) =>
            alert.affectedRouteIds != null &&
            alert.affectedRouteIds!.contains(routeId))
        .toList();
  }

  /// Extracts English text from a protobuf TranslatedString.
  ///
  /// Prefers the English translation; falls back to the first available
  /// translation if English is not found.
  String _extractTranslatedString(TranslatedString translatedString) {
    if (translatedString.translation.isEmpty) return '';
    try {
      return translatedString.translation
          .firstWhere((t) => t.language == 'en')
          .text;
    } catch (_) {
      return translatedString.translation.first.text;
    }
  }
}

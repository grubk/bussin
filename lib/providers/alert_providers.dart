import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/core/constants/api_constants.dart';
import 'package:bussin/data/models/service_alert.dart';
import 'package:bussin/data/repositories/alert_repository.dart';
import 'package:bussin/providers/vehicle_providers.dart';

/// ---------------------------------------------------------------------------
/// Service Alert Providers
/// ---------------------------------------------------------------------------
/// These providers expose service alerts (detours, cancellations, disruptions)
/// from TransLink's GTFS-RT V3 alerts endpoint. Polled every 60 seconds.
/// Derived providers filter alerts by route and count active alerts for
/// the badge on the navigation bar.
/// ---------------------------------------------------------------------------

/// Singleton instance of [AlertRepository].
///
/// Reuses the shared [TranslinkApiService] from [translinkApiServiceProvider].
final alertRepositoryProvider = Provider<AlertRepository>((ref) {
  final apiService = ref.watch(translinkApiServiceProvider);
  return AlertRepository(apiService: apiService);
});

/// Stream of all service alerts, polling every 60 seconds.
///
/// Each emission contains the full list of [ServiceAlertModel] from
/// TransLink's GTFS-RT alerts feed. Alerts include disruption type,
/// affected routes/stops, and active time periods.
///
/// Auto-disposes when no widget is watching.
final serviceAlertsProvider =
    StreamProvider.autoDispose<List<ServiceAlertModel>>((ref) async* {
  while (true) {
    yield await ref.read(alertRepositoryProvider).getServiceAlerts();
    await Future.delayed(ApiConstants.alertPollInterval);
  }
});

/// Alerts filtered to a specific route.
///
/// Returns only alerts where [affectedRouteIds] contains the given [routeId].
/// Used on the route detail screen to show relevant disruption info.
final alertsForRouteProvider = Provider.autoDispose
    .family<AsyncValue<List<ServiceAlertModel>>, String>((ref, routeId) {
  final alerts = ref.watch(serviceAlertsProvider);

  return alerts.whenData(
    (allAlerts) => allAlerts
        .where((alert) =>
            alert.affectedRouteIds != null &&
            alert.affectedRouteIds!.contains(routeId))
        .toList(),
  );
});

/// Total count of currently active service alerts.
///
/// Derived from [serviceAlertsProvider]. Used for the badge number
/// displayed on the Alerts navigation icon in the bottom nav bar.
/// Returns 0 while loading or on error.
final activeAlertCountProvider = Provider.autoDispose<int>((ref) {
  final alerts = ref.watch(serviceAlertsProvider);

  return alerts.when(
    data: (alertList) => alertList.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

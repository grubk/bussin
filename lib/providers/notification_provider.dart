import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/data/datasources/notification_service.dart';
import 'package:bussin/providers/trip_update_providers.dart';

/// ---------------------------------------------------------------------------
/// Notification Providers
/// ---------------------------------------------------------------------------
/// These providers manage bus arrival alert notifications. Users can set
/// alerts for specific route+stop combinations with a threshold (e.g.,
/// "notify me when route 49 is 5 minutes from UBC Exchange").
///
/// The alert check logic runs on each trip update poll cycle (every 30s).
/// When an alert's ETA meets the threshold, a local notification fires
/// and the alert is auto-removed.
/// ---------------------------------------------------------------------------

/// Singleton instance of [NotificationService].
///
/// Handles platform-specific notification initialization and display.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// A user-configured bus arrival alert.
///
/// Represents a request to be notified when a specific bus route
/// is within [thresholdMinutes] of arriving at [stopId].
class BusAlert {
  /// Route ID to monitor for arrival.
  final String routeId;

  /// Stop ID where the alert should trigger.
  final String stopId;

  /// Human-readable stop name for the notification text.
  final String stopName;

  /// Number of minutes before arrival to trigger the notification.
  /// E.g., 5 means "notify me when the bus is 5 minutes away".
  final int thresholdMinutes;

  const BusAlert({
    required this.routeId,
    required this.stopId,
    required this.stopName,
    required this.thresholdMinutes,
  });
}

/// Manages active bus alerts and checks them against live trip updates.
///
/// Uses [Notifier] to hold the list of active [BusAlert] instances.
/// Each alert is checked against the trip update data on mutation;
/// widgets or periodic timers should call [checkAlerts] to trigger
/// the ETA comparison logic.
///
/// When an alert's predicted arrival time minus current time is less than
/// or equal to the threshold, a local notification fires and the alert
/// is automatically removed from the list.
final busAlertSettingsProvider =
    NotifierProvider<BusAlertNotifier, List<BusAlert>>(
  BusAlertNotifier.new,
);

/// Notifier that manages bus arrival alerts and fires notifications.
class BusAlertNotifier extends Notifier<List<BusAlert>> {
  @override
  List<BusAlert> build() {
    // Start with an empty alert list
    return [];
  }

  /// Registers a new bus arrival alert.
  ///
  /// The alert will be checked against live trip update data on each
  /// poll cycle. When the ETA meets the threshold, a notification fires.
  void addAlert(BusAlert alert) {
    state = [...state, alert];
  }

  /// Removes a specific alert by route ID and stop ID combination.
  ///
  /// Used when the user manually cancels an alert or when an alert
  /// has fired and should be auto-removed.
  void removeAlert(String routeId, String stopId) {
    state = state
        .where((a) => !(a.routeId == routeId && a.stopId == stopId))
        .toList();
  }

  /// Checks all active alerts against the current trip update data.
  ///
  /// For each active alert:
  ///   1. Gets ETAs for the alert's stop from [tripUpdatesProvider]
  ///   2. Finds ETAs matching the alert's route ID
  ///   3. If predicted arrival minus now <= threshold minutes:
  ///      - Fires a local notification via [NotificationService]
  ///      - Auto-removes the alert from the list
  ///
  /// This method should be called periodically (e.g., on each trip
  /// update poll cycle, every 30 seconds).
  Future<void> checkAlerts() async {
    final tripUpdates = ref.read(tripUpdatesProvider);
    final notificationService = ref.read(notificationServiceProvider);

    // Only check alerts when trip update data is available
    // In Riverpod 3.x, .valueOrNull was renamed to .value (now nullable)
    final updatesData = tripUpdates.value;
    if (updatesData == null) return;

    // Track alerts that should be removed after firing
    final alertsToRemove = <BusAlert>[];

    for (final alert in state) {
      // Find all stop time updates matching this alert's stop ID
      for (final update in updatesData) {
        // Only check updates for the alert's route
        if (update.routeId != alert.routeId) continue;

        for (final stopTime in update.stopTimeUpdates) {
          if (stopTime.stopId != alert.stopId) continue;

          final predictedArrival = stopTime.predictedArrival;
          if (predictedArrival == null) continue;

          // Calculate minutes until arrival
          final minutesAway =
              predictedArrival.difference(DateTime.now()).inMinutes;

          // Fire notification if within threshold
          if (minutesAway <= alert.thresholdMinutes) {
            await notificationService.showBusApproachingNotification(
              routeShortName: alert.routeId,
              stopName: alert.stopName,
              minutesAway: minutesAway.clamp(0, alert.thresholdMinutes),
            );

            alertsToRemove.add(alert);
            break; // Only fire once per alert
          }
        }
      }
    }

    // Remove fired alerts from the active list
    if (alertsToRemove.isNotEmpty) {
      state = state
          .where((a) => !alertsToRemove.any(
                (r) => r.routeId == a.routeId && r.stopId == a.stopId,
              ))
          .toList();
    }
  }
}

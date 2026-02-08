import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/alert_providers.dart';
import 'package:bussin/features/alerts/widgets/alert_card.dart';

/// ---------------------------------------------------------------------------
/// AlertsScreen - Full list of active TransLink service alerts
/// ---------------------------------------------------------------------------
/// Displays all current service alerts (detours, reduced service,
/// cancellations, etc.) from the TransLink GTFS-RT alerts feed.
///
/// Features:
///   - List of [AlertCard] widgets with severity indicators and details
///   - Pull-to-refresh not needed since alerts auto-poll every 60 seconds
///   - Empty state when no active service alerts exist
///   - Loading/error states for the initial alert fetch
///
/// State consumed:
///   - [serviceAlertsProvider]: StreamProvider that polls every 60 seconds,
///     yielding List<ServiceAlertModel> from the GTFS-RT alerts endpoint.
/// ---------------------------------------------------------------------------
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the service alerts stream. Each emission contains the full
    // list of currently active alerts from TransLink's GTFS-RT feed.
    final alertsAsync = ref.watch(serviceAlertsProvider);

    return CupertinoPageScaffold(
      // --- Navigation bar with screen title ---
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Service Alerts'),
      ),

      // --- Main content: async state handling ---
      child: SafeArea(
        child: alertsAsync.when(
          // --- Loading state: spinner while first poll completes ---
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),

          // --- Error state: display error from the alerts API ---
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    size: 40,
                    color: CupertinoColors.systemRed,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Failed to load service alerts:\n$error',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Data state: list of alert cards or empty state ---
          data: (alerts) {
            // Empty state: no active disruptions
            if (alerts.isEmpty) {
              return const _EmptyAlertsView();
            }

            // Scrollable list of alert cards with padding
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: alerts.length,
              // Spacing between alert cards
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return AlertCard(alert: alerts[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _EmptyAlertsView - Shown when there are no active service alerts
/// ---------------------------------------------------------------------------
/// Displays a positive message indicating all transit services are running
/// normally, with a checkmark icon for visual confirmation.
class _EmptyAlertsView extends StatelessWidget {
  const _EmptyAlertsView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Checkmark icon indicating good status
            Icon(
              CupertinoIcons.checkmark_shield,
              size: 48,
              color: CupertinoColors.systemGrey3,
            ),
            SizedBox(height: 16),

            // Primary message
            Text(
              'No active service alerts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.systemGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // Reassuring sub-text
            Text(
              'All transit services are running normally',
              style: TextStyle(
                fontSize: 15,
                color: CupertinoColors.systemGrey2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

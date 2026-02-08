import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/notification_provider.dart';

/// ---------------------------------------------------------------------------
/// Set Alert Button
/// ---------------------------------------------------------------------------
/// A button that allows users to set a notification alert for when a
/// specific bus is approaching a stop. Tapping it presents a
/// CupertinoActionSheet with threshold options ("1 min away",
/// "2 min away", "5 min away", "10 min away").
///
/// When the user selects an option:
///   1. A [BusAlert] is created and added to [busAlertSettingsProvider]
///   2. A brief confirmation overlay is shown
///   3. The notification service will fire when the bus reaches the threshold
///
/// This widget is typically placed alongside each arrival in the stop
/// detail screen's arrival list.
/// ---------------------------------------------------------------------------
class SetAlertButton extends ConsumerStatefulWidget {
  /// The route ID to monitor for arrival at the stop.
  final String routeId;

  /// The stop ID where the alert should trigger.
  final String stopId;

  /// Human-readable stop name for the notification text.
  final String stopName;

  /// The route short name displayed in confirmation (e.g., "049").
  final String routeShortName;

  const SetAlertButton({
    super.key,
    required this.routeId,
    required this.stopId,
    required this.stopName,
    required this.routeShortName,
  });

  @override
  ConsumerState<SetAlertButton> createState() => _SetAlertButtonState();
}

class _SetAlertButtonState extends ConsumerState<SetAlertButton> {
  /// Controls visibility of the brief confirmation overlay.
  bool _showConfirmation = false;

  /// The threshold selected by the user, shown in the confirmation.
  int? _selectedMinutes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ------------------------------------------------------------------
        // The bell button that triggers the action sheet
        // ------------------------------------------------------------------
        CupertinoButton(
          padding: const EdgeInsets.all(6.0),
          minSize: 0,
          onPressed: () => _showAlertOptions(context),
          child: const Icon(
            CupertinoIcons.bell,
            size: 22.0,
          ),
        ),

        // ------------------------------------------------------------------
        // Brief confirmation overlay (shown after user selects a threshold)
        // ------------------------------------------------------------------
        if (_showConfirmation)
          Positioned(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _showConfirmation ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Alert: ${_selectedMinutes}m',
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Presents a CupertinoActionSheet with proximity alert threshold options.
  ///
  /// Each option creates a [BusAlert] with the corresponding threshold
  /// in minutes and adds it to the [busAlertSettingsProvider].
  void _showAlertOptions(BuildContext context) {
    // Define the available threshold options (in minutes).
    const thresholds = [1, 2, 5, 10];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => CupertinoActionSheet(
        title: Text(
          'Alert for Route ${widget.routeShortName}',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        message: Text(
          'Notify me when the bus is approaching ${widget.stopName}',
          style: const TextStyle(fontSize: 13.0),
        ),

        // Build an action button for each threshold option.
        actions: thresholds.map((minutes) {
          return CupertinoActionSheetAction(
            onPressed: () {
              // Close the action sheet first.
              Navigator.of(popupContext).pop();

              // Create the alert and register it with the notification system.
              _setAlert(minutes);
            },
            child: Text('$minutes min away'),
          );
        }).toList(),

        // Cancel button to dismiss without setting an alert.
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(popupContext).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  /// Registers a bus alert with the given threshold and shows a
  /// brief confirmation overlay.
  ///
  /// The alert is added to [busAlertSettingsProvider], which will check
  /// it against live trip updates on each polling cycle (every 30s).
  /// When the bus's predicted arrival is within [thresholdMinutes] of
  /// the stop, a local notification fires automatically.
  void _setAlert(int thresholdMinutes) {
    // Create and register the alert via the notification provider.
    ref.read(busAlertSettingsProvider.notifier).addAlert(
          BusAlert(
            routeId: widget.routeId,
            stopId: widget.stopId,
            stopName: widget.stopName,
            thresholdMinutes: thresholdMinutes,
          ),
        );

    // Show the confirmation overlay briefly.
    setState(() {
      _showConfirmation = true;
      _selectedMinutes = thresholdMinutes;
    });

    // Auto-hide the confirmation after 1.5 seconds.
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showConfirmation = false;
        });
      }
    });
  }
}

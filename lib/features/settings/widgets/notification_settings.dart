import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ---------------------------------------------------------------------------
/// NotificationSettings - Notification configuration widget
/// ---------------------------------------------------------------------------
/// Provides two controls for managing bus arrival notifications:
///
/// 1. CupertinoSwitch to enable/disable notifications globally
///    - When disabled, no arrival alerts will fire even if configured
///    - Persisted via SharedPreferences key 'notifications_enabled'
///
/// 2. Picker for the default alert threshold (minutes before arrival)
///    - Options: 1, 2, 5, 10 minutes
///    - Used as the default when creating new arrival alerts
///    - Persisted via SharedPreferences key 'alert_threshold_minutes'
///
/// This widget manages its own persistence via SharedPreferences rather
/// than Riverpod, since notification settings are simple key-value pairs
/// that don't need reactive state management across screens.
/// ---------------------------------------------------------------------------
class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  /// SharedPreferences key for the notification enabled toggle.
  static const String _enabledKey = 'notifications_enabled';

  /// SharedPreferences key for the default alert threshold in minutes.
  static const String _thresholdKey = 'alert_threshold_minutes';

  /// Available threshold options in minutes.
  /// Users can choose how far in advance they want to be notified
  /// before a bus arrives at their stop.
  static const List<int> _thresholdOptions = [1, 2, 5, 10];

  /// Whether notifications are globally enabled.
  bool _notificationsEnabled = true;

  /// The currently selected default alert threshold in minutes.
  int _thresholdMinutes = 5;

  /// Whether the initial SharedPreferences load has completed.
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load saved preferences when the widget initializes.
    _loadPreferences();
  }

  /// Loads notification settings from SharedPreferences.
  ///
  /// Falls back to default values if no preferences have been saved:
  ///   - notifications_enabled: true (enabled by default)
  ///   - alert_threshold_minutes: 5 (notify 5 minutes before arrival)
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool(_enabledKey) ?? true;
      _thresholdMinutes = prefs.getInt(_thresholdKey) ?? 5;
      _isLoaded = true;
    });
  }

  /// Persists the notification enabled toggle to SharedPreferences.
  Future<void> _saveNotificationsEnabled(bool value) async {
    setState(() => _notificationsEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, value);
  }

  /// Persists the selected threshold to SharedPreferences.
  Future<void> _saveThreshold(int minutes) async {
    setState(() => _thresholdMinutes = minutes);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_thresholdKey, minutes);
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator until SharedPreferences are loaded
    if (!_isLoaded) {
      return const CupertinoListTile(
        leading: Icon(CupertinoIcons.bell),
        title: Text('Loading...'),
        trailing: CupertinoActivityIndicator(radius: 10),
      );
    }

    // Column layout since CupertinoListSection.children expects
    // individual list tiles, but we need two settings rows.
    return Column(
      children: [
        // --- Global notification toggle ---
        // Master switch that enables/disables all bus arrival notifications.
        // When off, no alerts will fire regardless of individual alert settings.
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.bell),
          title: const Text('Enable Notifications'),
          trailing: CupertinoSwitch(
            value: _notificationsEnabled,
            onChanged: _saveNotificationsEnabled,
          ),
        ),

        // --- Default alert threshold picker ---
        // Only interactive when notifications are enabled. Allows the user
        // to select how many minutes before arrival they want to be notified.
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.timer),
          title: const Text('Default Alert'),
          // Show the currently selected threshold value
          additionalInfo: Text('$_thresholdMinutes min'),
          trailing: const CupertinoListTileChevron(),
          // Disabled state when notifications are turned off
          onTap: _notificationsEnabled
              ? () => _showThresholdPicker(context)
              : null,
        ),
      ],
    );
  }

  /// Shows a Cupertino action sheet with threshold options.
  ///
  /// Presents the available minute values (1, 2, 5, 10) as action sheet
  /// buttons. The currently selected option is visually distinguished
  /// (not shown as an action to avoid re-selection).
  void _showThresholdPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => CupertinoActionSheet(
        title: const Text('Alert Threshold'),
        message:
            const Text('How many minutes before arrival should we notify you?'),
        actions: _thresholdOptions.map((minutes) {
          // Determine if this option is currently selected
          final isSelected = minutes == _thresholdMinutes;

          return CupertinoActionSheetAction(
            onPressed: () {
              _saveThreshold(minutes);
              Navigator.of(popupContext).pop();
            },
            child: Text(
              '$minutes minute${minutes == 1 ? '' : 's'}',
              style: TextStyle(
                // Bold the currently selected option for visibility
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.label,
              ),
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(popupContext).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ---------------------------------------------------------------------------
/// NotificationSettings - Notification configuration widget
/// ---------------------------------------------------------------------------
/// Provides two controls for managing bus arrival notifications:
///
/// 1. Switch to enable/disable notifications globally
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
      return const ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('Loading...'),
        trailing: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    // Column layout since CupertinoListSection.children expects
    // individual list tiles, but we need two settings rows.
    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.notifications_none),
          title: const Text('Enable Notifications'),
          value: _notificationsEnabled,
          onChanged: _saveNotificationsEnabled,
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.timer_outlined),
          title: const Text('Default Alert'),
          subtitle: Text('$_thresholdMinutes min'),
          trailing: const Icon(Icons.chevron_right),
          enabled: _notificationsEnabled,
          onTap:
              _notificationsEnabled ? () => _showThresholdPicker(context) : null,
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
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alert Threshold',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              ..._thresholdOptions.map((minutes) {
                final isSelected = minutes == _thresholdMinutes;
                return ListTile(
                  title: Text('$minutes minute${minutes == 1 ? '' : 's'}'),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    _saveThreshold(minutes);
                    Navigator.of(sheetContext).pop();
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

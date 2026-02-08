import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/features/settings/widgets/theme_toggle.dart';
import 'package:bussin/features/settings/widgets/notification_settings.dart';
import 'package:bussin/features/settings/widgets/about_section.dart';

/// ---------------------------------------------------------------------------
/// SettingsScreen - App configuration and information
/// ---------------------------------------------------------------------------
/// Provides grouped settings sections using Material Design:
///
/// Section 1: Appearance
///   - ThemeToggle widget (light / dark / system segmented control)
///
/// Section 2: Notifications
///   - NotificationSettings widget (enable/disable + threshold picker)
///
/// Section 3: Data
///   - "Refresh Transit Data" button to re-download GTFS static data
///   - "Last updated" info showing when data was last refreshed
///   - "Clear Cache" button to wipe cached data
///
/// Section 4: About
///   - AboutSection widget (app info, attributions, licenses)
///
/// All settings use Cupertino widgets exclusively (CupertinoListSection,
/// CupertinoSwitch, CupertinoSlidingSegmentedControl, etc.) to maintain
/// a native iOS look and feel.
/// ---------------------------------------------------------------------------
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  /// Tracks whether a GTFS data refresh operation is currently in progress.
  /// Used to show a loading indicator and prevent duplicate refresh requests.
  bool _isRefreshing = false;

  /// Placeholder for last data update timestamp.
  /// In production, this would be read from SharedPreferences or a provider.
  String _lastUpdated = 'Never';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'APPEARANCE',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: ThemeToggle(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'NOTIFICATIONS',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: NotificationSettings(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'DATA',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('Refresh Transit Data'),
                    trailing: _isRefreshing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : null,
                    onTap: _isRefreshing ? null : _refreshTransitData,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Last Updated'),
                    trailing: Text(_lastUpdated),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: Text(
                      'Clear Cache',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    onTap: () => _confirmClearCache(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ABOUT',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: AboutSection(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Simulates refreshing GTFS static transit data.
  ///
  /// In production, this would call the GtfsStaticService to re-download
  /// the GTFS ZIP from TransLink and reload routes/stops/shapes into SQLite.
  /// For now, simulates a network delay and updates the "last updated" text.
  Future<void> _refreshTransitData() async {
    setState(() => _isRefreshing = true);

    // TODO: Call ref.read(gtfsStaticServiceProvider).downloadAndParse()
    // to actually refresh the GTFS data from TransLink's servers.
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
      _lastUpdated = 'Just now';
    });
  }

  /// Shows a confirmation dialog before clearing all cached data.
  ///
  /// Warns the user that this will require re-downloading transit data
  /// on the next app launch, which may use mobile data.
  void _confirmClearCache(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all cached transit data. '
          'The app will need to re-download data on next launch.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              setState(() => _lastUpdated = 'Never');
            },
            child: Text(
              'Clear',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

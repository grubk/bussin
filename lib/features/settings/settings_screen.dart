import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/features/settings/widgets/theme_toggle.dart';
import 'package:bussin/features/settings/widgets/notification_settings.dart';
import 'package:bussin/features/settings/widgets/about_section.dart';

/// ---------------------------------------------------------------------------
/// SettingsScreen - App configuration and information
/// ---------------------------------------------------------------------------
/// Provides grouped settings sections using Cupertino iOS-style list sections:
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
    return CupertinoPageScaffold(
      // --- Navigation bar with screen title ---
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),

      // --- Scrollable content with grouped sections ---
      child: SafeArea(
        child: ListView(
          children: [
            // ================================================================
            // Section 1: Appearance
            // ================================================================
            // Contains the theme toggle (light/dark/system) using a
            // CupertinoSlidingSegmentedControl.
            CupertinoListSection.insetGrouped(
              header: const Text('APPEARANCE'),
              children: const [
                // ThemeToggle reads themeProvider and writes via the notifier
                ThemeToggle(),
              ],
            ),

            // ================================================================
            // Section 2: Notifications
            // ================================================================
            // Global notification toggle and default alert threshold picker.
            CupertinoListSection.insetGrouped(
              header: const Text('NOTIFICATIONS'),
              children: const [
                // NotificationSettings manages its own SharedPreferences state
                NotificationSettings(),
              ],
            ),

            // ================================================================
            // Section 3: Data
            // ================================================================
            // Controls for refreshing and clearing cached GTFS transit data.
            CupertinoListSection.insetGrouped(
              header: const Text('DATA'),
              children: [
                // --- Refresh Transit Data button ---
                // Re-downloads the GTFS static ZIP from TransLink and
                // repopulates the local SQLite database.
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.arrow_clockwise),
                  title: const Text('Refresh Transit Data'),
                  // Show spinner when refresh is in progress
                  trailing: _isRefreshing
                      ? const CupertinoActivityIndicator(radius: 10)
                      : null,
                  onTap: _isRefreshing ? null : _refreshTransitData,
                ),

                // --- Last updated info ---
                // Shows when the GTFS static data was last refreshed.
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.info_circle),
                  title: const Text('Last Updated'),
                  additionalInfo: Text(_lastUpdated),
                ),

                // --- Clear Cache button ---
                // Wipes all locally cached data (GTFS, preferences, etc.).
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.trash,
                    color: CupertinoColors.destructiveRed,
                  ),
                  title: const Text(
                    'Clear Cache',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                  onTap: () => _confirmClearCache(context),
                ),
              ],
            ),

            // ================================================================
            // Section 4: About
            // ================================================================
            // App info, TransLink attribution, and open-source licenses.
            CupertinoListSection.insetGrouped(
              header: const Text('ABOUT'),
              children: const [
                // AboutSection displays app name, version, attributions,
                // and a licenses button.
                AboutSection(),
              ],
            ),

            // Bottom padding for comfortable scrolling
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
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all cached transit data. '
          'The app will need to re-download data on next launch.',
        ),
        actions: [
          // Cancel - dismiss without action
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          // Clear - wipe cached data
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Clear'),
            onPressed: () {
              // TODO: Call cache clearing logic via a repository/service
              Navigator.of(dialogContext).pop();
              setState(() => _lastUpdated = 'Never');
            },
          ),
        ],
      ),
    );
  }
}

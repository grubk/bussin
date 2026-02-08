import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show showLicensePage;

import 'package:bussin/core/constants/app_constants.dart';

/// ---------------------------------------------------------------------------
/// AboutSection - App information, attributions, and licenses
/// ---------------------------------------------------------------------------
/// Displays essential app metadata and legally required attribution text:
///
///   1. App name ("Bussin!") from [AppConstants.appName]
///   2. Version ("1.0.0") from [AppConstants.appVersion]
///   3. TransLink data attribution text (REQUIRED by TransLink Terms of Service)
///   4. OpenStreetMap attribution (for map tile data)
///   5. "Licenses" button to view open-source license information
///
/// The TransLink attribution is mandatory per their API Terms of Service
/// and must be displayed prominently in the app. The exact text is defined
/// in [AppConstants.translinkAttribution].
///
/// This widget is embedded within the Settings screen's "About"
/// CupertinoListSection.
/// ---------------------------------------------------------------------------
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- App name and version ---
        // Displays the app identity using constants defined in AppConstants.
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.bus),
          title: Text(AppConstants.appName),
          additionalInfo: Text('v${AppConstants.appVersion}'),
        ),

        // --- TransLink data attribution (REQUIRED) ---
        // This attribution text is legally required by TransLink's API
        // Terms of Service for any app that uses their route, stop,
        // and arrival data. It must be displayed to the user.
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.doc_text),
          title: const Text('TransLink Attribution'),
          subtitle: Text(
            AppConstants.translinkAttribution,
            style: const TextStyle(
              fontSize: 11,
              color: CupertinoColors.systemGrey,
              height: 1.3,
            ),
          ),
        ),

        // --- OpenStreetMap attribution ---
        // Required by the OpenStreetMap tile usage policy when displaying
        // OSM-based map tiles in the app.
        const CupertinoListTile(
          leading: Icon(CupertinoIcons.map),
          title: Text('Map Data'),
          subtitle: Text(
            'Map tiles by OpenStreetMap contributors. '
            'Data is available under the Open Database License.',
            style: TextStyle(
              fontSize: 11,
              color: CupertinoColors.systemGrey,
              height: 1.3,
            ),
          ),
        ),

        // --- Open-source licenses button ---
        // Opens Flutter's built-in license page that aggregates all
        // LICENSE files from the app's dependencies (pubspec.yaml).
        // Note: showLicensePage is from package:flutter/material.dart,
        // imported selectively to avoid pulling in full Material.
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.doc_plaintext),
          title: const Text('Licenses'),
          trailing: const CupertinoListTileChevron(),
          onTap: () {
            // showLicensePage() is a Flutter built-in that displays a
            // page listing all open-source licenses from the app's
            // package dependencies. It reads from the LicenseRegistry.
            showLicensePage(
              context: context,
              applicationName: AppConstants.appName,
              applicationVersion: AppConstants.appVersion,
            );
          },
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/selected_route_provider.dart';
import 'package:bussin/providers/vehicle_providers.dart';
import 'package:bussin/providers/location_provider.dart';
import 'package:bussin/providers/alert_providers.dart';
import 'package:bussin/navigation/app_router.dart';
import 'package:bussin/data/models/vehicle_position.dart';

import 'package:bussin/features/map/widgets/bus_map.dart';
import 'package:bussin/features/map/widgets/search_bar_widget.dart';
import 'package:bussin/features/map/widgets/route_label_chip.dart';
import 'package:bussin/features/map/widgets/locate_me_button.dart';
import 'package:bussin/features/map/widgets/nearby_stops_sheet.dart';
import 'package:bussin/features/map/widgets/bus_info_bottom_sheet.dart';
import 'package:bussin/features/map/controllers/map_controller_provider.dart';

/// ---------------------------------------------------------------------------
/// MapScreen - Main screen of the Bussin! app
/// ---------------------------------------------------------------------------
/// This is the primary screen users see when they open the app. It composites
/// several layers:
///
/// 1. Full-screen BusMap widget (renders under the nav bar for immersive feel)
/// 2. Overlaid search bar with frosted glass background at the top
/// 3. Route label chip (visible only when a route is selected)
/// 4. Locate-me button (bottom-right) to center the map on user GPS
/// 5. "Nearby" button (bottom-left) to open a sheet of nearby stops
///
/// The nav bar provides:
/// - History button (clock icon) -> pushes HistoryScreen
/// - Alerts button (bell icon with badge count) -> pushes AlertsScreen
///
/// State consumed:
/// - [selectedRouteProvider]: currently selected route ID (nullable)
/// - [vehiclesForRouteProvider] / [allVehiclePositionsProvider]: bus positions
/// - [currentLocationProvider]: user GPS position stream
/// - [activeAlertCountProvider]: badge count for the alerts button
/// ---------------------------------------------------------------------------
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  /// Tracks whether a bus info bottom sheet is currently displayed,
  /// preventing multiple sheets from stacking if the user taps rapidly.
  bool _isBottomSheetOpen = false;

  @override
  Widget build(BuildContext context) {
    // --- Watch reactive state from providers ---

    // The currently selected route ID. Null means "show all buses" mode.
    final selectedRouteId = ref.watch(selectedRouteProvider);

    // Resolve the list of vehicles to display based on route selection.
    // If a route is selected, show only that route's vehicles;
    // otherwise, show all vehicles from the master stream.
    final vehiclesAsync = selectedRouteId != null
        ? ref.watch(vehiclesForRouteProvider(selectedRouteId))
        : ref.watch(allVehiclePositionsProvider);

    // Number of active service alerts, displayed as a badge on the bell icon.
    final alertCount = ref.watch(activeAlertCountProvider);

    // Read the map controller provider for programmatic map movements
    // (e.g., centering on user location when locate-me is tapped).
    final mapNotifier = ref.read(mapControllerProvider.notifier);

    return CupertinoPageScaffold(
      // --- Transparent navigation bar so the map renders underneath ---
      // This creates an immersive full-screen map experience while still
      // providing standard Cupertino nav bar actions at the top.
      navigationBar: CupertinoNavigationBar(
        // Transparent background lets the map show through
        backgroundColor: const Color(0x00000000),
        border: null, // Remove the default bottom border

        // --- Leading: History button (clock icon) ---
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => AppRouter.pushHistory(context),
          child: const Icon(
            CupertinoIcons.clock,
            color: CupertinoColors.white,
            size: 24,
          ),
        ),

        // --- Trailing: Alerts button (bell icon with badge) ---
        trailing: _AlertBadgeButton(
          alertCount: alertCount,
          onPressed: () => AppRouter.pushAlerts(context),
        ),
      ),

      // --- Main content: stacked layers ---
      // The Stack allows the map to fill the entire screen while
      // overlaying the search bar, route chip, and action buttons.
      child: Stack(
        children: [
          // ---- Layer 1: Full-screen map (bottom-most layer) ----
          // Positioned.fill ensures the map extends edge-to-edge,
          // including under the nav bar and safe area.
          Positioned.fill(
            child: BusMap(
              vehicles: vehiclesAsync,
              selectedRouteId: selectedRouteId,
              onBusTapped: _showBusInfoSheet,
            ),
          ),

          // ---- Layer 2: Search bar with frosted glass ----
          // Positioned at the top, below the nav bar safe area.
          // The SafeArea ensures it doesn't overlap the status bar.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                // Extra top padding to sit below the transparent nav bar
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search bar widget (read-only on map, tapping opens SearchScreen)
                    const SearchBarWidget(),

                    // ---- Layer 3: Route label chip ----
                    // Only visible when a route is selected. Shows the route
                    // number with an "X" button to clear the selection.
                    if (selectedRouteId != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: RouteLabelChip(routeId: selectedRouteId),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // ---- Layer 4: Bottom-right - Locate me button ----
          // Circular button that centers the map on the user's GPS position.
          Positioned(
            bottom: 100,
            right: 16,
            child: LocateMeButton(
              onPressed: () => _centerOnUser(mapNotifier),
            ),
          ),

          // ---- Layer 5: Bottom-left - Nearby stops button ----
          // Opens a draggable bottom sheet listing nearby transit stops
          // with live arrival information.
          Positioned(
            bottom: 100,
            left: 16,
            child: _NearbyButton(
              onPressed: () => _showNearbyStopsSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Centers the map on the user's current GPS position.
  ///
  /// Reads the latest position from [currentLocationProvider] and
  /// animates the map to that location at zoom level 15 (street-level).
  /// If location is unavailable, does nothing silently.
  void _centerOnUser(MapControllerNotifier mapNotifier) {
    final locationAsync = ref.read(currentLocationProvider);
    locationAsync.whenData((position) {
      mapNotifier.centerOnUser(position);
    });
  }

  /// Slides up the [BusInfoBottomSheet] when a bus marker is tapped.
  ///
  /// Guards against multiple sheets being opened simultaneously by
  /// tracking [_isBottomSheetOpen]. The sheet displays route info,
  /// speed, last-updated time, and upcoming stops for the tapped vehicle.
  void _showBusInfoSheet(VehiclePositionModel vehicle) {
    if (_isBottomSheetOpen) return;
    _isBottomSheetOpen = true;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => BusInfoBottomSheet(vehicle: vehicle),
    ).then((_) {
      // Reset the guard flag when the sheet is dismissed
      _isBottomSheetOpen = false;
    });
  }

  /// Opens the [NearbyStopsSheet] as a Cupertino modal popup.
  ///
  /// The sheet shows stops within 500m of the user, sorted by distance,
  /// with live arrival times for each stop.
  void _showNearbyStopsSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => const NearbyStopsSheet(),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _AlertBadgeButton - Bell icon with an optional alert count badge
/// ---------------------------------------------------------------------------
/// Renders a CupertinoButton with [CupertinoIcons.bell] and overlays a
/// small red badge showing the number of active alerts when [alertCount] > 0.
class _AlertBadgeButton extends StatelessWidget {
  final int alertCount;
  final VoidCallback onPressed;

  const _AlertBadgeButton({
    required this.alertCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bell icon
          const Icon(
            CupertinoIcons.bell,
            color: CupertinoColors.white,
            size: 24,
          ),

          // Red badge - only shown when there are active alerts
          if (alertCount > 0)
            Positioned(
              top: -4,
              right: -6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemRed,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  // Cap at "9+" for very large counts to keep badge compact
                  alertCount > 9 ? '9+' : alertCount.toString(),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _NearbyButton - "Nearby" floating action button (bottom-left)
/// ---------------------------------------------------------------------------
/// A semi-transparent pill-shaped button with a blur backdrop that opens
/// the nearby stops sheet when tapped.
class _NearbyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _NearbyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        // Frosted glass blur behind the button
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: CupertinoColors.systemBackground.withOpacity(0.7),
          borderRadius: BorderRadius.circular(22),
          onPressed: onPressed,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.location_circle,
                size: 18,
                color: CupertinoColors.activeBlue,
              ),
              SizedBox(width: 6),
              Text(
                'Nearby',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

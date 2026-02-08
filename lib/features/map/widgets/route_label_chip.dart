import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/selected_route_provider.dart';
import 'package:bussin/providers/route_providers.dart';

/// ---------------------------------------------------------------------------
/// RouteLabelChip - Pill showing the currently selected route
/// ---------------------------------------------------------------------------
/// A small rounded-rectangle chip that displays the currently selected
/// route's short name (e.g., "049", "R4", "99 B-Line") with a colored
/// background. Includes an "X" button to clear the route selection.
///
/// This chip is only rendered when [selectedRouteProvider] is non-null
/// (the parent MapScreen conditionally includes it in the widget tree).
///
/// Visual design:
/// - Rounded rectangle (pill shape) with 20px border radius
/// - Background color: route's GTFS color if available, or TransLink blue
///   (#0060A9) as default
/// - White text showing the route short name
/// - Small "X" (clear) button on the right side
///
/// Interactions:
/// - Tapping the "X" calls ref.read(selectedRouteProvider.notifier).clearSelection()
///   which sets the selected route to null, returning to "all buses" mode
///
/// This is a [ConsumerWidget] because it reads:
/// - [routeProvider(routeId)] to get the route's display name and color
/// - [selectedRouteProvider.notifier] to clear the selection on X tap
/// ---------------------------------------------------------------------------
class RouteLabelChip extends ConsumerWidget {
  /// The route ID to display info for.
  /// This should always be non-null when this widget is rendered.
  final String routeId;

  const RouteLabelChip({
    super.key,
    required this.routeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the route details (name, color) from the route provider.
    // This is a FutureProvider.family that queries SQLite for the route data.
    final routeAsync = ref.watch(routeProvider(routeId));

    return routeAsync.when(
      // While loading route data, show the routeId as placeholder text
      loading: () => _buildChip(
        context: context,
        ref: ref,
        label: routeId,
        backgroundColor: const Color(0xFF0060A9),
      ),

      // On error, still show the route ID so the user can clear the selection
      error: (_, __) => _buildChip(
        context: context,
        ref: ref,
        label: routeId,
        backgroundColor: const Color(0xFF0060A9),
      ),

      // With route data loaded, use the route's display name and color
      data: (route) {
        // Parse the route color from the GTFS hex string (e.g., "0060A9").
        // Falls back to TransLink blue if no color is specified in the data.
        final backgroundColor = _parseRouteColor(route?.routeColor);

        return _buildChip(
          context: context,
          ref: ref,
          // Use the short name for compact display (e.g., "049" instead of full name)
          label: route?.routeShortName ?? routeId,
          backgroundColor: backgroundColor,
        );
      },
    );
  }

  /// Builds the pill-shaped chip widget with the given label and color.
  ///
  /// Separated from the provider logic so the same chip layout is used
  /// for loading, error, and data states.
  Widget _buildChip({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // Route-specific or default blue background
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Route short name text ---
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 6),

          // --- "X" clear button ---
          // Tapping this clears the route selection, returning the map
          // to "all buses" mode. The chip will disappear because the
          // parent MapScreen conditionally renders it based on
          // selectedRouteProvider being non-null.
          GestureDetector(
            onTap: () {
              // Call the notifier's clearSelection method to set state to null
              ref.read(selectedRouteProvider.notifier).clearSelection();
            },
            child: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: CupertinoColors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  /// Parses a GTFS hex color string into a Flutter Color.
  ///
  /// GTFS route_color is stored as a 6-character hex string without the
  /// '#' prefix (e.g., "0060A9"). If the string is null, empty, or
  /// malformed, returns TransLink blue as the default.
  Color _parseRouteColor(String? hexColor) {
    // Default to TransLink blue if no color is provided in GTFS data
    if (hexColor == null || hexColor.isEmpty) {
      return const Color(0xFF0060A9);
    }

    try {
      // Prepend 'FF' for full opacity and '0x' for hex literal parsing
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (_) {
      // Malformed hex string -- fall back to default blue
      return const Color(0xFF0060A9);
    }
  }
}

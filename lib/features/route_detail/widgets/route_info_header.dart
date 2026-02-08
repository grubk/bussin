import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/data/models/bus_route.dart';

/// ---------------------------------------------------------------------------
/// Route Info Header
/// ---------------------------------------------------------------------------
/// Top section of the route detail screen displaying the route's identity
/// at a glance: a large colored badge with the route number, the full
/// route name, directional headsign (if available), and the count of
/// currently active buses on this route.
///
/// This is a pure presentation widget -- all data is passed in via
/// constructor parameters rather than read from providers directly,
/// keeping it easy to test and reuse.
/// ---------------------------------------------------------------------------
class RouteInfoHeader extends StatelessWidget {
  /// The route model containing short name, long name, color, etc.
  final BusRoute route;

  /// Number of buses currently operating on this route.
  final int activeBusCount;

  /// Optional headsign text describing the route direction
  /// (e.g., "To UBC" or "To Metrotown").
  final String? headsign;

  const RouteInfoHeader({
    super.key,
    required this.route,
    required this.activeBusCount,
    this.headsign,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the route color from GTFS hex string, falling back to
    // TransLink brand blue (#0060A9) if no color is specified.
    final routeColor = _parseRouteColor(route.routeColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------------------
          // Row: Route badge + route long name
          // ------------------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Large colored badge showing the route short name / number.
              // Uses a rounded-corner Container matching the route's GTFS color.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: routeColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  route.routeShortName,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),

              const SizedBox(width: 14.0),

              // Route long name displayed next to the badge, wrapping if needed.
              Expanded(
                child: Text(
                  route.routeLongName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          // ------------------------------------------------------------------
          // Headsign / direction info (only shown if available)
          // ------------------------------------------------------------------
          if (headsign != null && headsign!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.arrow_right,
                    size: 14.0,
                    color: CupertinoColors.systemGrey,
                  ),
                  const SizedBox(width: 4.0),
                  Flexible(
                    child: Text(
                      headsign!,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: CupertinoColors.systemGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          // ------------------------------------------------------------------
          // Active bus count indicator
          // ------------------------------------------------------------------
          Text(
            '$activeBusCount ${activeBusCount == 1 ? 'bus' : 'buses'} active',
            style: TextStyle(
              fontSize: 14.0,
              color: activeBusCount > 0
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.systemGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Parses a GTFS hex color string (without '#') into a Flutter [Color].
  ///
  /// Falls back to TransLink brand blue (#0060A9) if the color string
  /// is null, empty, or cannot be parsed.
  Color _parseRouteColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return const Color(0xFF0060A9);
    }
    try {
      // GTFS stores hex without '#' prefix -- prepend 0xFF for full opacity.
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (_) {
      return const Color(0xFF0060A9);
    }
  }
}

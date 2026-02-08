import 'package:flutter/cupertino.dart';

/// ---------------------------------------------------------------------------
/// SearchResultTile
/// ---------------------------------------------------------------------------
/// A single search result row used inside the search results list.
///
/// Two named constructors produce visually distinct variants:
///
///   [SearchResultTile.route]
///     Left   : colored badge with the route's short name (e.g. "049")
///     Center : route long name (e.g. "Metrotown Station / UBC")
///     Right  : chevron indicator
///
///   [SearchResultTile.stop]
///     Left   : location pin icon
///     Center : stop name (e.g. "UBC Exchange Bay 7")
///     Right  : stop code in gray + chevron indicator
///
/// Both variants accept an [onTap] callback so the parent widget can
/// handle navigation or state updates when the row is tapped.
/// ---------------------------------------------------------------------------

/// TransLink brand blue, used as the default route badge color when the
/// GTFS data does not provide a route-specific color.
const Color _kTransLinkBlue = Color(0xFF0060A9);

class SearchResultTile extends StatelessWidget {
  // -------------------------------------------------------------------------
  // Fields
  // -------------------------------------------------------------------------

  /// Whether this tile represents a route result (true) or a stop result (false).
  final bool _isRoute;

  /// Route short name displayed inside the badge (route variant only).
  final String? routeShortName;

  /// Route long name displayed as the main label (route variant only).
  final String? routeLongName;

  /// Hex color string from GTFS data (without '#' prefix).
  /// Falls back to TransLink blue if null or invalid.
  final String? routeColor;

  /// Stop name displayed as the main label (stop variant only).
  final String? stopName;

  /// 5-digit rider-facing stop code shown in gray text (stop variant only).
  final String? stopCode;

  /// Callback invoked when the user taps this tile.
  final VoidCallback? onTap;

  // -------------------------------------------------------------------------
  // Named constructors
  // -------------------------------------------------------------------------

  /// Creates a route search result tile.
  ///
  /// Displays a colored badge with [routeShortName] on the left, the
  /// [routeLongName] in the center, and a chevron on the right.
  const SearchResultTile.route({
    super.key,
    required this.routeShortName,
    required this.routeLongName,
    this.routeColor,
    this.onTap,
  })  : _isRoute = true,
        stopName = null,
        stopCode = null;

  /// Creates a stop search result tile.
  ///
  /// Displays a location pin icon on the left, the [stopName] in the center,
  /// the [stopCode] in gray on the right, and a chevron trailing.
  const SearchResultTile.stop({
    super.key,
    required this.stopName,
    this.stopCode,
    this.onTap,
  })  : _isRoute = false,
        routeShortName = null,
        routeLongName = null,
        routeColor = null;

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  /// Parses the GTFS hex color string into a [Color].
  ///
  /// GTFS `route_color` is a 6-character hex string without '#'.
  /// Returns [_kTransLinkBlue] if the string is null, empty, or malformed.
  Color _parseBadgeColor() {
    if (routeColor == null || routeColor!.isEmpty) return _kTransLinkBlue;
    try {
      // Prepend full-opacity alpha channel and parse the hex value.
      return Color(int.parse('FF${routeColor!}', radix: 16));
    } catch (_) {
      return _kTransLinkBlue;
    }
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Use a transparent hit test behavior so the entire row is tappable,
      // not just the visible children.
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        // Bottom border matching iOS list separator style.
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // -- Leading widget (badge or icon) --------------------------------
            _isRoute ? _buildRouteBadge() : _buildStopIcon(),

            const SizedBox(width: 12.0),

            // -- Main label text (route long name or stop name) ----------------
            Expanded(child: _isRoute ? _buildRouteLabel() : _buildStopLabel()),

            // -- Trailing stop code (stop variant only) ------------------------
            if (!_isRoute && stopCode != null && stopCode!.isNotEmpty) ...[
              const SizedBox(width: 8.0),
              Text(
                '#$stopCode',
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14.0,
                ),
              ),
            ],

            const SizedBox(width: 8.0),

            // -- Chevron indicator (both variants) -----------------------------
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16.0,
              color: CupertinoColors.systemGrey3,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Sub-widgets
  // -------------------------------------------------------------------------

  /// Builds the colored badge containing the route short name.
  ///
  /// The badge uses the GTFS route color (or TransLink blue) as its
  /// background with white text for contrast. Rounded corners give it
  /// a pill-like appearance matching TransLink's branding.
  Widget _buildRouteBadge() {
    return Container(
      constraints: const BoxConstraints(minWidth: 48.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _parseBadgeColor(),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        routeShortName ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Builds the location pin icon for stop results.
  Widget _buildStopIcon() {
    return const Icon(
      CupertinoIcons.location_solid,
      size: 24.0,
      color: _kTransLinkBlue,
    );
  }

  /// Builds the route long name text label.
  Widget _buildRouteLabel() {
    return Text(
      routeLongName ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 15.0),
    );
  }

  /// Builds the stop name text label.
  Widget _buildStopLabel() {
    return Text(
      stopName ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 15.0),
    );
  }
}

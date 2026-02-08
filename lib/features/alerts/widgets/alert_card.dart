import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:bussin/data/models/service_alert.dart';

/// ---------------------------------------------------------------------------
/// AlertCard - Expandable service alert card with severity indicator
/// ---------------------------------------------------------------------------
/// Displays a single TransLink service alert with:
///   1. Severity-colored left border (yellow/orange/red based on effect)
///   2. Header text (bold) showing the alert title
///   3. Expandable description with "Show more" / "Show less" toggle
///   4. Cause and effect labels as informational badges
///   5. Affected routes displayed as colored chips
///   6. Active period start/end dates
///
/// The card uses a colored left border to provide immediate visual
/// severity indication matching GTFS-RT effect types:
///   - Yellow: DETOUR (minor disruption, alternate routing)
///   - Orange: REDUCED_SERVICE (fewer buses than scheduled)
///   - Red: NO_SERVICE (complete cancellation)
///   - Grey: All other effects (default)
/// ---------------------------------------------------------------------------
class AlertCard extends StatefulWidget {
  /// The service alert data model from the GTFS-RT alerts feed.
  final ServiceAlertModel alert;

  const AlertCard({super.key, required this.alert});

  @override
  State<AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> {
  /// Controls whether the description text is fully expanded or truncated.
  /// Starts collapsed to keep the list scannable; user taps to expand.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Determine the severity color based on the alert's effect type.
    // This drives the left border color for quick visual scanning.
    final severityColor = _getSeverityColor(widget.alert.effect);

    return Container(
      decoration: BoxDecoration(
        // Severity-colored left border for visual categorization
        border: Border(
          left: BorderSide(
            color: severityColor,
            width: 4,
          ),
        ),
        // Subtle background with rounded corners (except left side)
        color: CupertinoColors.systemBackground,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        // Light shadow for card elevation
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Alert header text (bold title) ---
            Text(
              widget.alert.headerText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // --- Expandable description text ---
            // Truncated to 3 lines when collapsed, full text when expanded.
            // The "Show more/less" button toggles the expansion state.
            _buildExpandableDescription(),
            const SizedBox(height: 10),

            // --- Cause and Effect labels ---
            _buildCauseEffectLabels(),
            const SizedBox(height: 8),

            // --- Affected routes as colored chips ---
            if (widget.alert.affectedRouteIds != null &&
                widget.alert.affectedRouteIds!.isNotEmpty)
              _buildAffectedRoutes(),

            // --- Active period dates ---
            if (widget.alert.activePeriodStart != null ||
                widget.alert.activePeriodEnd != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _buildActivePeriod(),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the expandable description section with a "Show more/less" toggle.
  ///
  /// When collapsed, the description is limited to 3 lines with ellipsis.
  /// Tapping "Show more" expands to show the full text. "Show less"
  /// collapses it back to the truncated view.
  Widget _buildExpandableDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description text, truncated or full depending on _isExpanded
        Text(
          widget.alert.descriptionText,
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey,
            height: 1.4,
          ),
        ),

        // "Show more" / "Show less" toggle button
        // Only shown if the description is likely long enough to be truncated
        if (widget.alert.descriptionText.length > 100)
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _isExpanded ? 'Show less' : 'Show more',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.activeBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the cause and effect label row.
  ///
  /// Displays the alert's cause (e.g., "CONSTRUCTION") and effect
  /// (e.g., "DETOUR") as small labeled badges for quick scanning.
  Widget _buildCauseEffectLabels() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        // Cause label (e.g., CONSTRUCTION, ACCIDENT, WEATHER)
        _InfoLabel(
          label: 'Cause',
          value: _formatEnumValue(widget.alert.cause),
        ),
        // Effect label (e.g., DETOUR, REDUCED_SERVICE, NO_SERVICE)
        _InfoLabel(
          label: 'Effect',
          value: _formatEnumValue(widget.alert.effect),
        ),
      ],
    );
  }

  /// Builds the affected routes section as a horizontal row of colored chips.
  ///
  /// Each affected route ID is displayed in a small blue chip, allowing
  /// users to quickly see which routes are impacted by this alert.
  Widget _buildAffectedRoutes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        const Text(
          'Affected Routes',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 4),

        // Horizontal wrap of route chips
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: widget.alert.affectedRouteIds!.map((routeId) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                routeId,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Builds the active period date range display.
  ///
  /// Shows the start and/or end dates of the alert's active period,
  /// formatted as "MMM d, h:mm a" (e.g., "Jan 15, 8:00 AM").
  Widget _buildActivePeriod() {
    // Date formatter for active period display
    final dateFormat = DateFormat('MMM d, h:mm a');

    // Build the period text depending on which dates are available
    String periodText;
    if (widget.alert.activePeriodStart != null &&
        widget.alert.activePeriodEnd != null) {
      periodText =
          '${dateFormat.format(widget.alert.activePeriodStart!)} — '
          '${dateFormat.format(widget.alert.activePeriodEnd!)}';
    } else if (widget.alert.activePeriodStart != null) {
      periodText =
          'From ${dateFormat.format(widget.alert.activePeriodStart!)}';
    } else {
      periodText = 'Until ${dateFormat.format(widget.alert.activePeriodEnd!)}';
    }

    return Row(
      children: [
        const Icon(
          CupertinoIcons.calendar,
          size: 14,
          color: CupertinoColors.systemGrey,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            periodText,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      ],
    );
  }

  /// Maps GTFS-RT effect types to severity colors for the left border.
  ///
  /// Color mapping:
  ///   - DETOUR -> Yellow (minor: buses are still running, just rerouted)
  ///   - REDUCED_SERVICE -> Orange (moderate: fewer buses than normal)
  ///   - NO_SERVICE -> Red (severe: complete service cancellation)
  ///   - All others -> Grey (informational)
  Color _getSeverityColor(String effect) {
    switch (effect) {
      case 'DETOUR':
        return CupertinoColors.systemYellow;
      case 'REDUCED_SERVICE':
        return CupertinoColors.systemOrange;
      case 'NO_SERVICE':
        return CupertinoColors.systemRed;
      default:
        return CupertinoColors.systemGrey;
    }
  }

  /// Converts a SCREAMING_SNAKE_CASE enum value to Title Case for display.
  ///
  /// Example: "REDUCED_SERVICE" -> "Reduced Service"
  String _formatEnumValue(String value) {
    return value
        .split('_')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

/// ---------------------------------------------------------------------------
/// _InfoLabel - Small labeled badge for cause/effect display
/// ---------------------------------------------------------------------------
/// Renders a "Label: Value" pair in a subtle grey container.
class _InfoLabel extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLabel({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.systemGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

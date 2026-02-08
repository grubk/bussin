import 'package:flutter/cupertino.dart';

/// ---------------------------------------------------------------------------
/// SearchFilters
/// ---------------------------------------------------------------------------
/// Segmented control that filters search results by transit type.
///
/// Displays a [CupertinoSlidingSegmentedControl] with four segments:
///   - All      : no filter applied (shows every result)
///   - Bus      : GTFS route_type 3
///   - SkyTrain : GTFS route_type 1 (subway/metro)
///   - SeaBus   : GTFS route_type 4 (ferry)
///
/// The selected filter is communicated to the parent via [onFilterChanged],
/// which receives the corresponding [TransitFilter] enum value. The parent
/// widget is responsible for applying the filter to the search result list.
///
/// Usage:
///   SearchFilters(
///     selectedFilter: _currentFilter,
///     onFilterChanged: (filter) => setState(() => _currentFilter = filter),
///   )
/// ---------------------------------------------------------------------------

/// Enum representing transit type filter options.
///
/// Each value maps to a GTFS `route_type` integer. [all] means no filtering.
enum TransitFilter {
  /// Show all transit types (no filter applied).
  all,

  /// GTFS route_type 3 -- standard bus routes.
  bus,

  /// GTFS route_type 1 -- subway/metro (SkyTrain in Vancouver).
  skyTrain,

  /// GTFS route_type 4 -- ferry service (SeaBus in Vancouver).
  seaBus,
}

/// Extension on [TransitFilter] providing GTFS route_type mapping and
/// display labels.
extension TransitFilterExtension on TransitFilter {
  /// Returns the GTFS route_type integer for this filter.
  ///
  /// Returns null for [TransitFilter.all] since no filtering should be applied.
  /// Values follow the GTFS specification:
  ///   - 1 = subway/metro (SkyTrain)
  ///   - 3 = bus
  ///   - 4 = ferry (SeaBus)
  int? get routeType {
    switch (this) {
      case TransitFilter.all:
        return null;
      case TransitFilter.bus:
        return 3;
      case TransitFilter.skyTrain:
        return 1;
      case TransitFilter.seaBus:
        return 4;
    }
  }

  /// Human-readable label displayed inside the segmented control.
  String get label {
    switch (this) {
      case TransitFilter.all:
        return 'All';
      case TransitFilter.bus:
        return 'Bus';
      case TransitFilter.skyTrain:
        return 'SkyTrain';
      case TransitFilter.seaBus:
        return 'SeaBus';
    }
  }
}

class SearchFilters extends StatelessWidget {
  /// The currently selected transit filter.
  final TransitFilter selectedFilter;

  /// Callback invoked when the user taps a different segment.
  /// Receives the newly selected [TransitFilter].
  final ValueChanged<TransitFilter> onFilterChanged;

  const SearchFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        // Full width so the segmented control stretches across the screen,
        // giving each segment roughly equal space.
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<TransitFilter>(
          groupValue: selectedFilter,
          // Build a map of TransitFilter -> label widget for each segment.
          children: {
            for (final filter in TransitFilter.values)
              filter: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  filter.label,
                  style: const TextStyle(fontSize: 13.0),
                ),
              ),
          },
          onValueChanged: (TransitFilter? value) {
            // The segmented control returns null only if the same segment
            // is tapped again (deselect), which shouldn't happen with
            // CupertinoSlidingSegmentedControl. Guard against it anyway.
            if (value != null) {
              onFilterChanged(value);
            }
          },
        ),
      ),
    );
  }
}

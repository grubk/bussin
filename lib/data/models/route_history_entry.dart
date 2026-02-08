import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_history_entry.freezed.dart';
part 'route_history_entry.g.dart';

/// A record of a route the user previously viewed.
///
/// Stored in SQLite for the route viewing history feature.
/// Auto-pruned to keep at most MAX_HISTORY_ENTRIES (50) entries.
@freezed
abstract class RouteHistoryEntry with _$RouteHistoryEntry {
  const factory RouteHistoryEntry({
    /// SQLite auto-increment primary key. Null for new entries before insertion.
    int? id,

    /// GTFS route ID of the viewed route.
    required String routeId,

    /// Short display name/number of the route.
    required String routeShortName,

    /// Full descriptive name of the route.
    required String routeLongName,

    /// Timestamp when the user last viewed this route.
    required DateTime viewedAt,
  }) = _RouteHistoryEntry;

  factory RouteHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$RouteHistoryEntryFromJson(json);
}

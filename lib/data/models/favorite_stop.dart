import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_stop.freezed.dart';
part 'favorite_stop.g.dart';

/// A transit stop bookmarked by the user as a favorite.
///
/// Stored in the local SQLite database for persistence across app sessions.
/// Includes stop location data so favorites can be displayed without
/// querying the GTFS stops table.
@freezed
abstract class FavoriteStop with _$FavoriteStop {
  const factory FavoriteStop({
    /// SQLite auto-increment primary key. Null for new entries before insertion.
    int? id,

    /// GTFS stop ID of the favorited stop.
    required String stopId,

    /// Display name of the stop.
    required String stopName,

    /// Latitude coordinate of the stop.
    required double stopLat,

    /// Longitude coordinate of the stop.
    required double stopLon,

    /// Timestamp when the user added this stop to favorites.
    required DateTime createdAt,
  }) = _FavoriteStop;

  factory FavoriteStop.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStopFromJson(json);
}

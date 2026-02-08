import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_route.freezed.dart';
part 'bus_route.g.dart';

/// A transit route from the GTFS static data (routes.txt).
///
/// Represents a TransLink bus, SkyTrain, SeaBus, or WCE route.
/// Route type follows the GTFS specification (0=tram, 1=subway, 3=bus, 4=ferry).
@freezed
abstract class BusRoute with _$BusRoute {
  const factory BusRoute({
    /// Unique route identifier from GTFS (e.g., "049", "R4").
    required String routeId,

    /// Short display name/number (e.g., "049", "099", "Canada Line").
    required String routeShortName,

    /// Full descriptive route name (e.g., "Metrotown Station / UBC").
    required String routeLongName,

    /// GTFS route type: 0=tram, 1=subway/metro, 2=rail, 3=bus, 4=ferry.
    required int routeType,

    /// Hex color code from GTFS data (without '#' prefix).
    /// Used for route badges and polyline rendering.
    String? routeColor,
  }) = _BusRoute;

  factory BusRoute.fromJson(Map<String, dynamic> json) =>
      _$BusRouteFromJson(json);
}

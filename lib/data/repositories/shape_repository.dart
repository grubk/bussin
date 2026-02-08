import 'package:latlong2/latlong.dart';
import 'package:bussin/data/datasources/local_database_service.dart';

/// Repository that provides route polyline coordinates from GTFS shape data.
///
/// Shape data maps a route's geographic path for drawing polylines on the map.
/// Shapes are linked to routes through the trips table:
///   routes.route_id -> trips.route_id -> trips.shape_id -> shapes.shape_id
class ShapeRepository {
  ShapeRepository();

  /// Fetches shape points for a specific shape ID, ordered by sequence.
  ///
  /// Returns a list of [LatLng] coordinates representing the geographic
  /// path of the route, suitable for rendering as a polyline on the map.
  Future<List<LatLng>> getShapePoints(String shapeId) async {
    final rows = await LocalDatabaseService.db.query(
      'gtfs_shapes',
      columns: ['shape_pt_lat', 'shape_pt_lon'],
      where: 'shape_id = ?',
      whereArgs: [shapeId],
      orderBy: 'shape_pt_sequence ASC',
    );

    return rows.map((row) {
      return LatLng(
        (row['shape_pt_lat'] as num).toDouble(),
        (row['shape_pt_lon'] as num).toDouble(),
      );
    }).toList();
  }

  /// Fetches the polyline shape for a route by looking up any trip's shape.
  ///
  /// Since a route has multiple trips (different times, directions), we
  /// select the shape from the first trip found. For v1, this provides
  /// a representative route path. Future enhancement: support both
  /// inbound/outbound direction shapes.
  ///
  /// Returns an empty list if no trips or shapes exist for the route.
  Future<List<LatLng>> getRouteShape(String routeId) async {
    // Find the shape_id from any trip on this route
    final tripRows = await LocalDatabaseService.db.query(
      'gtfs_trips',
      columns: ['shape_id'],
      where: 'route_id = ? AND shape_id IS NOT NULL',
      whereArgs: [routeId],
      limit: 1,
    );

    if (tripRows.isEmpty) return [];

    final shapeId = tripRows.first['shape_id'] as String?;
    if (shapeId == null || shapeId.isEmpty) return [];

    return getShapePoints(shapeId);
  }
}

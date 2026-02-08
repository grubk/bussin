import 'package:freezed_annotation/freezed_annotation.dart';

part 'shape_point.freezed.dart';
part 'shape_point.g.dart';

/// A single coordinate in a route's geographic shape (shapes.txt).
///
/// Shape points are ordered by sequence number and connected to form
/// polylines representing the route path on the map.
@freezed
abstract class ShapePoint with _$ShapePoint {
  const factory ShapePoint({
    /// Shape ID grouping this point with others in the same path.
    required String shapeId,

    /// Latitude coordinate of this shape point.
    required double lat,

    /// Longitude coordinate of this shape point.
    required double lon,

    /// Order of this point in the polyline (ascending).
    required int sequence,
  }) = _ShapePoint;

  factory ShapePoint.fromJson(Map<String, dynamic> json) =>
      _$ShapePointFromJson(json);
}

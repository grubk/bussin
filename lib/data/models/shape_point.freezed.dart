// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shape_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShapePoint {

/// Shape ID grouping this point with others in the same path.
 String get shapeId;/// Latitude coordinate of this shape point.
 double get lat;/// Longitude coordinate of this shape point.
 double get lon;/// Order of this point in the polyline (ascending).
 int get sequence;
/// Create a copy of ShapePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapePointCopyWith<ShapePoint> get copyWith => _$ShapePointCopyWithImpl<ShapePoint>(this as ShapePoint, _$identity);

  /// Serializes this ShapePoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapePoint&&(identical(other.shapeId, shapeId) || other.shapeId == shapeId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shapeId,lat,lon,sequence);

@override
String toString() {
  return 'ShapePoint(shapeId: $shapeId, lat: $lat, lon: $lon, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class $ShapePointCopyWith<$Res>  {
  factory $ShapePointCopyWith(ShapePoint value, $Res Function(ShapePoint) _then) = _$ShapePointCopyWithImpl;
@useResult
$Res call({
 String shapeId, double lat, double lon, int sequence
});




}
/// @nodoc
class _$ShapePointCopyWithImpl<$Res>
    implements $ShapePointCopyWith<$Res> {
  _$ShapePointCopyWithImpl(this._self, this._then);

  final ShapePoint _self;
  final $Res Function(ShapePoint) _then;

/// Create a copy of ShapePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shapeId = null,Object? lat = null,Object? lon = null,Object? sequence = null,}) {
  return _then(_self.copyWith(
shapeId: null == shapeId ? _self.shapeId : shapeId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShapePoint].
extension ShapePointPatterns on ShapePoint {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShapePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShapePoint() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShapePoint value)  $default,){
final _that = this;
switch (_that) {
case _ShapePoint():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShapePoint value)?  $default,){
final _that = this;
switch (_that) {
case _ShapePoint() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shapeId,  double lat,  double lon,  int sequence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShapePoint() when $default != null:
return $default(_that.shapeId,_that.lat,_that.lon,_that.sequence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shapeId,  double lat,  double lon,  int sequence)  $default,) {final _that = this;
switch (_that) {
case _ShapePoint():
return $default(_that.shapeId,_that.lat,_that.lon,_that.sequence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shapeId,  double lat,  double lon,  int sequence)?  $default,) {final _that = this;
switch (_that) {
case _ShapePoint() when $default != null:
return $default(_that.shapeId,_that.lat,_that.lon,_that.sequence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShapePoint implements ShapePoint {
  const _ShapePoint({required this.shapeId, required this.lat, required this.lon, required this.sequence});
  factory _ShapePoint.fromJson(Map<String, dynamic> json) => _$ShapePointFromJson(json);

/// Shape ID grouping this point with others in the same path.
@override final  String shapeId;
/// Latitude coordinate of this shape point.
@override final  double lat;
/// Longitude coordinate of this shape point.
@override final  double lon;
/// Order of this point in the polyline (ascending).
@override final  int sequence;

/// Create a copy of ShapePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShapePointCopyWith<_ShapePoint> get copyWith => __$ShapePointCopyWithImpl<_ShapePoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShapePointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShapePoint&&(identical(other.shapeId, shapeId) || other.shapeId == shapeId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shapeId,lat,lon,sequence);

@override
String toString() {
  return 'ShapePoint(shapeId: $shapeId, lat: $lat, lon: $lon, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class _$ShapePointCopyWith<$Res> implements $ShapePointCopyWith<$Res> {
  factory _$ShapePointCopyWith(_ShapePoint value, $Res Function(_ShapePoint) _then) = __$ShapePointCopyWithImpl;
@override @useResult
$Res call({
 String shapeId, double lat, double lon, int sequence
});




}
/// @nodoc
class __$ShapePointCopyWithImpl<$Res>
    implements _$ShapePointCopyWith<$Res> {
  __$ShapePointCopyWithImpl(this._self, this._then);

  final _ShapePoint _self;
  final $Res Function(_ShapePoint) _then;

/// Create a copy of ShapePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shapeId = null,Object? lat = null,Object? lon = null,Object? sequence = null,}) {
  return _then(_ShapePoint(
shapeId: null == shapeId ? _self.shapeId : shapeId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

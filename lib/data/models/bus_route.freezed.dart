// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusRoute {

/// Unique route identifier from GTFS (e.g., "049", "R4").
 String get routeId;/// Short display name/number (e.g., "049", "099", "Canada Line").
 String get routeShortName;/// Full descriptive route name (e.g., "Metrotown Station / UBC").
 String get routeLongName;/// GTFS route type: 0=tram, 1=subway/metro, 2=rail, 3=bus, 4=ferry.
 int get routeType;/// Hex color code from GTFS data (without '#' prefix).
/// Used for route badges and polyline rendering.
 String? get routeColor;
/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusRouteCopyWith<BusRoute> get copyWith => _$BusRouteCopyWithImpl<BusRoute>(this as BusRoute, _$identity);

  /// Serializes this BusRoute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusRoute&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeShortName, routeShortName) || other.routeShortName == routeShortName)&&(identical(other.routeLongName, routeLongName) || other.routeLongName == routeLongName)&&(identical(other.routeType, routeType) || other.routeType == routeType)&&(identical(other.routeColor, routeColor) || other.routeColor == routeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,routeShortName,routeLongName,routeType,routeColor);

@override
String toString() {
  return 'BusRoute(routeId: $routeId, routeShortName: $routeShortName, routeLongName: $routeLongName, routeType: $routeType, routeColor: $routeColor)';
}


}

/// @nodoc
abstract mixin class $BusRouteCopyWith<$Res>  {
  factory $BusRouteCopyWith(BusRoute value, $Res Function(BusRoute) _then) = _$BusRouteCopyWithImpl;
@useResult
$Res call({
 String routeId, String routeShortName, String routeLongName, int routeType, String? routeColor
});




}
/// @nodoc
class _$BusRouteCopyWithImpl<$Res>
    implements $BusRouteCopyWith<$Res> {
  _$BusRouteCopyWithImpl(this._self, this._then);

  final BusRoute _self;
  final $Res Function(BusRoute) _then;

/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeId = null,Object? routeShortName = null,Object? routeLongName = null,Object? routeType = null,Object? routeColor = freezed,}) {
  return _then(_self.copyWith(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeShortName: null == routeShortName ? _self.routeShortName : routeShortName // ignore: cast_nullable_to_non_nullable
as String,routeLongName: null == routeLongName ? _self.routeLongName : routeLongName // ignore: cast_nullable_to_non_nullable
as String,routeType: null == routeType ? _self.routeType : routeType // ignore: cast_nullable_to_non_nullable
as int,routeColor: freezed == routeColor ? _self.routeColor : routeColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusRoute].
extension BusRoutePatterns on BusRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusRoute value)  $default,){
final _that = this;
switch (_that) {
case _BusRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusRoute value)?  $default,){
final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routeId,  String routeShortName,  String routeLongName,  int routeType,  String? routeColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
return $default(_that.routeId,_that.routeShortName,_that.routeLongName,_that.routeType,_that.routeColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routeId,  String routeShortName,  String routeLongName,  int routeType,  String? routeColor)  $default,) {final _that = this;
switch (_that) {
case _BusRoute():
return $default(_that.routeId,_that.routeShortName,_that.routeLongName,_that.routeType,_that.routeColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routeId,  String routeShortName,  String routeLongName,  int routeType,  String? routeColor)?  $default,) {final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
return $default(_that.routeId,_that.routeShortName,_that.routeLongName,_that.routeType,_that.routeColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusRoute implements BusRoute {
  const _BusRoute({required this.routeId, required this.routeShortName, required this.routeLongName, required this.routeType, this.routeColor});
  factory _BusRoute.fromJson(Map<String, dynamic> json) => _$BusRouteFromJson(json);

/// Unique route identifier from GTFS (e.g., "049", "R4").
@override final  String routeId;
/// Short display name/number (e.g., "049", "099", "Canada Line").
@override final  String routeShortName;
/// Full descriptive route name (e.g., "Metrotown Station / UBC").
@override final  String routeLongName;
/// GTFS route type: 0=tram, 1=subway/metro, 2=rail, 3=bus, 4=ferry.
@override final  int routeType;
/// Hex color code from GTFS data (without '#' prefix).
/// Used for route badges and polyline rendering.
@override final  String? routeColor;

/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusRouteCopyWith<_BusRoute> get copyWith => __$BusRouteCopyWithImpl<_BusRoute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusRouteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusRoute&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeShortName, routeShortName) || other.routeShortName == routeShortName)&&(identical(other.routeLongName, routeLongName) || other.routeLongName == routeLongName)&&(identical(other.routeType, routeType) || other.routeType == routeType)&&(identical(other.routeColor, routeColor) || other.routeColor == routeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeId,routeShortName,routeLongName,routeType,routeColor);

@override
String toString() {
  return 'BusRoute(routeId: $routeId, routeShortName: $routeShortName, routeLongName: $routeLongName, routeType: $routeType, routeColor: $routeColor)';
}


}

/// @nodoc
abstract mixin class _$BusRouteCopyWith<$Res> implements $BusRouteCopyWith<$Res> {
  factory _$BusRouteCopyWith(_BusRoute value, $Res Function(_BusRoute) _then) = __$BusRouteCopyWithImpl;
@override @useResult
$Res call({
 String routeId, String routeShortName, String routeLongName, int routeType, String? routeColor
});




}
/// @nodoc
class __$BusRouteCopyWithImpl<$Res>
    implements _$BusRouteCopyWith<$Res> {
  __$BusRouteCopyWithImpl(this._self, this._then);

  final _BusRoute _self;
  final $Res Function(_BusRoute) _then;

/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeId = null,Object? routeShortName = null,Object? routeLongName = null,Object? routeType = null,Object? routeColor = freezed,}) {
  return _then(_BusRoute(
routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeShortName: null == routeShortName ? _self.routeShortName : routeShortName // ignore: cast_nullable_to_non_nullable
as String,routeLongName: null == routeLongName ? _self.routeLongName : routeLongName // ignore: cast_nullable_to_non_nullable
as String,routeType: null == routeType ? _self.routeType : routeType // ignore: cast_nullable_to_non_nullable
as int,routeColor: freezed == routeColor ? _self.routeColor : routeColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

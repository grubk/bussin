// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripModel {

/// Unique trip identifier.
 String get tripId;/// Route ID this trip belongs to.
 String get routeId;/// Service ID determining which days this trip runs.
 String get serviceId;/// Destination display text (e.g., "UBC", "Metrotown").
 String? get tripHeadsign;/// Travel direction: 0 = outbound, 1 = inbound.
 int? get directionId;/// Shape ID linking to the geographic path for polyline rendering.
 String? get shapeId;
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripModelCopyWith<TripModel> get copyWith => _$TripModelCopyWithImpl<TripModel>(this as TripModel, _$identity);

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.tripHeadsign, tripHeadsign) || other.tripHeadsign == tripHeadsign)&&(identical(other.directionId, directionId) || other.directionId == directionId)&&(identical(other.shapeId, shapeId) || other.shapeId == shapeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,routeId,serviceId,tripHeadsign,directionId,shapeId);

@override
String toString() {
  return 'TripModel(tripId: $tripId, routeId: $routeId, serviceId: $serviceId, tripHeadsign: $tripHeadsign, directionId: $directionId, shapeId: $shapeId)';
}


}

/// @nodoc
abstract mixin class $TripModelCopyWith<$Res>  {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) _then) = _$TripModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String routeId, String serviceId, String? tripHeadsign, int? directionId, String? shapeId
});




}
/// @nodoc
class _$TripModelCopyWithImpl<$Res>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._self, this._then);

  final TripModel _self;
  final $Res Function(TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? routeId = null,Object? serviceId = null,Object? tripHeadsign = freezed,Object? directionId = freezed,Object? shapeId = freezed,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,tripHeadsign: freezed == tripHeadsign ? _self.tripHeadsign : tripHeadsign // ignore: cast_nullable_to_non_nullable
as String?,directionId: freezed == directionId ? _self.directionId : directionId // ignore: cast_nullable_to_non_nullable
as int?,shapeId: freezed == shapeId ? _self.shapeId : shapeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripModel].
extension TripModelPatterns on TripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripModel value)  $default,){
final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String routeId,  String serviceId,  String? tripHeadsign,  int? directionId,  String? shapeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.tripId,_that.routeId,_that.serviceId,_that.tripHeadsign,_that.directionId,_that.shapeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String routeId,  String serviceId,  String? tripHeadsign,  int? directionId,  String? shapeId)  $default,) {final _that = this;
switch (_that) {
case _TripModel():
return $default(_that.tripId,_that.routeId,_that.serviceId,_that.tripHeadsign,_that.directionId,_that.shapeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String routeId,  String serviceId,  String? tripHeadsign,  int? directionId,  String? shapeId)?  $default,) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.tripId,_that.routeId,_that.serviceId,_that.tripHeadsign,_that.directionId,_that.shapeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripModel implements TripModel {
  const _TripModel({required this.tripId, required this.routeId, required this.serviceId, this.tripHeadsign, this.directionId, this.shapeId});
  factory _TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

/// Unique trip identifier.
@override final  String tripId;
/// Route ID this trip belongs to.
@override final  String routeId;
/// Service ID determining which days this trip runs.
@override final  String serviceId;
/// Destination display text (e.g., "UBC", "Metrotown").
@override final  String? tripHeadsign;
/// Travel direction: 0 = outbound, 1 = inbound.
@override final  int? directionId;
/// Shape ID linking to the geographic path for polyline rendering.
@override final  String? shapeId;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripModelCopyWith<_TripModel> get copyWith => __$TripModelCopyWithImpl<_TripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.tripHeadsign, tripHeadsign) || other.tripHeadsign == tripHeadsign)&&(identical(other.directionId, directionId) || other.directionId == directionId)&&(identical(other.shapeId, shapeId) || other.shapeId == shapeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,routeId,serviceId,tripHeadsign,directionId,shapeId);

@override
String toString() {
  return 'TripModel(tripId: $tripId, routeId: $routeId, serviceId: $serviceId, tripHeadsign: $tripHeadsign, directionId: $directionId, shapeId: $shapeId)';
}


}

/// @nodoc
abstract mixin class _$TripModelCopyWith<$Res> implements $TripModelCopyWith<$Res> {
  factory _$TripModelCopyWith(_TripModel value, $Res Function(_TripModel) _then) = __$TripModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String routeId, String serviceId, String? tripHeadsign, int? directionId, String? shapeId
});




}
/// @nodoc
class __$TripModelCopyWithImpl<$Res>
    implements _$TripModelCopyWith<$Res> {
  __$TripModelCopyWithImpl(this._self, this._then);

  final _TripModel _self;
  final $Res Function(_TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? routeId = null,Object? serviceId = null,Object? tripHeadsign = freezed,Object? directionId = freezed,Object? shapeId = freezed,}) {
  return _then(_TripModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,tripHeadsign: freezed == tripHeadsign ? _self.tripHeadsign : tripHeadsign // ignore: cast_nullable_to_non_nullable
as String?,directionId: freezed == directionId ? _self.directionId : directionId // ignore: cast_nullable_to_non_nullable
as int?,shapeId: freezed == shapeId ? _self.shapeId : shapeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

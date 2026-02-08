// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_stop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteStop {

/// SQLite auto-increment primary key. Null for new entries before insertion.
 int? get id;/// GTFS stop ID of the favorited stop.
 String get stopId;/// Display name of the stop.
 String get stopName;/// Latitude coordinate of the stop.
 double get stopLat;/// Longitude coordinate of the stop.
 double get stopLon;/// Timestamp when the user added this stop to favorites.
 DateTime get createdAt;
/// Create a copy of FavoriteStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteStopCopyWith<FavoriteStop> get copyWith => _$FavoriteStopCopyWithImpl<FavoriteStop>(this as FavoriteStop, _$identity);

  /// Serializes this FavoriteStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteStop&&(identical(other.id, id) || other.id == id)&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopName, stopName) || other.stopName == stopName)&&(identical(other.stopLat, stopLat) || other.stopLat == stopLat)&&(identical(other.stopLon, stopLon) || other.stopLon == stopLon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stopId,stopName,stopLat,stopLon,createdAt);

@override
String toString() {
  return 'FavoriteStop(id: $id, stopId: $stopId, stopName: $stopName, stopLat: $stopLat, stopLon: $stopLon, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteStopCopyWith<$Res>  {
  factory $FavoriteStopCopyWith(FavoriteStop value, $Res Function(FavoriteStop) _then) = _$FavoriteStopCopyWithImpl;
@useResult
$Res call({
 int? id, String stopId, String stopName, double stopLat, double stopLon, DateTime createdAt
});




}
/// @nodoc
class _$FavoriteStopCopyWithImpl<$Res>
    implements $FavoriteStopCopyWith<$Res> {
  _$FavoriteStopCopyWithImpl(this._self, this._then);

  final FavoriteStop _self;
  final $Res Function(FavoriteStop) _then;

/// Create a copy of FavoriteStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? stopId = null,Object? stopName = null,Object? stopLat = null,Object? stopLon = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopName: null == stopName ? _self.stopName : stopName // ignore: cast_nullable_to_non_nullable
as String,stopLat: null == stopLat ? _self.stopLat : stopLat // ignore: cast_nullable_to_non_nullable
as double,stopLon: null == stopLon ? _self.stopLon : stopLon // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteStop].
extension FavoriteStopPatterns on FavoriteStop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteStop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteStop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteStop value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteStop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteStop value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteStop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String stopId,  String stopName,  double stopLat,  double stopLon,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteStop() when $default != null:
return $default(_that.id,_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String stopId,  String stopName,  double stopLat,  double stopLon,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteStop():
return $default(_that.id,_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String stopId,  String stopName,  double stopLat,  double stopLon,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteStop() when $default != null:
return $default(_that.id,_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteStop implements FavoriteStop {
  const _FavoriteStop({this.id, required this.stopId, required this.stopName, required this.stopLat, required this.stopLon, required this.createdAt});
  factory _FavoriteStop.fromJson(Map<String, dynamic> json) => _$FavoriteStopFromJson(json);

/// SQLite auto-increment primary key. Null for new entries before insertion.
@override final  int? id;
/// GTFS stop ID of the favorited stop.
@override final  String stopId;
/// Display name of the stop.
@override final  String stopName;
/// Latitude coordinate of the stop.
@override final  double stopLat;
/// Longitude coordinate of the stop.
@override final  double stopLon;
/// Timestamp when the user added this stop to favorites.
@override final  DateTime createdAt;

/// Create a copy of FavoriteStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteStopCopyWith<_FavoriteStop> get copyWith => __$FavoriteStopCopyWithImpl<_FavoriteStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteStop&&(identical(other.id, id) || other.id == id)&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopName, stopName) || other.stopName == stopName)&&(identical(other.stopLat, stopLat) || other.stopLat == stopLat)&&(identical(other.stopLon, stopLon) || other.stopLon == stopLon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stopId,stopName,stopLat,stopLon,createdAt);

@override
String toString() {
  return 'FavoriteStop(id: $id, stopId: $stopId, stopName: $stopName, stopLat: $stopLat, stopLon: $stopLon, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteStopCopyWith<$Res> implements $FavoriteStopCopyWith<$Res> {
  factory _$FavoriteStopCopyWith(_FavoriteStop value, $Res Function(_FavoriteStop) _then) = __$FavoriteStopCopyWithImpl;
@override @useResult
$Res call({
 int? id, String stopId, String stopName, double stopLat, double stopLon, DateTime createdAt
});




}
/// @nodoc
class __$FavoriteStopCopyWithImpl<$Res>
    implements _$FavoriteStopCopyWith<$Res> {
  __$FavoriteStopCopyWithImpl(this._self, this._then);

  final _FavoriteStop _self;
  final $Res Function(_FavoriteStop) _then;

/// Create a copy of FavoriteStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? stopId = null,Object? stopName = null,Object? stopLat = null,Object? stopLon = null,Object? createdAt = null,}) {
  return _then(_FavoriteStop(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopName: null == stopName ? _self.stopName : stopName // ignore: cast_nullable_to_non_nullable
as String,stopLat: null == stopLat ? _self.stopLat : stopLat // ignore: cast_nullable_to_non_nullable
as double,stopLon: null == stopLon ? _self.stopLon : stopLon // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

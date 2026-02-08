// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_stop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusStop {

/// Unique stop identifier from GTFS.
 String get stopId;/// Human-readable stop name (e.g., "UBC Exchange Bay 7").
 String get stopName;/// Latitude coordinate of the stop.
 double get stopLat;/// Longitude coordinate of the stop.
 double get stopLon;/// 5-digit stop number used by riders (displayed on stop signs).
 String? get stopCode;/// Parent station ID for stops grouped within a station complex.
 String? get parentStation;
/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusStopCopyWith<BusStop> get copyWith => _$BusStopCopyWithImpl<BusStop>(this as BusStop, _$identity);

  /// Serializes this BusStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusStop&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopName, stopName) || other.stopName == stopName)&&(identical(other.stopLat, stopLat) || other.stopLat == stopLat)&&(identical(other.stopLon, stopLon) || other.stopLon == stopLon)&&(identical(other.stopCode, stopCode) || other.stopCode == stopCode)&&(identical(other.parentStation, parentStation) || other.parentStation == parentStation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopId,stopName,stopLat,stopLon,stopCode,parentStation);

@override
String toString() {
  return 'BusStop(stopId: $stopId, stopName: $stopName, stopLat: $stopLat, stopLon: $stopLon, stopCode: $stopCode, parentStation: $parentStation)';
}


}

/// @nodoc
abstract mixin class $BusStopCopyWith<$Res>  {
  factory $BusStopCopyWith(BusStop value, $Res Function(BusStop) _then) = _$BusStopCopyWithImpl;
@useResult
$Res call({
 String stopId, String stopName, double stopLat, double stopLon, String? stopCode, String? parentStation
});




}
/// @nodoc
class _$BusStopCopyWithImpl<$Res>
    implements $BusStopCopyWith<$Res> {
  _$BusStopCopyWithImpl(this._self, this._then);

  final BusStop _self;
  final $Res Function(BusStop) _then;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stopId = null,Object? stopName = null,Object? stopLat = null,Object? stopLon = null,Object? stopCode = freezed,Object? parentStation = freezed,}) {
  return _then(_self.copyWith(
stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopName: null == stopName ? _self.stopName : stopName // ignore: cast_nullable_to_non_nullable
as String,stopLat: null == stopLat ? _self.stopLat : stopLat // ignore: cast_nullable_to_non_nullable
as double,stopLon: null == stopLon ? _self.stopLon : stopLon // ignore: cast_nullable_to_non_nullable
as double,stopCode: freezed == stopCode ? _self.stopCode : stopCode // ignore: cast_nullable_to_non_nullable
as String?,parentStation: freezed == parentStation ? _self.parentStation : parentStation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusStop].
extension BusStopPatterns on BusStop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusStop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusStop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusStop value)  $default,){
final _that = this;
switch (_that) {
case _BusStop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusStop value)?  $default,){
final _that = this;
switch (_that) {
case _BusStop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stopId,  String stopName,  double stopLat,  double stopLon,  String? stopCode,  String? parentStation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusStop() when $default != null:
return $default(_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.stopCode,_that.parentStation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stopId,  String stopName,  double stopLat,  double stopLon,  String? stopCode,  String? parentStation)  $default,) {final _that = this;
switch (_that) {
case _BusStop():
return $default(_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.stopCode,_that.parentStation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stopId,  String stopName,  double stopLat,  double stopLon,  String? stopCode,  String? parentStation)?  $default,) {final _that = this;
switch (_that) {
case _BusStop() when $default != null:
return $default(_that.stopId,_that.stopName,_that.stopLat,_that.stopLon,_that.stopCode,_that.parentStation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusStop implements BusStop {
  const _BusStop({required this.stopId, required this.stopName, required this.stopLat, required this.stopLon, this.stopCode, this.parentStation});
  factory _BusStop.fromJson(Map<String, dynamic> json) => _$BusStopFromJson(json);

/// Unique stop identifier from GTFS.
@override final  String stopId;
/// Human-readable stop name (e.g., "UBC Exchange Bay 7").
@override final  String stopName;
/// Latitude coordinate of the stop.
@override final  double stopLat;
/// Longitude coordinate of the stop.
@override final  double stopLon;
/// 5-digit stop number used by riders (displayed on stop signs).
@override final  String? stopCode;
/// Parent station ID for stops grouped within a station complex.
@override final  String? parentStation;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusStopCopyWith<_BusStop> get copyWith => __$BusStopCopyWithImpl<_BusStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusStop&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopName, stopName) || other.stopName == stopName)&&(identical(other.stopLat, stopLat) || other.stopLat == stopLat)&&(identical(other.stopLon, stopLon) || other.stopLon == stopLon)&&(identical(other.stopCode, stopCode) || other.stopCode == stopCode)&&(identical(other.parentStation, parentStation) || other.parentStation == parentStation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopId,stopName,stopLat,stopLon,stopCode,parentStation);

@override
String toString() {
  return 'BusStop(stopId: $stopId, stopName: $stopName, stopLat: $stopLat, stopLon: $stopLon, stopCode: $stopCode, parentStation: $parentStation)';
}


}

/// @nodoc
abstract mixin class _$BusStopCopyWith<$Res> implements $BusStopCopyWith<$Res> {
  factory _$BusStopCopyWith(_BusStop value, $Res Function(_BusStop) _then) = __$BusStopCopyWithImpl;
@override @useResult
$Res call({
 String stopId, String stopName, double stopLat, double stopLon, String? stopCode, String? parentStation
});




}
/// @nodoc
class __$BusStopCopyWithImpl<$Res>
    implements _$BusStopCopyWith<$Res> {
  __$BusStopCopyWithImpl(this._self, this._then);

  final _BusStop _self;
  final $Res Function(_BusStop) _then;

/// Create a copy of BusStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stopId = null,Object? stopName = null,Object? stopLat = null,Object? stopLon = null,Object? stopCode = freezed,Object? parentStation = freezed,}) {
  return _then(_BusStop(
stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopName: null == stopName ? _self.stopName : stopName // ignore: cast_nullable_to_non_nullable
as String,stopLat: null == stopLat ? _self.stopLat : stopLat // ignore: cast_nullable_to_non_nullable
as double,stopLon: null == stopLon ? _self.stopLon : stopLon // ignore: cast_nullable_to_non_nullable
as double,stopCode: freezed == stopCode ? _self.stopCode : stopCode // ignore: cast_nullable_to_non_nullable
as String?,parentStation: freezed == parentStation ? _self.parentStation : parentStation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

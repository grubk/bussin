// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehiclePositionModel {

/// Unique identifier for this vehicle (from protobuf vehicle.id).
 String get vehicleId;/// Trip ID this vehicle is currently serving.
 String get tripId;/// Route ID this vehicle is currently operating on.
 String get routeId;/// Current latitude coordinate of the vehicle.
 double get latitude;/// Current longitude coordinate of the vehicle.
 double get longitude;/// Heading direction in degrees (0-360, 0=North, 90=East).
/// Null if not reported by the vehicle.
 double? get bearing;/// Current speed in meters per second.
/// Null if not reported by the vehicle.
 double? get speed;/// Timestamp when this position was last reported by the vehicle.
 DateTime get timestamp;/// Stop ID the vehicle is currently at or approaching.
 String? get currentStopId;/// Position in the trip's stop sequence (1-based index).
 int? get currentStopSequence;/// Human-readable vehicle label (e.g., bus number displayed on the bus).
 String? get vehicleLabel;
/// Create a copy of VehiclePositionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclePositionModelCopyWith<VehiclePositionModel> get copyWith => _$VehiclePositionModelCopyWithImpl<VehiclePositionModel>(this as VehiclePositionModel, _$identity);

  /// Serializes this VehiclePositionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclePositionModel&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.currentStopId, currentStopId) || other.currentStopId == currentStopId)&&(identical(other.currentStopSequence, currentStopSequence) || other.currentStopSequence == currentStopSequence)&&(identical(other.vehicleLabel, vehicleLabel) || other.vehicleLabel == vehicleLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vehicleId,tripId,routeId,latitude,longitude,bearing,speed,timestamp,currentStopId,currentStopSequence,vehicleLabel);

@override
String toString() {
  return 'VehiclePositionModel(vehicleId: $vehicleId, tripId: $tripId, routeId: $routeId, latitude: $latitude, longitude: $longitude, bearing: $bearing, speed: $speed, timestamp: $timestamp, currentStopId: $currentStopId, currentStopSequence: $currentStopSequence, vehicleLabel: $vehicleLabel)';
}


}

/// @nodoc
abstract mixin class $VehiclePositionModelCopyWith<$Res>  {
  factory $VehiclePositionModelCopyWith(VehiclePositionModel value, $Res Function(VehiclePositionModel) _then) = _$VehiclePositionModelCopyWithImpl;
@useResult
$Res call({
 String vehicleId, String tripId, String routeId, double latitude, double longitude, double? bearing, double? speed, DateTime timestamp, String? currentStopId, int? currentStopSequence, String? vehicleLabel
});




}
/// @nodoc
class _$VehiclePositionModelCopyWithImpl<$Res>
    implements $VehiclePositionModelCopyWith<$Res> {
  _$VehiclePositionModelCopyWithImpl(this._self, this._then);

  final VehiclePositionModel _self;
  final $Res Function(VehiclePositionModel) _then;

/// Create a copy of VehiclePositionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vehicleId = null,Object? tripId = null,Object? routeId = null,Object? latitude = null,Object? longitude = null,Object? bearing = freezed,Object? speed = freezed,Object? timestamp = null,Object? currentStopId = freezed,Object? currentStopSequence = freezed,Object? vehicleLabel = freezed,}) {
  return _then(_self.copyWith(
vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,currentStopId: freezed == currentStopId ? _self.currentStopId : currentStopId // ignore: cast_nullable_to_non_nullable
as String?,currentStopSequence: freezed == currentStopSequence ? _self.currentStopSequence : currentStopSequence // ignore: cast_nullable_to_non_nullable
as int?,vehicleLabel: freezed == vehicleLabel ? _self.vehicleLabel : vehicleLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VehiclePositionModel].
extension VehiclePositionModelPatterns on VehiclePositionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehiclePositionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehiclePositionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehiclePositionModel value)  $default,){
final _that = this;
switch (_that) {
case _VehiclePositionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehiclePositionModel value)?  $default,){
final _that = this;
switch (_that) {
case _VehiclePositionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vehicleId,  String tripId,  String routeId,  double latitude,  double longitude,  double? bearing,  double? speed,  DateTime timestamp,  String? currentStopId,  int? currentStopSequence,  String? vehicleLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehiclePositionModel() when $default != null:
return $default(_that.vehicleId,_that.tripId,_that.routeId,_that.latitude,_that.longitude,_that.bearing,_that.speed,_that.timestamp,_that.currentStopId,_that.currentStopSequence,_that.vehicleLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vehicleId,  String tripId,  String routeId,  double latitude,  double longitude,  double? bearing,  double? speed,  DateTime timestamp,  String? currentStopId,  int? currentStopSequence,  String? vehicleLabel)  $default,) {final _that = this;
switch (_that) {
case _VehiclePositionModel():
return $default(_that.vehicleId,_that.tripId,_that.routeId,_that.latitude,_that.longitude,_that.bearing,_that.speed,_that.timestamp,_that.currentStopId,_that.currentStopSequence,_that.vehicleLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vehicleId,  String tripId,  String routeId,  double latitude,  double longitude,  double? bearing,  double? speed,  DateTime timestamp,  String? currentStopId,  int? currentStopSequence,  String? vehicleLabel)?  $default,) {final _that = this;
switch (_that) {
case _VehiclePositionModel() when $default != null:
return $default(_that.vehicleId,_that.tripId,_that.routeId,_that.latitude,_that.longitude,_that.bearing,_that.speed,_that.timestamp,_that.currentStopId,_that.currentStopSequence,_that.vehicleLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehiclePositionModel implements VehiclePositionModel {
  const _VehiclePositionModel({required this.vehicleId, required this.tripId, required this.routeId, required this.latitude, required this.longitude, this.bearing, this.speed, required this.timestamp, this.currentStopId, this.currentStopSequence, this.vehicleLabel});
  factory _VehiclePositionModel.fromJson(Map<String, dynamic> json) => _$VehiclePositionModelFromJson(json);

/// Unique identifier for this vehicle (from protobuf vehicle.id).
@override final  String vehicleId;
/// Trip ID this vehicle is currently serving.
@override final  String tripId;
/// Route ID this vehicle is currently operating on.
@override final  String routeId;
/// Current latitude coordinate of the vehicle.
@override final  double latitude;
/// Current longitude coordinate of the vehicle.
@override final  double longitude;
/// Heading direction in degrees (0-360, 0=North, 90=East).
/// Null if not reported by the vehicle.
@override final  double? bearing;
/// Current speed in meters per second.
/// Null if not reported by the vehicle.
@override final  double? speed;
/// Timestamp when this position was last reported by the vehicle.
@override final  DateTime timestamp;
/// Stop ID the vehicle is currently at or approaching.
@override final  String? currentStopId;
/// Position in the trip's stop sequence (1-based index).
@override final  int? currentStopSequence;
/// Human-readable vehicle label (e.g., bus number displayed on the bus).
@override final  String? vehicleLabel;

/// Create a copy of VehiclePositionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehiclePositionModelCopyWith<_VehiclePositionModel> get copyWith => __$VehiclePositionModelCopyWithImpl<_VehiclePositionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehiclePositionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehiclePositionModel&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.currentStopId, currentStopId) || other.currentStopId == currentStopId)&&(identical(other.currentStopSequence, currentStopSequence) || other.currentStopSequence == currentStopSequence)&&(identical(other.vehicleLabel, vehicleLabel) || other.vehicleLabel == vehicleLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vehicleId,tripId,routeId,latitude,longitude,bearing,speed,timestamp,currentStopId,currentStopSequence,vehicleLabel);

@override
String toString() {
  return 'VehiclePositionModel(vehicleId: $vehicleId, tripId: $tripId, routeId: $routeId, latitude: $latitude, longitude: $longitude, bearing: $bearing, speed: $speed, timestamp: $timestamp, currentStopId: $currentStopId, currentStopSequence: $currentStopSequence, vehicleLabel: $vehicleLabel)';
}


}

/// @nodoc
abstract mixin class _$VehiclePositionModelCopyWith<$Res> implements $VehiclePositionModelCopyWith<$Res> {
  factory _$VehiclePositionModelCopyWith(_VehiclePositionModel value, $Res Function(_VehiclePositionModel) _then) = __$VehiclePositionModelCopyWithImpl;
@override @useResult
$Res call({
 String vehicleId, String tripId, String routeId, double latitude, double longitude, double? bearing, double? speed, DateTime timestamp, String? currentStopId, int? currentStopSequence, String? vehicleLabel
});




}
/// @nodoc
class __$VehiclePositionModelCopyWithImpl<$Res>
    implements _$VehiclePositionModelCopyWith<$Res> {
  __$VehiclePositionModelCopyWithImpl(this._self, this._then);

  final _VehiclePositionModel _self;
  final $Res Function(_VehiclePositionModel) _then;

/// Create a copy of VehiclePositionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vehicleId = null,Object? tripId = null,Object? routeId = null,Object? latitude = null,Object? longitude = null,Object? bearing = freezed,Object? speed = freezed,Object? timestamp = null,Object? currentStopId = freezed,Object? currentStopSequence = freezed,Object? vehicleLabel = freezed,}) {
  return _then(_VehiclePositionModel(
vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,bearing: freezed == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,currentStopId: freezed == currentStopId ? _self.currentStopId : currentStopId // ignore: cast_nullable_to_non_nullable
as String?,currentStopSequence: freezed == currentStopSequence ? _self.currentStopSequence : currentStopSequence // ignore: cast_nullable_to_non_nullable
as int?,vehicleLabel: freezed == vehicleLabel ? _self.vehicleLabel : vehicleLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

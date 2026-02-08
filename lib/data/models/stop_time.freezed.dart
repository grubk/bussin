// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stop_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StopTimeModel {

/// Trip ID this stop time belongs to.
 String get tripId;/// Stop ID where this scheduled time applies.
 String get stopId;/// Scheduled arrival time in "HH:MM:SS" format.
 String get arrivalTime;/// Scheduled departure time in "HH:MM:SS" format.
 String get departureTime;/// Sequential position of this stop within the trip.
 int get stopSequence;
/// Create a copy of StopTimeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StopTimeModelCopyWith<StopTimeModel> get copyWith => _$StopTimeModelCopyWithImpl<StopTimeModel>(this as StopTimeModel, _$identity);

  /// Serializes this StopTimeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopTimeModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.stopSequence, stopSequence) || other.stopSequence == stopSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,stopId,arrivalTime,departureTime,stopSequence);

@override
String toString() {
  return 'StopTimeModel(tripId: $tripId, stopId: $stopId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopSequence: $stopSequence)';
}


}

/// @nodoc
abstract mixin class $StopTimeModelCopyWith<$Res>  {
  factory $StopTimeModelCopyWith(StopTimeModel value, $Res Function(StopTimeModel) _then) = _$StopTimeModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String stopId, String arrivalTime, String departureTime, int stopSequence
});




}
/// @nodoc
class _$StopTimeModelCopyWithImpl<$Res>
    implements $StopTimeModelCopyWith<$Res> {
  _$StopTimeModelCopyWithImpl(this._self, this._then);

  final StopTimeModel _self;
  final $Res Function(StopTimeModel) _then;

/// Create a copy of StopTimeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? stopId = null,Object? arrivalTime = null,Object? departureTime = null,Object? stopSequence = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String,stopSequence: null == stopSequence ? _self.stopSequence : stopSequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StopTimeModel].
extension StopTimeModelPatterns on StopTimeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StopTimeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StopTimeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StopTimeModel value)  $default,){
final _that = this;
switch (_that) {
case _StopTimeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StopTimeModel value)?  $default,){
final _that = this;
switch (_that) {
case _StopTimeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String stopId,  String arrivalTime,  String departureTime,  int stopSequence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StopTimeModel() when $default != null:
return $default(_that.tripId,_that.stopId,_that.arrivalTime,_that.departureTime,_that.stopSequence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String stopId,  String arrivalTime,  String departureTime,  int stopSequence)  $default,) {final _that = this;
switch (_that) {
case _StopTimeModel():
return $default(_that.tripId,_that.stopId,_that.arrivalTime,_that.departureTime,_that.stopSequence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String stopId,  String arrivalTime,  String departureTime,  int stopSequence)?  $default,) {final _that = this;
switch (_that) {
case _StopTimeModel() when $default != null:
return $default(_that.tripId,_that.stopId,_that.arrivalTime,_that.departureTime,_that.stopSequence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StopTimeModel implements StopTimeModel {
  const _StopTimeModel({required this.tripId, required this.stopId, required this.arrivalTime, required this.departureTime, required this.stopSequence});
  factory _StopTimeModel.fromJson(Map<String, dynamic> json) => _$StopTimeModelFromJson(json);

/// Trip ID this stop time belongs to.
@override final  String tripId;
/// Stop ID where this scheduled time applies.
@override final  String stopId;
/// Scheduled arrival time in "HH:MM:SS" format.
@override final  String arrivalTime;
/// Scheduled departure time in "HH:MM:SS" format.
@override final  String departureTime;
/// Sequential position of this stop within the trip.
@override final  int stopSequence;

/// Create a copy of StopTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopTimeModelCopyWith<_StopTimeModel> get copyWith => __$StopTimeModelCopyWithImpl<_StopTimeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StopTimeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopTimeModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.stopSequence, stopSequence) || other.stopSequence == stopSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,stopId,arrivalTime,departureTime,stopSequence);

@override
String toString() {
  return 'StopTimeModel(tripId: $tripId, stopId: $stopId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopSequence: $stopSequence)';
}


}

/// @nodoc
abstract mixin class _$StopTimeModelCopyWith<$Res> implements $StopTimeModelCopyWith<$Res> {
  factory _$StopTimeModelCopyWith(_StopTimeModel value, $Res Function(_StopTimeModel) _then) = __$StopTimeModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String stopId, String arrivalTime, String departureTime, int stopSequence
});




}
/// @nodoc
class __$StopTimeModelCopyWithImpl<$Res>
    implements _$StopTimeModelCopyWith<$Res> {
  __$StopTimeModelCopyWithImpl(this._self, this._then);

  final _StopTimeModel _self;
  final $Res Function(_StopTimeModel) _then;

/// Create a copy of StopTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? stopId = null,Object? arrivalTime = null,Object? departureTime = null,Object? stopSequence = null,}) {
  return _then(_StopTimeModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String,stopSequence: null == stopSequence ? _self.stopSequence : stopSequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

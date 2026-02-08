// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripUpdateModel {

/// Trip ID this update corresponds to.
 String get tripId;/// Route ID for this trip.
 String get routeId;/// List of predicted stop times along the trip.
 List<StopTimeUpdateModel> get stopTimeUpdates;/// Timestamp when this prediction was generated.
 DateTime? get timestamp;/// Overall trip delay in seconds (positive = late, negative = early).
 int? get delay;
/// Create a copy of TripUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripUpdateModelCopyWith<TripUpdateModel> get copyWith => _$TripUpdateModelCopyWithImpl<TripUpdateModel>(this as TripUpdateModel, _$identity);

  /// Serializes this TripUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripUpdateModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&const DeepCollectionEquality().equals(other.stopTimeUpdates, stopTimeUpdates)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.delay, delay) || other.delay == delay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,routeId,const DeepCollectionEquality().hash(stopTimeUpdates),timestamp,delay);

@override
String toString() {
  return 'TripUpdateModel(tripId: $tripId, routeId: $routeId, stopTimeUpdates: $stopTimeUpdates, timestamp: $timestamp, delay: $delay)';
}


}

/// @nodoc
abstract mixin class $TripUpdateModelCopyWith<$Res>  {
  factory $TripUpdateModelCopyWith(TripUpdateModel value, $Res Function(TripUpdateModel) _then) = _$TripUpdateModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String routeId, List<StopTimeUpdateModel> stopTimeUpdates, DateTime? timestamp, int? delay
});




}
/// @nodoc
class _$TripUpdateModelCopyWithImpl<$Res>
    implements $TripUpdateModelCopyWith<$Res> {
  _$TripUpdateModelCopyWithImpl(this._self, this._then);

  final TripUpdateModel _self;
  final $Res Function(TripUpdateModel) _then;

/// Create a copy of TripUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? routeId = null,Object? stopTimeUpdates = null,Object? timestamp = freezed,Object? delay = freezed,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,stopTimeUpdates: null == stopTimeUpdates ? _self.stopTimeUpdates : stopTimeUpdates // ignore: cast_nullable_to_non_nullable
as List<StopTimeUpdateModel>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,delay: freezed == delay ? _self.delay : delay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripUpdateModel].
extension TripUpdateModelPatterns on TripUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _TripUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String routeId,  List<StopTimeUpdateModel> stopTimeUpdates,  DateTime? timestamp,  int? delay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripUpdateModel() when $default != null:
return $default(_that.tripId,_that.routeId,_that.stopTimeUpdates,_that.timestamp,_that.delay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String routeId,  List<StopTimeUpdateModel> stopTimeUpdates,  DateTime? timestamp,  int? delay)  $default,) {final _that = this;
switch (_that) {
case _TripUpdateModel():
return $default(_that.tripId,_that.routeId,_that.stopTimeUpdates,_that.timestamp,_that.delay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String routeId,  List<StopTimeUpdateModel> stopTimeUpdates,  DateTime? timestamp,  int? delay)?  $default,) {final _that = this;
switch (_that) {
case _TripUpdateModel() when $default != null:
return $default(_that.tripId,_that.routeId,_that.stopTimeUpdates,_that.timestamp,_that.delay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripUpdateModel implements TripUpdateModel {
  const _TripUpdateModel({required this.tripId, required this.routeId, required final  List<StopTimeUpdateModel> stopTimeUpdates, this.timestamp, this.delay}): _stopTimeUpdates = stopTimeUpdates;
  factory _TripUpdateModel.fromJson(Map<String, dynamic> json) => _$TripUpdateModelFromJson(json);

/// Trip ID this update corresponds to.
@override final  String tripId;
/// Route ID for this trip.
@override final  String routeId;
/// List of predicted stop times along the trip.
 final  List<StopTimeUpdateModel> _stopTimeUpdates;
/// List of predicted stop times along the trip.
@override List<StopTimeUpdateModel> get stopTimeUpdates {
  if (_stopTimeUpdates is EqualUnmodifiableListView) return _stopTimeUpdates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stopTimeUpdates);
}

/// Timestamp when this prediction was generated.
@override final  DateTime? timestamp;
/// Overall trip delay in seconds (positive = late, negative = early).
@override final  int? delay;

/// Create a copy of TripUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripUpdateModelCopyWith<_TripUpdateModel> get copyWith => __$TripUpdateModelCopyWithImpl<_TripUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripUpdateModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&const DeepCollectionEquality().equals(other._stopTimeUpdates, _stopTimeUpdates)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.delay, delay) || other.delay == delay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,routeId,const DeepCollectionEquality().hash(_stopTimeUpdates),timestamp,delay);

@override
String toString() {
  return 'TripUpdateModel(tripId: $tripId, routeId: $routeId, stopTimeUpdates: $stopTimeUpdates, timestamp: $timestamp, delay: $delay)';
}


}

/// @nodoc
abstract mixin class _$TripUpdateModelCopyWith<$Res> implements $TripUpdateModelCopyWith<$Res> {
  factory _$TripUpdateModelCopyWith(_TripUpdateModel value, $Res Function(_TripUpdateModel) _then) = __$TripUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String routeId, List<StopTimeUpdateModel> stopTimeUpdates, DateTime? timestamp, int? delay
});




}
/// @nodoc
class __$TripUpdateModelCopyWithImpl<$Res>
    implements _$TripUpdateModelCopyWith<$Res> {
  __$TripUpdateModelCopyWithImpl(this._self, this._then);

  final _TripUpdateModel _self;
  final $Res Function(_TripUpdateModel) _then;

/// Create a copy of TripUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? routeId = null,Object? stopTimeUpdates = null,Object? timestamp = freezed,Object? delay = freezed,}) {
  return _then(_TripUpdateModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,stopTimeUpdates: null == stopTimeUpdates ? _self._stopTimeUpdates : stopTimeUpdates // ignore: cast_nullable_to_non_nullable
as List<StopTimeUpdateModel>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,delay: freezed == delay ? _self.delay : delay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$StopTimeUpdateModel {

/// Stop ID where this prediction applies.
 String get stopId;/// Sequential position of this stop within the trip.
 int get stopSequence;/// Predicted arrival time at this stop (from GTFS-RT StopTimeEvent.time).
 DateTime? get predictedArrival;/// Predicted departure time from this stop.
 DateTime? get predictedDeparture;/// Arrival delay in seconds (positive = late, negative = early).
 int? get arrivalDelay;/// Departure delay in seconds.
 int? get departureDelay;
/// Create a copy of StopTimeUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StopTimeUpdateModelCopyWith<StopTimeUpdateModel> get copyWith => _$StopTimeUpdateModelCopyWithImpl<StopTimeUpdateModel>(this as StopTimeUpdateModel, _$identity);

  /// Serializes this StopTimeUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopTimeUpdateModel&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopSequence, stopSequence) || other.stopSequence == stopSequence)&&(identical(other.predictedArrival, predictedArrival) || other.predictedArrival == predictedArrival)&&(identical(other.predictedDeparture, predictedDeparture) || other.predictedDeparture == predictedDeparture)&&(identical(other.arrivalDelay, arrivalDelay) || other.arrivalDelay == arrivalDelay)&&(identical(other.departureDelay, departureDelay) || other.departureDelay == departureDelay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopId,stopSequence,predictedArrival,predictedDeparture,arrivalDelay,departureDelay);

@override
String toString() {
  return 'StopTimeUpdateModel(stopId: $stopId, stopSequence: $stopSequence, predictedArrival: $predictedArrival, predictedDeparture: $predictedDeparture, arrivalDelay: $arrivalDelay, departureDelay: $departureDelay)';
}


}

/// @nodoc
abstract mixin class $StopTimeUpdateModelCopyWith<$Res>  {
  factory $StopTimeUpdateModelCopyWith(StopTimeUpdateModel value, $Res Function(StopTimeUpdateModel) _then) = _$StopTimeUpdateModelCopyWithImpl;
@useResult
$Res call({
 String stopId, int stopSequence, DateTime? predictedArrival, DateTime? predictedDeparture, int? arrivalDelay, int? departureDelay
});




}
/// @nodoc
class _$StopTimeUpdateModelCopyWithImpl<$Res>
    implements $StopTimeUpdateModelCopyWith<$Res> {
  _$StopTimeUpdateModelCopyWithImpl(this._self, this._then);

  final StopTimeUpdateModel _self;
  final $Res Function(StopTimeUpdateModel) _then;

/// Create a copy of StopTimeUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stopId = null,Object? stopSequence = null,Object? predictedArrival = freezed,Object? predictedDeparture = freezed,Object? arrivalDelay = freezed,Object? departureDelay = freezed,}) {
  return _then(_self.copyWith(
stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopSequence: null == stopSequence ? _self.stopSequence : stopSequence // ignore: cast_nullable_to_non_nullable
as int,predictedArrival: freezed == predictedArrival ? _self.predictedArrival : predictedArrival // ignore: cast_nullable_to_non_nullable
as DateTime?,predictedDeparture: freezed == predictedDeparture ? _self.predictedDeparture : predictedDeparture // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalDelay: freezed == arrivalDelay ? _self.arrivalDelay : arrivalDelay // ignore: cast_nullable_to_non_nullable
as int?,departureDelay: freezed == departureDelay ? _self.departureDelay : departureDelay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StopTimeUpdateModel].
extension StopTimeUpdateModelPatterns on StopTimeUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StopTimeUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StopTimeUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StopTimeUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _StopTimeUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StopTimeUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _StopTimeUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stopId,  int stopSequence,  DateTime? predictedArrival,  DateTime? predictedDeparture,  int? arrivalDelay,  int? departureDelay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StopTimeUpdateModel() when $default != null:
return $default(_that.stopId,_that.stopSequence,_that.predictedArrival,_that.predictedDeparture,_that.arrivalDelay,_that.departureDelay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stopId,  int stopSequence,  DateTime? predictedArrival,  DateTime? predictedDeparture,  int? arrivalDelay,  int? departureDelay)  $default,) {final _that = this;
switch (_that) {
case _StopTimeUpdateModel():
return $default(_that.stopId,_that.stopSequence,_that.predictedArrival,_that.predictedDeparture,_that.arrivalDelay,_that.departureDelay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stopId,  int stopSequence,  DateTime? predictedArrival,  DateTime? predictedDeparture,  int? arrivalDelay,  int? departureDelay)?  $default,) {final _that = this;
switch (_that) {
case _StopTimeUpdateModel() when $default != null:
return $default(_that.stopId,_that.stopSequence,_that.predictedArrival,_that.predictedDeparture,_that.arrivalDelay,_that.departureDelay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StopTimeUpdateModel implements StopTimeUpdateModel {
  const _StopTimeUpdateModel({required this.stopId, required this.stopSequence, this.predictedArrival, this.predictedDeparture, this.arrivalDelay, this.departureDelay});
  factory _StopTimeUpdateModel.fromJson(Map<String, dynamic> json) => _$StopTimeUpdateModelFromJson(json);

/// Stop ID where this prediction applies.
@override final  String stopId;
/// Sequential position of this stop within the trip.
@override final  int stopSequence;
/// Predicted arrival time at this stop (from GTFS-RT StopTimeEvent.time).
@override final  DateTime? predictedArrival;
/// Predicted departure time from this stop.
@override final  DateTime? predictedDeparture;
/// Arrival delay in seconds (positive = late, negative = early).
@override final  int? arrivalDelay;
/// Departure delay in seconds.
@override final  int? departureDelay;

/// Create a copy of StopTimeUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopTimeUpdateModelCopyWith<_StopTimeUpdateModel> get copyWith => __$StopTimeUpdateModelCopyWithImpl<_StopTimeUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StopTimeUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopTimeUpdateModel&&(identical(other.stopId, stopId) || other.stopId == stopId)&&(identical(other.stopSequence, stopSequence) || other.stopSequence == stopSequence)&&(identical(other.predictedArrival, predictedArrival) || other.predictedArrival == predictedArrival)&&(identical(other.predictedDeparture, predictedDeparture) || other.predictedDeparture == predictedDeparture)&&(identical(other.arrivalDelay, arrivalDelay) || other.arrivalDelay == arrivalDelay)&&(identical(other.departureDelay, departureDelay) || other.departureDelay == departureDelay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stopId,stopSequence,predictedArrival,predictedDeparture,arrivalDelay,departureDelay);

@override
String toString() {
  return 'StopTimeUpdateModel(stopId: $stopId, stopSequence: $stopSequence, predictedArrival: $predictedArrival, predictedDeparture: $predictedDeparture, arrivalDelay: $arrivalDelay, departureDelay: $departureDelay)';
}


}

/// @nodoc
abstract mixin class _$StopTimeUpdateModelCopyWith<$Res> implements $StopTimeUpdateModelCopyWith<$Res> {
  factory _$StopTimeUpdateModelCopyWith(_StopTimeUpdateModel value, $Res Function(_StopTimeUpdateModel) _then) = __$StopTimeUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 String stopId, int stopSequence, DateTime? predictedArrival, DateTime? predictedDeparture, int? arrivalDelay, int? departureDelay
});




}
/// @nodoc
class __$StopTimeUpdateModelCopyWithImpl<$Res>
    implements _$StopTimeUpdateModelCopyWith<$Res> {
  __$StopTimeUpdateModelCopyWithImpl(this._self, this._then);

  final _StopTimeUpdateModel _self;
  final $Res Function(_StopTimeUpdateModel) _then;

/// Create a copy of StopTimeUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stopId = null,Object? stopSequence = null,Object? predictedArrival = freezed,Object? predictedDeparture = freezed,Object? arrivalDelay = freezed,Object? departureDelay = freezed,}) {
  return _then(_StopTimeUpdateModel(
stopId: null == stopId ? _self.stopId : stopId // ignore: cast_nullable_to_non_nullable
as String,stopSequence: null == stopSequence ? _self.stopSequence : stopSequence // ignore: cast_nullable_to_non_nullable
as int,predictedArrival: freezed == predictedArrival ? _self.predictedArrival : predictedArrival // ignore: cast_nullable_to_non_nullable
as DateTime?,predictedDeparture: freezed == predictedDeparture ? _self.predictedDeparture : predictedDeparture // ignore: cast_nullable_to_non_nullable
as DateTime?,arrivalDelay: freezed == arrivalDelay ? _self.arrivalDelay : arrivalDelay // ignore: cast_nullable_to_non_nullable
as int?,departureDelay: freezed == departureDelay ? _self.departureDelay : departureDelay // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

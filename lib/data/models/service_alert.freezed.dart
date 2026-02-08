// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceAlertModel {

/// Unique identifier for this alert.
 String get id;/// Alert title/header text (extracted from TranslatedString).
 String get headerText;/// Full alert description (extracted from TranslatedString).
 String get descriptionText;/// Cause of the disruption (e.g., CONSTRUCTION, ACCIDENT, WEATHER).
 String get cause;/// Effect on service (e.g., DETOUR, REDUCED_SERVICE, NO_SERVICE).
 String get effect;/// List of route IDs affected by this alert.
 List<String>? get affectedRouteIds;/// List of stop IDs affected by this alert.
 List<String>? get affectedStopIds;/// Start time of the alert's active period.
 DateTime? get activePeriodStart;/// End time of the alert's active period.
 DateTime? get activePeriodEnd;
/// Create a copy of ServiceAlertModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceAlertModelCopyWith<ServiceAlertModel> get copyWith => _$ServiceAlertModelCopyWithImpl<ServiceAlertModel>(this as ServiceAlertModel, _$identity);

  /// Serializes this ServiceAlertModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceAlertModel&&(identical(other.id, id) || other.id == id)&&(identical(other.headerText, headerText) || other.headerText == headerText)&&(identical(other.descriptionText, descriptionText) || other.descriptionText == descriptionText)&&(identical(other.cause, cause) || other.cause == cause)&&(identical(other.effect, effect) || other.effect == effect)&&const DeepCollectionEquality().equals(other.affectedRouteIds, affectedRouteIds)&&const DeepCollectionEquality().equals(other.affectedStopIds, affectedStopIds)&&(identical(other.activePeriodStart, activePeriodStart) || other.activePeriodStart == activePeriodStart)&&(identical(other.activePeriodEnd, activePeriodEnd) || other.activePeriodEnd == activePeriodEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,headerText,descriptionText,cause,effect,const DeepCollectionEquality().hash(affectedRouteIds),const DeepCollectionEquality().hash(affectedStopIds),activePeriodStart,activePeriodEnd);

@override
String toString() {
  return 'ServiceAlertModel(id: $id, headerText: $headerText, descriptionText: $descriptionText, cause: $cause, effect: $effect, affectedRouteIds: $affectedRouteIds, affectedStopIds: $affectedStopIds, activePeriodStart: $activePeriodStart, activePeriodEnd: $activePeriodEnd)';
}


}

/// @nodoc
abstract mixin class $ServiceAlertModelCopyWith<$Res>  {
  factory $ServiceAlertModelCopyWith(ServiceAlertModel value, $Res Function(ServiceAlertModel) _then) = _$ServiceAlertModelCopyWithImpl;
@useResult
$Res call({
 String id, String headerText, String descriptionText, String cause, String effect, List<String>? affectedRouteIds, List<String>? affectedStopIds, DateTime? activePeriodStart, DateTime? activePeriodEnd
});




}
/// @nodoc
class _$ServiceAlertModelCopyWithImpl<$Res>
    implements $ServiceAlertModelCopyWith<$Res> {
  _$ServiceAlertModelCopyWithImpl(this._self, this._then);

  final ServiceAlertModel _self;
  final $Res Function(ServiceAlertModel) _then;

/// Create a copy of ServiceAlertModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? headerText = null,Object? descriptionText = null,Object? cause = null,Object? effect = null,Object? affectedRouteIds = freezed,Object? affectedStopIds = freezed,Object? activePeriodStart = freezed,Object? activePeriodEnd = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,headerText: null == headerText ? _self.headerText : headerText // ignore: cast_nullable_to_non_nullable
as String,descriptionText: null == descriptionText ? _self.descriptionText : descriptionText // ignore: cast_nullable_to_non_nullable
as String,cause: null == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as String,affectedRouteIds: freezed == affectedRouteIds ? _self.affectedRouteIds : affectedRouteIds // ignore: cast_nullable_to_non_nullable
as List<String>?,affectedStopIds: freezed == affectedStopIds ? _self.affectedStopIds : affectedStopIds // ignore: cast_nullable_to_non_nullable
as List<String>?,activePeriodStart: freezed == activePeriodStart ? _self.activePeriodStart : activePeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,activePeriodEnd: freezed == activePeriodEnd ? _self.activePeriodEnd : activePeriodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceAlertModel].
extension ServiceAlertModelPatterns on ServiceAlertModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceAlertModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceAlertModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceAlertModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceAlertModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceAlertModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceAlertModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String headerText,  String descriptionText,  String cause,  String effect,  List<String>? affectedRouteIds,  List<String>? affectedStopIds,  DateTime? activePeriodStart,  DateTime? activePeriodEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceAlertModel() when $default != null:
return $default(_that.id,_that.headerText,_that.descriptionText,_that.cause,_that.effect,_that.affectedRouteIds,_that.affectedStopIds,_that.activePeriodStart,_that.activePeriodEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String headerText,  String descriptionText,  String cause,  String effect,  List<String>? affectedRouteIds,  List<String>? affectedStopIds,  DateTime? activePeriodStart,  DateTime? activePeriodEnd)  $default,) {final _that = this;
switch (_that) {
case _ServiceAlertModel():
return $default(_that.id,_that.headerText,_that.descriptionText,_that.cause,_that.effect,_that.affectedRouteIds,_that.affectedStopIds,_that.activePeriodStart,_that.activePeriodEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String headerText,  String descriptionText,  String cause,  String effect,  List<String>? affectedRouteIds,  List<String>? affectedStopIds,  DateTime? activePeriodStart,  DateTime? activePeriodEnd)?  $default,) {final _that = this;
switch (_that) {
case _ServiceAlertModel() when $default != null:
return $default(_that.id,_that.headerText,_that.descriptionText,_that.cause,_that.effect,_that.affectedRouteIds,_that.affectedStopIds,_that.activePeriodStart,_that.activePeriodEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceAlertModel implements ServiceAlertModel {
  const _ServiceAlertModel({required this.id, required this.headerText, required this.descriptionText, required this.cause, required this.effect, final  List<String>? affectedRouteIds, final  List<String>? affectedStopIds, this.activePeriodStart, this.activePeriodEnd}): _affectedRouteIds = affectedRouteIds,_affectedStopIds = affectedStopIds;
  factory _ServiceAlertModel.fromJson(Map<String, dynamic> json) => _$ServiceAlertModelFromJson(json);

/// Unique identifier for this alert.
@override final  String id;
/// Alert title/header text (extracted from TranslatedString).
@override final  String headerText;
/// Full alert description (extracted from TranslatedString).
@override final  String descriptionText;
/// Cause of the disruption (e.g., CONSTRUCTION, ACCIDENT, WEATHER).
@override final  String cause;
/// Effect on service (e.g., DETOUR, REDUCED_SERVICE, NO_SERVICE).
@override final  String effect;
/// List of route IDs affected by this alert.
 final  List<String>? _affectedRouteIds;
/// List of route IDs affected by this alert.
@override List<String>? get affectedRouteIds {
  final value = _affectedRouteIds;
  if (value == null) return null;
  if (_affectedRouteIds is EqualUnmodifiableListView) return _affectedRouteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// List of stop IDs affected by this alert.
 final  List<String>? _affectedStopIds;
/// List of stop IDs affected by this alert.
@override List<String>? get affectedStopIds {
  final value = _affectedStopIds;
  if (value == null) return null;
  if (_affectedStopIds is EqualUnmodifiableListView) return _affectedStopIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Start time of the alert's active period.
@override final  DateTime? activePeriodStart;
/// End time of the alert's active period.
@override final  DateTime? activePeriodEnd;

/// Create a copy of ServiceAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceAlertModelCopyWith<_ServiceAlertModel> get copyWith => __$ServiceAlertModelCopyWithImpl<_ServiceAlertModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceAlertModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceAlertModel&&(identical(other.id, id) || other.id == id)&&(identical(other.headerText, headerText) || other.headerText == headerText)&&(identical(other.descriptionText, descriptionText) || other.descriptionText == descriptionText)&&(identical(other.cause, cause) || other.cause == cause)&&(identical(other.effect, effect) || other.effect == effect)&&const DeepCollectionEquality().equals(other._affectedRouteIds, _affectedRouteIds)&&const DeepCollectionEquality().equals(other._affectedStopIds, _affectedStopIds)&&(identical(other.activePeriodStart, activePeriodStart) || other.activePeriodStart == activePeriodStart)&&(identical(other.activePeriodEnd, activePeriodEnd) || other.activePeriodEnd == activePeriodEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,headerText,descriptionText,cause,effect,const DeepCollectionEquality().hash(_affectedRouteIds),const DeepCollectionEquality().hash(_affectedStopIds),activePeriodStart,activePeriodEnd);

@override
String toString() {
  return 'ServiceAlertModel(id: $id, headerText: $headerText, descriptionText: $descriptionText, cause: $cause, effect: $effect, affectedRouteIds: $affectedRouteIds, affectedStopIds: $affectedStopIds, activePeriodStart: $activePeriodStart, activePeriodEnd: $activePeriodEnd)';
}


}

/// @nodoc
abstract mixin class _$ServiceAlertModelCopyWith<$Res> implements $ServiceAlertModelCopyWith<$Res> {
  factory _$ServiceAlertModelCopyWith(_ServiceAlertModel value, $Res Function(_ServiceAlertModel) _then) = __$ServiceAlertModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String headerText, String descriptionText, String cause, String effect, List<String>? affectedRouteIds, List<String>? affectedStopIds, DateTime? activePeriodStart, DateTime? activePeriodEnd
});




}
/// @nodoc
class __$ServiceAlertModelCopyWithImpl<$Res>
    implements _$ServiceAlertModelCopyWith<$Res> {
  __$ServiceAlertModelCopyWithImpl(this._self, this._then);

  final _ServiceAlertModel _self;
  final $Res Function(_ServiceAlertModel) _then;

/// Create a copy of ServiceAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? headerText = null,Object? descriptionText = null,Object? cause = null,Object? effect = null,Object? affectedRouteIds = freezed,Object? affectedStopIds = freezed,Object? activePeriodStart = freezed,Object? activePeriodEnd = freezed,}) {
  return _then(_ServiceAlertModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,headerText: null == headerText ? _self.headerText : headerText // ignore: cast_nullable_to_non_nullable
as String,descriptionText: null == descriptionText ? _self.descriptionText : descriptionText // ignore: cast_nullable_to_non_nullable
as String,cause: null == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as String,affectedRouteIds: freezed == affectedRouteIds ? _self._affectedRouteIds : affectedRouteIds // ignore: cast_nullable_to_non_nullable
as List<String>?,affectedStopIds: freezed == affectedStopIds ? _self._affectedStopIds : affectedStopIds // ignore: cast_nullable_to_non_nullable
as List<String>?,activePeriodStart: freezed == activePeriodStart ? _self.activePeriodStart : activePeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,activePeriodEnd: freezed == activePeriodEnd ? _self.activePeriodEnd : activePeriodEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

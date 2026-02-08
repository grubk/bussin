// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteHistoryEntry {

/// SQLite auto-increment primary key. Null for new entries before insertion.
 int? get id;/// GTFS route ID of the viewed route.
 String get routeId;/// Short display name/number of the route.
 String get routeShortName;/// Full descriptive name of the route.
 String get routeLongName;/// Timestamp when the user last viewed this route.
 DateTime get viewedAt;
/// Create a copy of RouteHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteHistoryEntryCopyWith<RouteHistoryEntry> get copyWith => _$RouteHistoryEntryCopyWithImpl<RouteHistoryEntry>(this as RouteHistoryEntry, _$identity);

  /// Serializes this RouteHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeShortName, routeShortName) || other.routeShortName == routeShortName)&&(identical(other.routeLongName, routeLongName) || other.routeLongName == routeLongName)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,routeShortName,routeLongName,viewedAt);

@override
String toString() {
  return 'RouteHistoryEntry(id: $id, routeId: $routeId, routeShortName: $routeShortName, routeLongName: $routeLongName, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class $RouteHistoryEntryCopyWith<$Res>  {
  factory $RouteHistoryEntryCopyWith(RouteHistoryEntry value, $Res Function(RouteHistoryEntry) _then) = _$RouteHistoryEntryCopyWithImpl;
@useResult
$Res call({
 int? id, String routeId, String routeShortName, String routeLongName, DateTime viewedAt
});




}
/// @nodoc
class _$RouteHistoryEntryCopyWithImpl<$Res>
    implements $RouteHistoryEntryCopyWith<$Res> {
  _$RouteHistoryEntryCopyWithImpl(this._self, this._then);

  final RouteHistoryEntry _self;
  final $Res Function(RouteHistoryEntry) _then;

/// Create a copy of RouteHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? routeId = null,Object? routeShortName = null,Object? routeLongName = null,Object? viewedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeShortName: null == routeShortName ? _self.routeShortName : routeShortName // ignore: cast_nullable_to_non_nullable
as String,routeLongName: null == routeLongName ? _self.routeLongName : routeLongName // ignore: cast_nullable_to_non_nullable
as String,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteHistoryEntry].
extension RouteHistoryEntryPatterns on RouteHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _RouteHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RouteHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String routeId,  String routeShortName,  String routeLongName,  DateTime viewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteHistoryEntry() when $default != null:
return $default(_that.id,_that.routeId,_that.routeShortName,_that.routeLongName,_that.viewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String routeId,  String routeShortName,  String routeLongName,  DateTime viewedAt)  $default,) {final _that = this;
switch (_that) {
case _RouteHistoryEntry():
return $default(_that.id,_that.routeId,_that.routeShortName,_that.routeLongName,_that.viewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String routeId,  String routeShortName,  String routeLongName,  DateTime viewedAt)?  $default,) {final _that = this;
switch (_that) {
case _RouteHistoryEntry() when $default != null:
return $default(_that.id,_that.routeId,_that.routeShortName,_that.routeLongName,_that.viewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouteHistoryEntry implements RouteHistoryEntry {
  const _RouteHistoryEntry({this.id, required this.routeId, required this.routeShortName, required this.routeLongName, required this.viewedAt});
  factory _RouteHistoryEntry.fromJson(Map<String, dynamic> json) => _$RouteHistoryEntryFromJson(json);

/// SQLite auto-increment primary key. Null for new entries before insertion.
@override final  int? id;
/// GTFS route ID of the viewed route.
@override final  String routeId;
/// Short display name/number of the route.
@override final  String routeShortName;
/// Full descriptive name of the route.
@override final  String routeLongName;
/// Timestamp when the user last viewed this route.
@override final  DateTime viewedAt;

/// Create a copy of RouteHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteHistoryEntryCopyWith<_RouteHistoryEntry> get copyWith => __$RouteHistoryEntryCopyWithImpl<_RouteHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeShortName, routeShortName) || other.routeShortName == routeShortName)&&(identical(other.routeLongName, routeLongName) || other.routeLongName == routeLongName)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,routeShortName,routeLongName,viewedAt);

@override
String toString() {
  return 'RouteHistoryEntry(id: $id, routeId: $routeId, routeShortName: $routeShortName, routeLongName: $routeLongName, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class _$RouteHistoryEntryCopyWith<$Res> implements $RouteHistoryEntryCopyWith<$Res> {
  factory _$RouteHistoryEntryCopyWith(_RouteHistoryEntry value, $Res Function(_RouteHistoryEntry) _then) = __$RouteHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 int? id, String routeId, String routeShortName, String routeLongName, DateTime viewedAt
});




}
/// @nodoc
class __$RouteHistoryEntryCopyWithImpl<$Res>
    implements _$RouteHistoryEntryCopyWith<$Res> {
  __$RouteHistoryEntryCopyWithImpl(this._self, this._then);

  final _RouteHistoryEntry _self;
  final $Res Function(_RouteHistoryEntry) _then;

/// Create a copy of RouteHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? routeId = null,Object? routeShortName = null,Object? routeLongName = null,Object? viewedAt = null,}) {
  return _then(_RouteHistoryEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeShortName: null == routeShortName ? _self.routeShortName : routeShortName // ignore: cast_nullable_to_non_nullable
as String,routeLongName: null == routeLongName ? _self.routeLongName : routeLongName // ignore: cast_nullable_to_non_nullable
as String,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

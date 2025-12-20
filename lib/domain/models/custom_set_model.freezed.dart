// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_set_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomSetModel {

 String get id; String get name; String get directoryPath;@CardModelConverter() List<CardModel> get cards;
/// Create a copy of CustomSetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomSetModelCopyWith<CustomSetModel> get copyWith => _$CustomSetModelCopyWithImpl<CustomSetModel>(this as CustomSetModel, _$identity);

  /// Serializes this CustomSetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomSetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.directoryPath, directoryPath) || other.directoryPath == directoryPath)&&const DeepCollectionEquality().equals(other.cards, cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,directoryPath,const DeepCollectionEquality().hash(cards));

@override
String toString() {
  return 'CustomSetModel(id: $id, name: $name, directoryPath: $directoryPath, cards: $cards)';
}


}

/// @nodoc
abstract mixin class $CustomSetModelCopyWith<$Res>  {
  factory $CustomSetModelCopyWith(CustomSetModel value, $Res Function(CustomSetModel) _then) = _$CustomSetModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String directoryPath,@CardModelConverter() List<CardModel> cards
});




}
/// @nodoc
class _$CustomSetModelCopyWithImpl<$Res>
    implements $CustomSetModelCopyWith<$Res> {
  _$CustomSetModelCopyWithImpl(this._self, this._then);

  final CustomSetModel _self;
  final $Res Function(CustomSetModel) _then;

/// Create a copy of CustomSetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? directoryPath = null,Object? cards = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directoryPath: null == directoryPath ? _self.directoryPath : directoryPath // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomSetModel].
extension CustomSetModelPatterns on CustomSetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomSetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomSetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomSetModel value)  $default,){
final _that = this;
switch (_that) {
case _CustomSetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomSetModel value)?  $default,){
final _that = this;
switch (_that) {
case _CustomSetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String directoryPath, @CardModelConverter()  List<CardModel> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomSetModel() when $default != null:
return $default(_that.id,_that.name,_that.directoryPath,_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String directoryPath, @CardModelConverter()  List<CardModel> cards)  $default,) {final _that = this;
switch (_that) {
case _CustomSetModel():
return $default(_that.id,_that.name,_that.directoryPath,_that.cards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String directoryPath, @CardModelConverter()  List<CardModel> cards)?  $default,) {final _that = this;
switch (_that) {
case _CustomSetModel() when $default != null:
return $default(_that.id,_that.name,_that.directoryPath,_that.cards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomSetModel extends CustomSetModel {
  const _CustomSetModel({required this.id, required this.name, required this.directoryPath, @CardModelConverter() final  List<CardModel> cards = const []}): _cards = cards,super._();
  factory _CustomSetModel.fromJson(Map<String, dynamic> json) => _$CustomSetModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String directoryPath;
 final  List<CardModel> _cards;
@override@JsonKey()@CardModelConverter() List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of CustomSetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomSetModelCopyWith<_CustomSetModel> get copyWith => __$CustomSetModelCopyWithImpl<_CustomSetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomSetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomSetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.directoryPath, directoryPath) || other.directoryPath == directoryPath)&&const DeepCollectionEquality().equals(other._cards, _cards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,directoryPath,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'CustomSetModel(id: $id, name: $name, directoryPath: $directoryPath, cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$CustomSetModelCopyWith<$Res> implements $CustomSetModelCopyWith<$Res> {
  factory _$CustomSetModelCopyWith(_CustomSetModel value, $Res Function(_CustomSetModel) _then) = __$CustomSetModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String directoryPath,@CardModelConverter() List<CardModel> cards
});




}
/// @nodoc
class __$CustomSetModelCopyWithImpl<$Res>
    implements _$CustomSetModelCopyWith<$Res> {
  __$CustomSetModelCopyWithImpl(this._self, this._then);

  final _CustomSetModel _self;
  final $Res Function(_CustomSetModel) _then;

/// Create a copy of CustomSetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? directoryPath = null,Object? cards = null,}) {
  return _then(_CustomSetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directoryPath: null == directoryPath ? _self.directoryPath : directoryPath // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardModel {

 String get id; CardType get type; Map<String, String> get titles; Map<String, String> get descriptions; Map<String, String> get flavorTexts; List<String> get tags; CardRarity get rarity; CardElement get element; int? get power; int? get toughness; String? get manaCost; String? get imagePath;// Path to front image
 String? get backImagePath;// Special back image for this card/set
 bool get isAsset;
/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardModelCopyWith<CardModel> get copyWith => _$CardModelCopyWithImpl<CardModel>(this as CardModel, _$identity);

  /// Serializes this CardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.descriptions, descriptions)&&const DeepCollectionEquality().equals(other.flavorTexts, flavorTexts)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.element, element) || other.element == element)&&(identical(other.power, power) || other.power == power)&&(identical(other.toughness, toughness) || other.toughness == toughness)&&(identical(other.manaCost, manaCost) || other.manaCost == manaCost)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.backImagePath, backImagePath) || other.backImagePath == backImagePath)&&(identical(other.isAsset, isAsset) || other.isAsset == isAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(descriptions),const DeepCollectionEquality().hash(flavorTexts),const DeepCollectionEquality().hash(tags),rarity,element,power,toughness,manaCost,imagePath,backImagePath,isAsset);

@override
String toString() {
  return 'CardModel(id: $id, type: $type, titles: $titles, descriptions: $descriptions, flavorTexts: $flavorTexts, tags: $tags, rarity: $rarity, element: $element, power: $power, toughness: $toughness, manaCost: $manaCost, imagePath: $imagePath, backImagePath: $backImagePath, isAsset: $isAsset)';
}


}

/// @nodoc
abstract mixin class $CardModelCopyWith<$Res>  {
  factory $CardModelCopyWith(CardModel value, $Res Function(CardModel) _then) = _$CardModelCopyWithImpl;
@useResult
$Res call({
 String id, CardType type, Map<String, String> titles, Map<String, String> descriptions, Map<String, String> flavorTexts, List<String> tags, CardRarity rarity, CardElement element, int? power, int? toughness, String? manaCost, String? imagePath, String? backImagePath, bool isAsset
});




}
/// @nodoc
class _$CardModelCopyWithImpl<$Res>
    implements $CardModelCopyWith<$Res> {
  _$CardModelCopyWithImpl(this._self, this._then);

  final CardModel _self;
  final $Res Function(CardModel) _then;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? titles = null,Object? descriptions = null,Object? flavorTexts = null,Object? tags = null,Object? rarity = null,Object? element = null,Object? power = freezed,Object? toughness = freezed,Object? manaCost = freezed,Object? imagePath = freezed,Object? backImagePath = freezed,Object? isAsset = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CardType,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptions: null == descriptions ? _self.descriptions : descriptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,flavorTexts: null == flavorTexts ? _self.flavorTexts : flavorTexts // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as CardRarity,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as CardElement,power: freezed == power ? _self.power : power // ignore: cast_nullable_to_non_nullable
as int?,toughness: freezed == toughness ? _self.toughness : toughness // ignore: cast_nullable_to_non_nullable
as int?,manaCost: freezed == manaCost ? _self.manaCost : manaCost // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,backImagePath: freezed == backImagePath ? _self.backImagePath : backImagePath // ignore: cast_nullable_to_non_nullable
as String?,isAsset: null == isAsset ? _self.isAsset : isAsset // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CardModel].
extension CardModelPatterns on CardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardModel value)  $default,){
final _that = this;
switch (_that) {
case _CardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardModel value)?  $default,){
final _that = this;
switch (_that) {
case _CardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CardType type,  Map<String, String> titles,  Map<String, String> descriptions,  Map<String, String> flavorTexts,  List<String> tags,  CardRarity rarity,  CardElement element,  int? power,  int? toughness,  String? manaCost,  String? imagePath,  String? backImagePath,  bool isAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardModel() when $default != null:
return $default(_that.id,_that.type,_that.titles,_that.descriptions,_that.flavorTexts,_that.tags,_that.rarity,_that.element,_that.power,_that.toughness,_that.manaCost,_that.imagePath,_that.backImagePath,_that.isAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CardType type,  Map<String, String> titles,  Map<String, String> descriptions,  Map<String, String> flavorTexts,  List<String> tags,  CardRarity rarity,  CardElement element,  int? power,  int? toughness,  String? manaCost,  String? imagePath,  String? backImagePath,  bool isAsset)  $default,) {final _that = this;
switch (_that) {
case _CardModel():
return $default(_that.id,_that.type,_that.titles,_that.descriptions,_that.flavorTexts,_that.tags,_that.rarity,_that.element,_that.power,_that.toughness,_that.manaCost,_that.imagePath,_that.backImagePath,_that.isAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CardType type,  Map<String, String> titles,  Map<String, String> descriptions,  Map<String, String> flavorTexts,  List<String> tags,  CardRarity rarity,  CardElement element,  int? power,  int? toughness,  String? manaCost,  String? imagePath,  String? backImagePath,  bool isAsset)?  $default,) {final _that = this;
switch (_that) {
case _CardModel() when $default != null:
return $default(_that.id,_that.type,_that.titles,_that.descriptions,_that.flavorTexts,_that.tags,_that.rarity,_that.element,_that.power,_that.toughness,_that.manaCost,_that.imagePath,_that.backImagePath,_that.isAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardModel extends CardModel {
  const _CardModel({required this.id, required this.type, final  Map<String, String> titles = const {}, final  Map<String, String> descriptions = const {}, final  Map<String, String> flavorTexts = const {}, final  List<String> tags = const [], this.rarity = CardRarity.common, this.element = CardElement.neutral, this.power, this.toughness, this.manaCost, this.imagePath, this.backImagePath, this.isAsset = true}): _titles = titles,_descriptions = descriptions,_flavorTexts = flavorTexts,_tags = tags,super._();
  factory _CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);

@override final  String id;
@override final  CardType type;
 final  Map<String, String> _titles;
@override@JsonKey() Map<String, String> get titles {
  if (_titles is EqualUnmodifiableMapView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_titles);
}

 final  Map<String, String> _descriptions;
@override@JsonKey() Map<String, String> get descriptions {
  if (_descriptions is EqualUnmodifiableMapView) return _descriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_descriptions);
}

 final  Map<String, String> _flavorTexts;
@override@JsonKey() Map<String, String> get flavorTexts {
  if (_flavorTexts is EqualUnmodifiableMapView) return _flavorTexts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_flavorTexts);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  CardRarity rarity;
@override@JsonKey() final  CardElement element;
@override final  int? power;
@override final  int? toughness;
@override final  String? manaCost;
@override final  String? imagePath;
// Path to front image
@override final  String? backImagePath;
// Special back image for this card/set
@override@JsonKey() final  bool isAsset;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardModelCopyWith<_CardModel> get copyWith => __$CardModelCopyWithImpl<_CardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._descriptions, _descriptions)&&const DeepCollectionEquality().equals(other._flavorTexts, _flavorTexts)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.element, element) || other.element == element)&&(identical(other.power, power) || other.power == power)&&(identical(other.toughness, toughness) || other.toughness == toughness)&&(identical(other.manaCost, manaCost) || other.manaCost == manaCost)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.backImagePath, backImagePath) || other.backImagePath == backImagePath)&&(identical(other.isAsset, isAsset) || other.isAsset == isAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_descriptions),const DeepCollectionEquality().hash(_flavorTexts),const DeepCollectionEquality().hash(_tags),rarity,element,power,toughness,manaCost,imagePath,backImagePath,isAsset);

@override
String toString() {
  return 'CardModel(id: $id, type: $type, titles: $titles, descriptions: $descriptions, flavorTexts: $flavorTexts, tags: $tags, rarity: $rarity, element: $element, power: $power, toughness: $toughness, manaCost: $manaCost, imagePath: $imagePath, backImagePath: $backImagePath, isAsset: $isAsset)';
}


}

/// @nodoc
abstract mixin class _$CardModelCopyWith<$Res> implements $CardModelCopyWith<$Res> {
  factory _$CardModelCopyWith(_CardModel value, $Res Function(_CardModel) _then) = __$CardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, CardType type, Map<String, String> titles, Map<String, String> descriptions, Map<String, String> flavorTexts, List<String> tags, CardRarity rarity, CardElement element, int? power, int? toughness, String? manaCost, String? imagePath, String? backImagePath, bool isAsset
});




}
/// @nodoc
class __$CardModelCopyWithImpl<$Res>
    implements _$CardModelCopyWith<$Res> {
  __$CardModelCopyWithImpl(this._self, this._then);

  final _CardModel _self;
  final $Res Function(_CardModel) _then;

/// Create a copy of CardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? titles = null,Object? descriptions = null,Object? flavorTexts = null,Object? tags = null,Object? rarity = null,Object? element = null,Object? power = freezed,Object? toughness = freezed,Object? manaCost = freezed,Object? imagePath = freezed,Object? backImagePath = freezed,Object? isAsset = null,}) {
  return _then(_CardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CardType,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptions: null == descriptions ? _self._descriptions : descriptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,flavorTexts: null == flavorTexts ? _self._flavorTexts : flavorTexts // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as CardRarity,element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as CardElement,power: freezed == power ? _self.power : power // ignore: cast_nullable_to_non_nullable
as int?,toughness: freezed == toughness ? _self.toughness : toughness // ignore: cast_nullable_to_non_nullable
as int?,manaCost: freezed == manaCost ? _self.manaCost : manaCost // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,backImagePath: freezed == backImagePath ? _self.backImagePath : backImagePath // ignore: cast_nullable_to_non_nullable
as String?,isAsset: null == isAsset ? _self.isAsset : isAsset // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

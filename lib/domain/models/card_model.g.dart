// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardModel _$CardModelFromJson(Map<String, dynamic> json) => _CardModel(
  id: json['id'] as String,
  type: $enumDecode(_$CardTypeEnumMap, json['type']),
  titles:
      (json['titles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  descriptions:
      (json['descriptions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  flavorTexts:
      (json['flavorTexts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  rarity:
      $enumDecodeNullable(_$CardRarityEnumMap, json['rarity']) ??
      CardRarity.common,
  element:
      $enumDecodeNullable(_$CardElementEnumMap, json['element']) ??
      CardElement.neutral,
  power: (json['power'] as num?)?.toInt(),
  toughness: (json['toughness'] as num?)?.toInt(),
  manaCost: json['manaCost'] as String?,
  imagePath: json['imagePath'] as String?,
  backImagePath: json['backImagePath'] as String?,
  isAsset: json['isAsset'] as bool? ?? true,
);

Map<String, dynamic> _$CardModelToJson(_CardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CardTypeEnumMap[instance.type]!,
      'titles': instance.titles,
      'descriptions': instance.descriptions,
      'flavorTexts': instance.flavorTexts,
      'tags': instance.tags,
      'rarity': _$CardRarityEnumMap[instance.rarity]!,
      'element': _$CardElementEnumMap[instance.element]!,
      'power': instance.power,
      'toughness': instance.toughness,
      'manaCost': instance.manaCost,
      'imagePath': instance.imagePath,
      'backImagePath': instance.backImagePath,
      'isAsset': instance.isAsset,
    };

const _$CardTypeEnumMap = {
  CardType.character: 'character',
  CardType.story: 'story',
};

const _$CardRarityEnumMap = {
  CardRarity.common: 'common',
  CardRarity.uncommon: 'uncommon',
  CardRarity.rare: 'rare',
  CardRarity.mythic: 'mythic',
};

const _$CardElementEnumMap = {
  CardElement.fire: 'fire',
  CardElement.water: 'water',
  CardElement.wind: 'wind',
  CardElement.earth: 'earth',
  CardElement.light: 'light',
  CardElement.dark: 'dark',
  CardElement.neutral: 'neutral',
};

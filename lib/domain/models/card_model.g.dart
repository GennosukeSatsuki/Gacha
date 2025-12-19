// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardModel _$CardModelFromJson(Map<String, dynamic> json) => _CardModel(
  id: json['id'] as String,
  type: $enumDecode(_$CardTypeEnumMap, json['type']),
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$CardModelToJson(_CardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CardTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags,
    };

const _$CardTypeEnumMap = {
  CardType.character: 'character',
  CardType.story: 'story',
};

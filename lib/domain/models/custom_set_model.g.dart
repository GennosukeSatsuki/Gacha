// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomSetModel _$CustomSetModelFromJson(Map<String, dynamic> json) =>
    _CustomSetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      directoryPath: json['directoryPath'] as String,
      cards:
          (json['cards'] as List<dynamic>?)
              ?.map(
                (e) => const CardModelConverter().fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CustomSetModelToJson(_CustomSetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'directoryPath': instance.directoryPath,
      'cards': instance.cards.map(const CardModelConverter().toJson).toList(),
    };

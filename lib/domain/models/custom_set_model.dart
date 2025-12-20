import 'package:freezed_annotation/freezed_annotation.dart';
import 'card_model.dart';

part 'custom_set_model.freezed.dart';
part 'custom_set_model.g.dart';

@freezed
abstract class CustomSetModel with _$CustomSetModel {
  const factory CustomSetModel({
    required String id,
    required String name,
    required String directoryPath,
    @CardModelConverter() @Default([]) List<CardModel> cards,
  }) = _CustomSetModel;

  const CustomSetModel._();

  factory CustomSetModel.fromJson(Map<String, dynamic> json) => _$CustomSetModelFromJson(json);
}

class CardModelConverter implements JsonConverter<CardModel, Map<String, dynamic>> {
  const CardModelConverter();

  @override
  CardModel fromJson(Map<String, dynamic> json) => CardModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(CardModel object) => object.toJson();
}

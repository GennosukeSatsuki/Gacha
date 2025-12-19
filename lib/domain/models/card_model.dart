import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

enum CardType {
  character,
  story,
}

@freezed
abstract class CardModel with _$CardModel {
  const factory CardModel({
    required String id,
    required CardType type,
    required String title,
    @Default('') String description,
    @Default([]) List<String> tags,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
}

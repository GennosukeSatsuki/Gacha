import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

enum CardType {
  character,
  story,
}

enum CardRarity {
  common,
  uncommon,
  rare,
  mythic,
}

enum CardElement {
  fire,
  water,
  wind,
  earth,
  light,
  dark,
  neutral,
}

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    required String id,
    required CardType type,
    @Default({}) Map<String, String> titles,
    @Default({}) Map<String, String> descriptions,
    @Default({}) Map<String, String> flavorTexts,
    @Default([]) List<String> tags,
    @Default(CardRarity.common) CardRarity rarity,
    @Default(CardElement.neutral) CardElement element,
    int? power,
    int? toughness,
    String? manaCost,
    String? imagePath,      // Path to front image
    String? backImagePath,  // Special back image for this card/set
    @Default(true) bool isAsset, // true if from assets, false if from local file
  }) = _CardModel;

  const CardModel._();

  // Convenience getters for backward compatibility or simple access
  String get title => _getLocalized(titles, 'Unknown');
  String get description => _getLocalized(descriptions, '');
  String get flavorText => _getLocalized(flavorTexts, '');

  String getDisplayTitle(String locale) => _getLocalized(titles, 'Unknown', preferredLocale: locale);
  String getDisplayDescription(String locale) => _getLocalized(descriptions, '', preferredLocale: locale);
  String getDisplayFlavorText(String locale) => _getLocalized(flavorTexts, '', preferredLocale: locale);

  String _getLocalized(Map<String, String> map, String fallbackValue, {String? preferredLocale}) {
    if (map.isEmpty) return fallbackValue;
    
    // 1. Try preferred locale (e.g. 'ja')
    if (preferredLocale != null && map.containsKey(preferredLocale) && map[preferredLocale]!.isNotEmpty) {
      return map[preferredLocale]!;
    }
    
    // 2. Try English as default fallback
    if (map.containsKey('en') && map['en']!.isNotEmpty) {
      return map['en']!;
    }
    
    // 3. Just return the first one available
    return map.values.firstWhere((v) => v.isNotEmpty, orElse: () => fallbackValue);
  }

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
}

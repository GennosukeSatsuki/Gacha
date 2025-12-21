import 'package:uuid/uuid.dart';

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

class CardModel {
  final String id;
  final CardType type;
  final Map<String, String> titles;
  final Map<String, String> descriptions;
  final Map<String, String> flavorTexts;
  final List<String> tags;
  final CardRarity rarity;
  final CardElement element;
  final int? power;
  final int? toughness;
  final String? manaCost;
  final String? imagePath;      // Path to front image
  final String? backImagePath;  // Special back image for this card/set
  final bool isAsset;           // true if from assets, false if from local file

  const CardModel({
    required this.id,
    required this.type,
    this.titles = const {},
    this.descriptions = const {},
    this.flavorTexts = const {},
    this.tags = const [],
    this.rarity = CardRarity.common,
    this.element = CardElement.neutral,
    this.power,
    this.toughness,
    this.manaCost,
    this.imagePath,
    this.backImagePath,
    this.isAsset = true,
  });

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

  CardModel copyWith({
    String? id,
    CardType? type,
    Map<String, String>? titles,
    Map<String, String>? descriptions,
    Map<String, String>? flavorTexts,
    List<String>? tags,
    CardRarity? rarity,
    CardElement? element,
    int? power,
    int? toughness,
    String? manaCost,
    String? imagePath,
    String? backImagePath,
    bool? isAsset,
  }) {
    return CardModel(
      id: id ?? this.id,
      type: type ?? this.type,
      titles: titles ?? this.titles,
      descriptions: descriptions ?? this.descriptions,
      flavorTexts: flavorTexts ?? this.flavorTexts,
      tags: tags ?? this.tags,
      rarity: rarity ?? this.rarity,
      element: element ?? this.element,
      power: power ?? this.power,
      toughness: toughness ?? this.toughness,
      manaCost: manaCost ?? this.manaCost,
      imagePath: imagePath ?? this.imagePath,
      backImagePath: backImagePath ?? this.backImagePath,
      isAsset: isAsset ?? this.isAsset,
    );
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String? ?? const Uuid().v4(),
      type: CardType.values.firstWhere(
        (e) => e.name == (json['type'] as String?),
        orElse: () => CardType.character,
      ),
      titles: _parseLocalizedField(json['title']),
      descriptions: _parseLocalizedField(json['description']),
      flavorTexts: _parseLocalizedField(json['flavorText']),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      rarity: json['rarity'] != null 
          ? CardRarity.values.firstWhere((e) => e.name == json['rarity'], orElse: () => CardRarity.common)
          : CardRarity.common,
      element: json['element'] != null
          ? CardElement.values.firstWhere((e) => e.name == json['element'], orElse: () => CardElement.neutral)
          : CardElement.neutral,
      power: json['power'] as int?,
      toughness: json['toughness'] as int?,
      manaCost: json['manaCost'] as String?,
      imagePath: json['imagePath'] as String?,
      backImagePath: json['backImagePath'] as String?,
      isAsset: json['isAsset'] as bool? ?? true,
    );
  }

  static Map<String, String> _parseLocalizedField(dynamic value) {
    if (value == null) return {};
    if (value is String) return {'en': value};
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val.toString()));
    }
    return {};
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': titles,
      'description': descriptions,
      'flavorText': flavorTexts,
      'tags': tags,
      'rarity': rarity.name,
      'element': element.name,
      'power': power,
      'toughness': toughness,
      'manaCost': manaCost,
      'imagePath': imagePath,
      'backImagePath': backImagePath,
      'isAsset': isAsset,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardModel &&
        other.id == id &&
        other.type == type &&
        other.title == title &&
        other.description == description &&
        other.flavorText == flavorText &&
        _listEquals(other.tags, tags) &&
        other.rarity == rarity &&
        other.element == element &&
        other.power == power &&
        other.toughness == toughness &&
        other.manaCost == manaCost &&
        other.imagePath == imagePath &&
        other.backImagePath == backImagePath &&
        other.isAsset == isAsset;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      type,
      title,
      description,
      flavorText,
      Object.hashAll(tags),
      rarity,
      element,
      power,
      toughness,
      manaCost,
      imagePath,
      backImagePath,
      isAsset,
    );
  }
// ... rest of the file

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'CardModel(id: $id, type: $type, title: $title, description: $description, flavorText: $flavorText, tags: $tags, rarity: $rarity, element: $element, power: $power, toughness: $toughness, manaCost: $manaCost)';
  }
}

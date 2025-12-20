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
  final String title;
  final String description;
  final String flavorText;
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
    required this.title,
    this.description = '',
    this.flavorText = '',
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

  CardModel copyWith({
    String? id,
    CardType? type,
    String? title,
    String? description,
    String? flavorText,
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
      title: title ?? this.title,
      description: description ?? this.description,
      flavorText: flavorText ?? this.flavorText,
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
      id: json['id'] as String,
      type: CardType.values.firstWhere((e) => e.name == json['type']),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      flavorText: json['flavorText'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      rarity: json['rarity'] != null 
          ? CardRarity.values.firstWhere((e) => e.name == json['rarity'])
          : CardRarity.common,
      element: json['element'] != null
          ? CardElement.values.firstWhere((e) => e.name == json['element'])
          : CardElement.neutral,
      power: json['power'] as int?,
      toughness: json['toughness'] as int?,
      manaCost: json['manaCost'] as String?,
      imagePath: json['imagePath'] as String?,
      backImagePath: json['backImagePath'] as String?,
      isAsset: json['isAsset'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'flavorText': flavorText,
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

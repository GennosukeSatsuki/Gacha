import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../domain/models/card_model.dart';

final gachaRepositoryProvider = Provider((ref) => GachaRepository());

class GachaRepository {
  final _uuid = const Uuid();

  List<CardModel> getPresetCharacters(AppLocalizations l10n) {
    return [
      _createCard(l10n.charDragon, l10n.charDragonDesc, type: CardType.character, element: CardElement.fire, rarity: CardRarity.rare, power: 5, toughness: 5, manaCost: '3RR'),
      _createCard(l10n.charElf, l10n.charElfDesc, type: CardType.character, element: CardElement.wind, rarity: CardRarity.uncommon, power: 1, toughness: 1, manaCost: 'G'),
      _createCard(l10n.charDwarf, l10n.charDwarfDesc, type: CardType.character, element: CardElement.earth, rarity: CardRarity.common, power: 2, toughness: 3, manaCost: '1R'),
      _createCard(l10n.charGoblin, l10n.charGoblinDesc, type: CardType.character, element: CardElement.fire, rarity: CardRarity.common, power: 1, toughness: 1, manaCost: 'R'),
      _createCard(l10n.charGirl, l10n.charGirlDesc, type: CardType.character, element: CardElement.light, rarity: CardRarity.uncommon, power: 2, toughness: 2, manaCost: '1W'),
      _createCard(l10n.charSalaryman, l10n.charSalarymanDesc, type: CardType.character, element: CardElement.neutral, rarity: CardRarity.common, power: 1, toughness: 1, manaCost: '2'),
      _createCard(l10n.charHero, l10n.charHeroDesc, type: CardType.character, element: CardElement.light, rarity: CardRarity.rare, power: 3, toughness: 3, manaCost: '1WW'),
      _createCard(l10n.charDemonKing, l10n.charDemonKingDesc, type: CardType.character, element: CardElement.dark, rarity: CardRarity.mythic, power: 6, toughness: 6, manaCost: '4BB'),
    ];
  }

  List<CardModel> getPresetStories(AppLocalizations l10n) {
    return [
      _createCard(l10n.storyOfficeRomance, l10n.storyOfficeRomanceDesc, type: CardType.story, element: CardElement.light, rarity: CardRarity.common, manaCost: '1W'),
      _createCard(l10n.storyChanceEncounter, l10n.storyChanceEncounterDesc, type: CardType.story, element: CardElement.wind, rarity: CardRarity.common, manaCost: 'U'),
      _createCard(l10n.storyStormyNight, l10n.storyStormyNightDesc, type: CardType.story, element: CardElement.water, rarity: CardRarity.uncommon, manaCost: '2U'),
      _createCard(l10n.storyTimeLeap, l10n.storyTimeLeapDesc, type: CardType.story, element: CardElement.wind, rarity: CardRarity.rare, manaCost: '4UU'),
      _createCard(l10n.storyBetrayal, l10n.storyBetrayalDesc, type: CardType.story, element: CardElement.dark, rarity: CardRarity.uncommon, manaCost: '1B'),
      _createCard(l10n.storyTreasureMap, l10n.storyTreasureMapDesc, type: CardType.story, element: CardElement.earth, rarity: CardRarity.common, manaCost: '1'),
    ];
  }

  List<CardModel> getCustomCards(AppLocalizations l10n) {
    return [
      _createCard(
        l10n.charCrystal, 
        l10n.charCrystalDesc, 
        type: CardType.character, 
        element: CardElement.light, 
        rarity: CardRarity.mythic, 
        power: 0, 
        toughness: 10, 
        manaCost: '5',
        imagePath: 'assets/data/sample_set/images/crystal.png',
        isAsset: true, // For this sample, it's bundled
      ),
    ];
  }

  CardModel _createCard(
    String title, 
    String description, {
    required CardType type,
    required CardElement element,
    required CardRarity rarity,
    int? power,
    int? toughness,
    String? manaCost,
    String? imagePath,
    String? backImagePath,
    bool isAsset = true,
  }) {
    return CardModel(
      id: _uuid.v4(),
      type: type,
      title: title,
      description: description,
      element: element,
      rarity: rarity,
      power: power,
      toughness: toughness,
      manaCost: manaCost,
      imagePath: imagePath,
      backImagePath: backImagePath,
      isAsset: isAsset,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../domain/models/card_model.dart';

final gachaRepositoryProvider = Provider((ref) => GachaRepository());

class GachaRepository {
  final _uuid = const Uuid();

  List<CardModel> getPresetCharacters(AppLocalizations l10n) {
    return [
      _createCard(CardType.character, l10n.charDragon, l10n.charDragonDesc),
      _createCard(CardType.character, l10n.charElf, l10n.charElfDesc),
      _createCard(CardType.character, l10n.charDwarf, l10n.charDwarfDesc),
      _createCard(CardType.character, l10n.charGoblin, l10n.charGoblinDesc),
      _createCard(CardType.character, l10n.charGirl, l10n.charGirlDesc),
      _createCard(CardType.character, l10n.charSalaryman, l10n.charSalarymanDesc),
      _createCard(CardType.character, l10n.charHero, l10n.charHeroDesc),
      _createCard(CardType.character, l10n.charDemonKing, l10n.charDemonKingDesc),
    ];
  }

  List<CardModel> getPresetStories(AppLocalizations l10n) {
    return [
      _createCard(CardType.story, l10n.storyOfficeRomance, l10n.storyOfficeRomanceDesc),
      _createCard(CardType.story, l10n.storyChanceEncounter, l10n.storyChanceEncounterDesc),
      _createCard(CardType.story, l10n.storyStormyNight, l10n.storyStormyNightDesc),
      _createCard(CardType.story, l10n.storyTimeLeap, l10n.storyTimeLeapDesc),
      _createCard(CardType.story, l10n.storyBetrayal, l10n.storyBetrayalDesc),
      _createCard(CardType.story, l10n.storyTreasureMap, l10n.storyTreasureMapDesc),
    ];
  }

  CardModel _createCard(CardType type, String title, String description) {
    return CardModel(
      id: _uuid.v4(),
      type: type,
      title: title,
      description: description,
    );
  }
}

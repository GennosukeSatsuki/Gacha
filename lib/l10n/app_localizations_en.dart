// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Idea Mixer';

  @override
  String get gachaPrompt => 'Press the button to draw inspiration!';

  @override
  String get spinButton => 'SPIN GACHA';

  @override
  String get charDragon => 'Dragon';

  @override
  String get charDragonDesc =>
      'A legendary creature living since ancient times. Wise but greedy.';

  @override
  String get charElf => 'Elf';

  @override
  String get charElfDesc =>
      'Guardian of the forest. Master archer and long-lived.';

  @override
  String get charDwarf => 'Dwarf';

  @override
  String get charDwarfDesc =>
      'Blacksmith living underground. Stubborn and loves alcohol.';

  @override
  String get charGoblin => 'Goblin';

  @override
  String get charGoblinDesc => 'Cunning monster. Acts in groups.';

  @override
  String get charGirl => 'High School Girl';

  @override
  String get charGirlDesc =>
      'Symbol of modern times. Loves tapioca and social media.';

  @override
  String get charSalaryman => 'Salaryman';

  @override
  String get charSalarymanDesc =>
      'Tired office worker. Might be an isekai protagonist.';

  @override
  String get charHero => 'Hero';

  @override
  String get charHeroDesc => 'Young person fated to defeat the Demon King.';

  @override
  String get charDemonKing => 'Demon King';

  @override
  String get charDemonKingDesc =>
      'Existence that strikes fear into the world. Actually lonely.';

  @override
  String get storyOfficeRomance => 'Office Romance';

  @override
  String get storyOfficeRomanceDesc =>
      'Romance in an unexpected place. Secret from others.';

  @override
  String get storyChanceEncounter => 'Chance Encounter';

  @override
  String get storyChanceEncounterDesc =>
      'Bumping into someone on the street starts fate.';

  @override
  String get storyStormyNight => 'Stormy Night';

  @override
  String get storyStormyNightDesc => 'Something happens in a closed space.';

  @override
  String get storyTimeLeap => 'Time Leap';

  @override
  String get storyTimeLeapDesc => 'Repeating time to change the future.';

  @override
  String get storyBetrayal => 'Betrayal';

  @override
  String get storyBetrayalDesc => 'Unexpected action from a trusted ally.';

  @override
  String get storyTreasureMap => 'Treasure Map';

  @override
  String get storyTreasureMapDesc =>
      'Beginning of an adventure for hidden treasure.';

  @override
  String get typeCreature => 'Creature';

  @override
  String get typeSorcery => 'Sorcery';

  @override
  String get settings => 'Settings';

  @override
  String get gachaSettings => 'Gacha Settings';

  @override
  String get characterCount => 'Character Count';

  @override
  String get characterCountDesc => 'Number of characters per gacha pull';

  @override
  String get storyCount => 'Story Count';

  @override
  String get storyCountDesc => 'Number of stories per gacha pull';

  @override
  String get revealAll => 'REVEAL ALL';

  @override
  String get clear => 'Clear';

  @override
  String get language => 'Language';

  @override
  String get japanese => 'Japanese';

  @override
  String get english => 'English';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get license => 'License';

  @override
  String get github => 'GitHub';

  @override
  String get basicSettings => 'Basic Settings';

  @override
  String get cardSettings => 'Card Settings';

  @override
  String get general => 'General';

  @override
  String get emissionSettings => 'Emission Settings';

  @override
  String get includeDefaultSet => 'Include Default Set';

  @override
  String get includeDefaultSetDesc =>
      'Include built-in sample cards in gacha pulls';

  @override
  String get importedSets => 'Imported Sets';

  @override
  String get noImportedSets => 'No imported sets';

  @override
  String cardCountLabel(int count) {
    return '$count cards';
  }

  @override
  String get import => 'Import';

  @override
  String get importCustomSet => 'Import Custom Set';

  @override
  String get selectManifestJson => 'Please select manifest.json';

  @override
  String get importSuccess => 'Successfully imported';

  @override
  String importError(Object error) {
    return 'Error: $error';
  }

  @override
  String get charCrystal => 'Mysterious Crystal';

  @override
  String get charCrystalDesc =>
      'A giant crystal floating in the deepest part of the cave. Amplifies the inspiration of those who see it.';

  @override
  String get elementFire => 'Fire';

  @override
  String get elementWater => 'Water';

  @override
  String get elementWind => 'Wind';

  @override
  String get elementEarth => 'Earth';

  @override
  String get elementLight => 'Light';

  @override
  String get elementDark => 'Dark';

  @override
  String get elementNeutral => 'Neutral';
}

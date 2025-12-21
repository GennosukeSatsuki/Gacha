import 'package:plot_mixer/l10n/app_localizations.dart';

class L10nUtils {
  static String getLocalizedText(String? key, AppLocalizations l10n) {
    if (key == null) return '';
    
    switch (key) {
      case 'charDragon': return l10n.charDragon;
      case 'charDragonDesc': return l10n.charDragonDesc;
      case 'charElf': return l10n.charElf;
      case 'charElfDesc': return l10n.charElfDesc;
      case 'charDwarf': return l10n.charDwarf;
      case 'charDwarfDesc': return l10n.charDwarfDesc;
      case 'charGoblin': return l10n.charGoblin;
      case 'charGoblinDesc': return l10n.charGoblinDesc;
      case 'charGirl': return l10n.charGirl;
      case 'charGirlDesc': return l10n.charGirlDesc;
      case 'charSalaryman': return l10n.charSalaryman;
      case 'charSalarymanDesc': return l10n.charSalarymanDesc;
      case 'charHero': return l10n.charHero;
      case 'charHeroDesc': return l10n.charHeroDesc;
      case 'charDemonKing': return l10n.charDemonKing;
      case 'charDemonKingDesc': return l10n.charDemonKingDesc;
      case 'storyOfficeRomance': return l10n.storyOfficeRomance;
      case 'storyOfficeRomanceDesc': return l10n.storyOfficeRomanceDesc;
      case 'storyChanceEncounter': return l10n.storyChanceEncounter;
      case 'storyChanceEncounterDesc': return l10n.storyChanceEncounterDesc;
      case 'storyStormyNight': return l10n.storyStormyNight;
      case 'storyStormyNightDesc': return l10n.storyStormyNightDesc;
      case 'storyTimeLeap': return l10n.storyTimeLeap;
      case 'storyTimeLeapDesc': return l10n.storyTimeLeapDesc;
      case 'storyBetrayal': return l10n.storyBetrayal;
      case 'storyBetrayalDesc': return l10n.storyBetrayalDesc;
      case 'storyTreasureMap': return l10n.storyTreasureMap;
      case 'storyTreasureMapDesc': return l10n.storyTreasureMapDesc;
      default: return key;
    }
  }
}

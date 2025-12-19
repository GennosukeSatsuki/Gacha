import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Idea Mixer'**
  String get appTitle;

  /// No description provided for @gachaPrompt.
  ///
  /// In en, this message translates to:
  /// **'Press the button to draw inspiration!'**
  String get gachaPrompt;

  /// No description provided for @spinButton.
  ///
  /// In en, this message translates to:
  /// **'SPIN GACHA'**
  String get spinButton;

  /// No description provided for @charDragon.
  ///
  /// In en, this message translates to:
  /// **'Dragon'**
  String get charDragon;

  /// No description provided for @charDragonDesc.
  ///
  /// In en, this message translates to:
  /// **'A legendary creature living since ancient times. Wise but greedy.'**
  String get charDragonDesc;

  /// No description provided for @charElf.
  ///
  /// In en, this message translates to:
  /// **'Elf'**
  String get charElf;

  /// No description provided for @charElfDesc.
  ///
  /// In en, this message translates to:
  /// **'Guardian of the forest. Master archer and long-lived.'**
  String get charElfDesc;

  /// No description provided for @charDwarf.
  ///
  /// In en, this message translates to:
  /// **'Dwarf'**
  String get charDwarf;

  /// No description provided for @charDwarfDesc.
  ///
  /// In en, this message translates to:
  /// **'Blacksmith living underground. Stubborn and loves alcohol.'**
  String get charDwarfDesc;

  /// No description provided for @charGoblin.
  ///
  /// In en, this message translates to:
  /// **'Goblin'**
  String get charGoblin;

  /// No description provided for @charGoblinDesc.
  ///
  /// In en, this message translates to:
  /// **'Cunning monster. Acts in groups.'**
  String get charGoblinDesc;

  /// No description provided for @charGirl.
  ///
  /// In en, this message translates to:
  /// **'High School Girl'**
  String get charGirl;

  /// No description provided for @charGirlDesc.
  ///
  /// In en, this message translates to:
  /// **'Symbol of modern times. Loves tapioca and social media.'**
  String get charGirlDesc;

  /// No description provided for @charSalaryman.
  ///
  /// In en, this message translates to:
  /// **'Salaryman'**
  String get charSalaryman;

  /// No description provided for @charSalarymanDesc.
  ///
  /// In en, this message translates to:
  /// **'Tired office worker. Might be an isekai protagonist.'**
  String get charSalarymanDesc;

  /// No description provided for @charHero.
  ///
  /// In en, this message translates to:
  /// **'Hero'**
  String get charHero;

  /// No description provided for @charHeroDesc.
  ///
  /// In en, this message translates to:
  /// **'Young person fated to defeat the Demon King.'**
  String get charHeroDesc;

  /// No description provided for @charDemonKing.
  ///
  /// In en, this message translates to:
  /// **'Demon King'**
  String get charDemonKing;

  /// No description provided for @charDemonKingDesc.
  ///
  /// In en, this message translates to:
  /// **'Existence that strikes fear into the world. Actually lonely.'**
  String get charDemonKingDesc;

  /// No description provided for @storyOfficeRomance.
  ///
  /// In en, this message translates to:
  /// **'Office Romance'**
  String get storyOfficeRomance;

  /// No description provided for @storyOfficeRomanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Romance in an unexpected place. Secret from others.'**
  String get storyOfficeRomanceDesc;

  /// No description provided for @storyChanceEncounter.
  ///
  /// In en, this message translates to:
  /// **'Chance Encounter'**
  String get storyChanceEncounter;

  /// No description provided for @storyChanceEncounterDesc.
  ///
  /// In en, this message translates to:
  /// **'Bumping into someone on the street starts fate.'**
  String get storyChanceEncounterDesc;

  /// No description provided for @storyStormyNight.
  ///
  /// In en, this message translates to:
  /// **'Stormy Night'**
  String get storyStormyNight;

  /// No description provided for @storyStormyNightDesc.
  ///
  /// In en, this message translates to:
  /// **'Something happens in a closed space.'**
  String get storyStormyNightDesc;

  /// No description provided for @storyTimeLeap.
  ///
  /// In en, this message translates to:
  /// **'Time Leap'**
  String get storyTimeLeap;

  /// No description provided for @storyTimeLeapDesc.
  ///
  /// In en, this message translates to:
  /// **'Repeating time to change the future.'**
  String get storyTimeLeapDesc;

  /// No description provided for @storyBetrayal.
  ///
  /// In en, this message translates to:
  /// **'Betrayal'**
  String get storyBetrayal;

  /// No description provided for @storyBetrayalDesc.
  ///
  /// In en, this message translates to:
  /// **'Unexpected action from a trusted ally.'**
  String get storyBetrayalDesc;

  /// No description provided for @storyTreasureMap.
  ///
  /// In en, this message translates to:
  /// **'Treasure Map'**
  String get storyTreasureMap;

  /// No description provided for @storyTreasureMapDesc.
  ///
  /// In en, this message translates to:
  /// **'Beginning of an adventure for hidden treasure.'**
  String get storyTreasureMapDesc;

  /// No description provided for @typeCreature.
  ///
  /// In en, this message translates to:
  /// **'Creature'**
  String get typeCreature;

  /// No description provided for @typeSorcery.
  ///
  /// In en, this message translates to:
  /// **'Sorcery'**
  String get typeSorcery;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GachaSettings {
  final int characterCount;
  final int storyCount;
  final String locale; // 'en' or 'ja'
  final bool includeDefaultSet;

  const GachaSettings({
    required this.characterCount,
    required this.storyCount,
    required this.locale,
    this.includeDefaultSet = true,
  });

  GachaSettings copyWith({
    int? characterCount,
    int? storyCount,
    String? locale,
    bool? includeDefaultSet,
  }) {
    return GachaSettings(
      characterCount: characterCount ?? this.characterCount,
      storyCount: storyCount ?? this.storyCount,
      locale: locale ?? this.locale,
      includeDefaultSet: includeDefaultSet ?? this.includeDefaultSet,
    );
  }

  int get totalCount => characterCount + storyCount;
}

final gachaSettingsProvider = NotifierProvider<GachaSettingsNotifier, GachaSettings>(
  GachaSettingsNotifier.new,
);

class GachaSettingsNotifier extends Notifier<GachaSettings> {
  static const String _keyCharacterCount = 'gacha_character_count';
  static const String _keyStoryCount = 'gacha_story_count';
  static const String _keyLocale = 'gacha_locale';
  static const String _keyIncludeDefaultSet = 'gacha_include_default_set';

  @override
  GachaSettings build() {
    _loadSettings();
    return const GachaSettings(
      characterCount: 2,
      storyCount: 1,
      locale: 'ja',
      includeDefaultSet: true,
    );
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final characterCount = prefs.getInt(_keyCharacterCount) ?? 2;
    final storyCount = prefs.getInt(_keyStoryCount) ?? 1;
    final locale = prefs.getString(_keyLocale) ?? 'ja';
    final includeDefaultSet = prefs.getBool(_keyIncludeDefaultSet) ?? true;
    
    state = GachaSettings(
      characterCount: characterCount,
      storyCount: storyCount,
      locale: locale,
      includeDefaultSet: includeDefaultSet,
    );
  }

  Future<void> setCharacterCount(int count) async {
    final maxAllowed = 10 - state.storyCount;
    final newCount = count.clamp(0, maxAllowed);
    
    state = state.copyWith(characterCount: newCount);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCharacterCount, newCount);
  }

  Future<void> setStoryCount(int count) async {
    final maxAllowed = 10 - state.characterCount;
    final newCount = count.clamp(0, maxAllowed);
    
    state = state.copyWith(storyCount: newCount);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyStoryCount, newCount);
  }

  Future<void> setLocale(String locale) async {
    state = state.copyWith(locale: locale);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale);
  }

  Future<void> setIncludeDefaultSet(bool include) async {
    state = state.copyWith(includeDefaultSet: include);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIncludeDefaultSet, include);
  }
}

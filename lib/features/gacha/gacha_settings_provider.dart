import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GachaSettings {
  final int characterCount;
  final int storyCount;

  const GachaSettings({
    required this.characterCount,
    required this.storyCount,
  });

  GachaSettings copyWith({
    int? characterCount,
    int? storyCount,
  }) {
    return GachaSettings(
      characterCount: characterCount ?? this.characterCount,
      storyCount: storyCount ?? this.storyCount,
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

  @override
  GachaSettings build() {
    _loadSettings();
    return const GachaSettings(
      characterCount: 2,
      storyCount: 1,
    );
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final characterCount = prefs.getInt(_keyCharacterCount) ?? 2;
    final storyCount = prefs.getInt(_keyStoryCount) ?? 1;
    
    state = GachaSettings(
      characterCount: characterCount,
      storyCount: storyCount,
    );
  }

  Future<void> setCharacterCount(int count) async {
    // 合計が10枚を超えないように制限
    final maxAllowed = 10 - state.storyCount;
    final newCount = count.clamp(0, maxAllowed);
    
    state = state.copyWith(characterCount: newCount);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCharacterCount, newCount);
  }

  Future<void> setStoryCount(int count) async {
    // 合計が10枚を超えないように制限
    final maxAllowed = 10 - state.characterCount;
    final newCount = count.clamp(0, maxAllowed);
    
    state = state.copyWith(storyCount: newCount);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyStoryCount, newCount);
  }
}

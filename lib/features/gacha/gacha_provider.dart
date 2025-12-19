import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../data/repositories/gacha_repository.dart';
import '../../domain/models/card_model.dart';

final gachaControllerProvider = NotifierProvider<GachaController, List<CardModel>>(GachaController.new);

class GachaController extends Notifier<List<CardModel>> {
  final Random _random = Random();

  @override
  List<CardModel> build() {
    return [];
  }

  // Default configuration: 2 Characters, 1 Story
  void spin(AppLocalizations l10n, {int charCount = 2, int storyCount = 1}) {
    final repository = ref.read(gachaRepositoryProvider);
    final allChars = repository.getPresetCharacters(l10n);
    final allStories = repository.getPresetStories(l10n);

    final selectedChars = _pickRandom(allChars, charCount);
    final selectedStories = _pickRandom(allStories, storyCount);

    state = [...selectedChars, ...selectedStories];
  }

  List<CardModel> _pickRandom(List<CardModel> source, int count) {
    if (source.isEmpty) return [];
    
    // Shuffle copy to avoid mutating original list
    final shuffled = List<CardModel>.from(source)..shuffle(_random);
    return shuffled.take(count).toList();
  }
  
  void clear() {
    state = [];
  }
}

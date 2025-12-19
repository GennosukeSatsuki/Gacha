import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../data/repositories/gacha_repository.dart';
import '../../domain/models/card_model.dart';
import 'gacha_card_state.dart';
import 'gacha_settings_provider.dart';

final gachaControllerProvider = NotifierProvider<GachaController, List<GachaCardState>>(GachaController.new);

class GachaController extends Notifier<List<GachaCardState>> {
  // Use cryptographically secure random for unbiased card selection
  final Random _random = Random.secure();

  @override
  List<GachaCardState> build() {
    return [];
  }

  // Use settings from gachaSettingsProvider
  void spin(AppLocalizations l10n) {
    final settings = ref.read(gachaSettingsProvider);
    final repository = ref.read(gachaRepositoryProvider);
    final allChars = repository.getPresetCharacters(l10n);
    final allStories = repository.getPresetStories(l10n);

    final selectedChars = _pickRandom(allChars, settings.characterCount);
    final selectedStories = _pickRandom(allStories, settings.storyCount);

    final allCards = [...selectedChars, ...selectedStories];
    
    // Initialize all cards as face down
    state = allCards.asMap().entries.map((entry) {
      return GachaCardState(
        card: entry.value,
        revealState: CardRevealState.faceDown,
        index: entry.key,
      );
    }).toList();
  }

  List<CardModel> _pickRandom(List<CardModel> source, int count) {
    if (source.isEmpty) return [];
    
    // Shuffle copy to avoid mutating original list
    final shuffled = List<CardModel>.from(source)..shuffle(_random);
    return shuffled.take(count).toList();
  }
  
  void revealCard(int index) {
    if (index < 0 || index >= state.length) return;
    
    final updatedState = [...state];
    final currentCard = updatedState[index];
    
    // Only reveal if face down
    if (currentCard.revealState == CardRevealState.faceDown) {
      updatedState[index] = currentCard.copyWith(revealState: CardRevealState.revealed);
      state = updatedState;
    }
  }
  
  void clear() {
    state = [];
  }
}

import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../data/repositories/gacha_repository.dart';
import '../../domain/models/card_model.dart';
import 'gacha_card_state.dart';

final gachaControllerProvider = NotifierProvider<GachaController, List<GachaCardState>>(GachaController.new);

class GachaController extends Notifier<List<GachaCardState>> {
  final Random _random = Random();

  @override
  List<GachaCardState> build() {
    return [];
  }

  // Default configuration: 2 Characters, 1 Story
  void spin(AppLocalizations l10n, {int charCount = 2, int storyCount = 1}) {
    final repository = ref.read(gachaRepositoryProvider);
    final allChars = repository.getPresetCharacters(l10n);
    final allStories = repository.getPresetStories(l10n);

    final selectedChars = _pickRandom(allChars, charCount);
    final selectedStories = _pickRandom(allStories, storyCount);

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

import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../domain/models/card_model.dart';
import 'gacha_card_state.dart';
import 'gacha_settings_provider.dart';
import 'custom_card_provider.dart';

final gachaControllerProvider = NotifierProvider<GachaController, List<GachaCardState>>(GachaController.new);

class GachaController extends Notifier<List<GachaCardState>> {
  final Random _random = Random.secure();

  @override
  List<GachaCardState> build() {
    return [];
  }

  void spin(AppLocalizations l10n) {
    final settings = ref.read(gachaSettingsProvider);
    
    // Get all custom cards (including default_set which is now there)
    final allCustomCards = ref.read(customCardProvider);
    
    List<CardModel> characters = [];
    List<CardModel> stories = [];
    
    for (final cardSet in allCustomCards) {
      // Skip default_set if not included in settings
      if (cardSet.id == 'default_set' && !settings.includeDefaultSet) {
        continue;
      }
      
      for (final card in cardSet.cards) {
        if (card.type == CardType.character) {
          characters.add(card);
        } else if (card.type == CardType.story) {
          stories.add(card);
        }
      }
    }
    
    final selectedChars = _pickRandom(characters, settings.characterCount);
    final selectedStories = _pickRandom(stories, settings.storyCount);

    final allCards = [...selectedChars, ...selectedStories];
    
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
    
    final shuffled = List<CardModel>.from(source)..shuffle(_random);
    return shuffled.take(count).toList();
  }
  
  void revealCard(int index) {
    if (index < 0 || index >= state.length) return;
    
    final updatedState = [...state];
    final currentCard = updatedState[index];
    
    if (currentCard.revealState == CardRevealState.faceDown) {
      updatedState[index] = currentCard.copyWith(revealState: CardRevealState.revealed);
      state = updatedState;
    }
  }
  
  void clear() {
    state = [];
  }
}

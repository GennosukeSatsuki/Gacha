import '../../domain/models/card_model.dart';

enum CardRevealState {
  faceDown,    // 伏せている
  revealed,    // めくられた
}

class GachaCardState {
  final CardModel card;
  final CardRevealState revealState;
  final int index;

  const GachaCardState({
    required this.card,
    required this.revealState,
    required this.index,
  });

  GachaCardState copyWith({
    CardModel? card,
    CardRevealState? revealState,
    int? index,
  }) {
    return GachaCardState(
      card: card ?? this.card,
      revealState: revealState ?? this.revealState,
      index: index ?? this.index,
    );
  }
}

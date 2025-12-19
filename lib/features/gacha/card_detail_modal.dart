import 'package:flutter/material.dart';
import '../../domain/models/card_model.dart';
import 'card_widget.dart';

class CardDetailModal extends StatelessWidget {
  final CardModel card;

  const CardDetailModal({
    super.key,
    required this.card,
  });

  static void show(BuildContext context, CardModel card) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => CardDetailModal(card: card),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // タップで閉じる（背景全体）
      onTap: () => Navigator.of(context).pop(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(40),
        child: GestureDetector(
          // カード自体のタップイベントを親に伝播させない
          onTap: () => Navigator.of(context).pop(),
          child: Center(
            child: Hero(
              tag: 'card_detail_${card.id}',
              child: Material(
                color: Colors.transparent,
                child: CardWidget(
                  card: card,
                  width: 350,
                  height: 490,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

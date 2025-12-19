import 'package:flutter/material.dart';
import '../../domain/models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Distinct visual for Character vs Story
    final cardColor = card.type == CardType.character
        ? colorScheme.primaryContainer
        : colorScheme.secondaryContainer;

    final textColor = card.type == CardType.character
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSecondaryContainer;

    final icon = card.type == CardType.character
        ? Icons.person
        : Icons.auto_stories;

    return Card(
      color: cardColor,
      child: Container(
        width: 160,
        height: 220,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: textColor),
            const SizedBox(height: 16),
            Text(
              card.title,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                card.description,
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8)),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

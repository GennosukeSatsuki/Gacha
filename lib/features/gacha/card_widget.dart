import 'package:flutter/material.dart';
import '../../domain/models/card_model.dart';
import '../../../core/utils/l10n_utils.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/card_components.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;
  final double width;
  final double height;
  final VoidCallback? onArtTap;

  const CardWidget({
    super.key,
    required this.card,
    this.width = 280,
    this.height = 400,
    this.onArtTap,
  });

  @override
  Widget build(BuildContext context) {
    final scaleFactor = width / 280; // Base width is 280
    final locale = Localizations.localeOf(context).languageCode;
    
    // Create a temporary "localized" model for the child components to use.
    // They usually access .title / .description which our new getters handle.
    // To ensure they get the correct one, we'll create a copy where the 
    // current locale is explicitly set as the 'en' (default fallback) key.
    final localizedCard = card.copyWith(
      titles: {'en': card.getDisplayTitle(locale)},
      descriptions: {'en': card.getDisplayDescription(locale)},
      flavorTexts: {'en': card.getDisplayFlavorText(locale)},
    );
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14 * scaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10 * scaleFactor,
            offset: Offset(4 * scaleFactor, 4 * scaleFactor),
          ),
        ],
      ),
      padding: EdgeInsets.all(10 * scaleFactor), // The black border
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 280,
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                color: _getElementColor(card.element),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Column(
                children: [
                  // Name Header
                  CardHeader(card: localizedCard, scaleFactor: 1.0),
                  
                  // Art Frame
                  ArtFrame(card: localizedCard, scaleFactor: 1.0, onTap: onArtTap),
                  
                  // Type Line
                  TypeLine(card: localizedCard, scaleFactor: 1.0),
                  
                  // Text Box & P/T Box Area
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: TextBox(card: localizedCard, scaleFactor: 1.0),
                        ),
                        // P/T Box (only for characters)
                        if (card.type == CardType.character && card.power != null)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: PowerToughnessBox(card: localizedCard, scaleFactor: 1.0),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getElementColor(CardElement element) {
    switch (element) {
      case CardElement.fire:
        return const Color(0xFFE49977); // Red/Orange frame
      case CardElement.water:
        return const Color(0xFFABC5D4); // Blue frame
      case CardElement.wind:
        return const Color(0xFF98AA7E); // Green frame
      case CardElement.earth:
        return const Color(0xFFC7B197); // Brown frame
      case CardElement.light:
        return const Color(0xFFE9E5D3); // White frame
      case CardElement.dark:
        return const Color(0xFFADADAD); // Black/Grey frame
      case CardElement.neutral:
        return const Color(0xFFC0C0C0); // Artifact frame
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../domain/models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;
  final double width;
  final double height;

  const CardWidget({
    super.key,
    required this.card,
    this.width = 280,
    this.height = 400,
  });

  @override
  Widget build(BuildContext context) {
    final scaleFactor = width / 280; // Base width is 280
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14 * scaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
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
                  _CardHeader(card: card, scaleFactor: 1.0),
                  
                  // Art Frame
                  _ArtFrame(card: card, scaleFactor: 1.0),
                  
                  // Type Line
                  _TypeLine(card: card, scaleFactor: 1.0),
                  
                  // Text Box
                  Expanded(
                    child: _TextBox(card: card, scaleFactor: 1.0),
                  ),
                  
                  // P/T Box (only for characters)
                  if (card.type == CardType.character && card.power != null)
                    _PowerToughnessBox(card: card, scaleFactor: 1.0),
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

class _CardHeader extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const _CardHeader({required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6 * scaleFactor, 6 * scaleFactor, 6 * scaleFactor, 0),
      padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor, vertical: 4 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4 * scaleFactor),
        border: Border.all(color: Colors.black54),
        gradient: LinearGradient(
          colors: [Colors.white70, Colors.white.withValues(alpha: 0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              card.title,
              style: GoogleFonts.notoSerif(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (card.manaCost != null)
            Text(
              card.manaCost!,
              style: GoogleFonts.philosopher(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
        ],
      ),
    );
  }
}

class _ArtFrame extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const _ArtFrame({required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6 * scaleFactor),
      height: 160 * scaleFactor,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black87, width: 2 * scaleFactor),
      ),
      child: Center(
        child: Icon(
          card.type == CardType.character ? Icons.person : Icons.auto_stories,
          size: 60 * scaleFactor,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class _TypeLine extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const _TypeLine({required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final typeStr = card.type == CardType.character ? l10n.typeCreature : l10n.typeSorcery;
    final elementStr = card.element.name[0].toUpperCase() + card.element.name.substring(1);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6 * scaleFactor),
      padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor, vertical: 3 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4 * scaleFactor),
        border: Border.all(color: Colors.black54),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$typeStr — $elementStr",
            style: GoogleFonts.notoSerif(
              fontSize: 12 * scaleFactor,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          _RarityIcon(rarity: card.rarity, scaleFactor: scaleFactor),
        ],
      ),
    );
  }
}

class _RarityIcon extends StatelessWidget {
  final CardRarity rarity;
  final double scaleFactor;
  const _RarityIcon({required this.rarity, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (rarity) {
      case CardRarity.common:
        color = Colors.black;
      case CardRarity.uncommon:
        color = const Color(0xFF708090); // SlateGrey
      case CardRarity.rare:
        color = const Color(0xFFD4AF37); // Gold
      case CardRarity.mythic:
        color = const Color(0xFFFF4500); // orange-red
    }
    return Container(
      width: 14 * scaleFactor,
      height: 14 * scaleFactor,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black87, width: 1 * scaleFactor),
      ),
    );
  }
}

class _TextBox extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const _TextBox({required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6 * scaleFactor, 4 * scaleFactor, 6 * scaleFactor, 6 * scaleFactor),
      padding: EdgeInsets.all(8 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        border: Border.all(color: Colors.black45),
        image: DecorationImage(
          image: const AssetImage('assets/images/texture_paper.png'), // Future enhancement
          fit: BoxFit.cover,
          opacity: 0.1,
          onError: (_, __) {},
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.description,
            style: GoogleFonts.notoSerif(
              fontSize: 12 * scaleFactor,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          if (card.flavorText.isNotEmpty) ...[
            const Spacer(),
            const Divider(color: Colors.black26),
            Text(
              card.flavorText,
              style: GoogleFonts.notoSerif(
                fontSize: 11 * scaleFactor,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PowerToughnessBox extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const _PowerToughnessBox({required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(right: 8 * scaleFactor, bottom: 8 * scaleFactor),
        padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 4 * scaleFactor),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(4 * scaleFactor),
          border: Border.all(color: Colors.black87, width: 1.5 * scaleFactor),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2 * scaleFactor, offset: Offset(2 * scaleFactor, 2 * scaleFactor)),
          ],
        ),
        child: Text(
          "${card.power}/${card.toughness}",
          style: GoogleFonts.philosopher(
            fontSize: 14 * scaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

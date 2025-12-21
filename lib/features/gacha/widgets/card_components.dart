import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../../core/utils/l10n_utils.dart';
import '../../../domain/models/card_model.dart';

class CardHeader extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const CardHeader({super.key, required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayTitle = L10nUtils.getLocalizedText(card.title, l10n);

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
              displayTitle,
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

class ArtFrame extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  final VoidCallback? onTap;

  const ArtFrame({
    super.key,
    required this.card,
    this.scaleFactor = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget? artContent;

    if (card.imagePath != null) {
      if (card.isAsset) {
        artContent = Image.asset(
          card.imagePath!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        artContent = Image.file(
          File(card.imagePath!),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      }
    }

    final frame = Container(
      margin: EdgeInsets.all(6 * scaleFactor),
      height: 160 * scaleFactor,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black87, width: 2 * scaleFactor),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: artContent ?? _buildPlaceholder(),
          ),
          if (onTap != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white.withOpacity(0.5),
                      size: 32 * scaleFactor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return frame;
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        card.type == CardType.character ? Icons.person : Icons.auto_stories,
        size: 60 * scaleFactor,
        color: Colors.black26,
      ),
    );
  }
}

class TypeLine extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const TypeLine({super.key, required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final typeStr = L10nUtils.getCardTypeLabel(card.type, l10n);
    final elementStr = L10nUtils.getElementLabel(card.element, l10n);

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
          RarityIcon(rarity: card.rarity, scaleFactor: scaleFactor),
        ],
      ),
    );
  }
}

class RarityIcon extends StatelessWidget {
  final CardRarity rarity;
  final double scaleFactor;
  const RarityIcon({super.key, required this.rarity, this.scaleFactor = 1.0});

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

class TextBox extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const TextBox({super.key, required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayDesc = L10nUtils.getLocalizedText(card.description, l10n);
    final displayFlavor = L10nUtils.getLocalizedText(card.flavorText, l10n);

    return Container(
      margin: EdgeInsets.all(6 * scaleFactor),
      padding: EdgeInsets.all(8 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        border: Border.all(color: Colors.black45),
        image: DecorationImage(
          image: const AssetImage('assets/images/texture_paper.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
          onError: (_, __) {},
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use a fixed area for the main description
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(), // Cards shouldn't scroll usually, just fit
              child: Text(
                displayDesc,
                style: GoogleFonts.notoSerif(
                  fontSize: 12 * scaleFactor,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ),
          ),
          if (displayFlavor.isNotEmpty) ...[
            const Divider(color: Colors.black26, height: 8),
            Expanded(
              flex: 1,
              child: Text(
                displayFlavor,
                style: GoogleFonts.notoSerif(
                  fontSize: 11 * scaleFactor,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ] else
            const Spacer(), // Ensure the column fills space even without flavor text
        ],
      ),
    );
  }
}

class PowerToughnessBox extends StatelessWidget {
  final CardModel card;
  final double scaleFactor;
  const PowerToughnessBox({super.key, required this.card, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Margin adjusted for Stack positioning
      margin: EdgeInsets.only(right: 4 * scaleFactor, bottom: 4 * scaleFactor),
      padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 4 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(4 * scaleFactor),
        border: Border.all(color: Colors.black87, width: 1.5 * scaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black26, 
            blurRadius: 4 * scaleFactor, 
            offset: Offset(2 * scaleFactor, 2 * scaleFactor)
          ),
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
    );
  }
}

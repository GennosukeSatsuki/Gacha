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

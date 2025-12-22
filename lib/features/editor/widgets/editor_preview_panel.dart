import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea_mixer/l10n/app_localizations.dart';
import '../../../domain/models/card_model.dart';
import '../../gacha/card_widget.dart';

class EditorPreviewPanel extends StatelessWidget {
  final CardModel card;
  final VoidCallback onArtTap;

  const EditorPreviewPanel({
    super.key,
    required this.card,
    required this.onArtTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: Colors.black12,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.preview,
              style: GoogleFonts.philosopher(
                color: Colors.white24,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CardWidget(
              card: card, 
              width: 220, 
              height: 320,
              onArtTap: onArtTap,
            ),
          ],
        ),
      ),
    );
  }
}

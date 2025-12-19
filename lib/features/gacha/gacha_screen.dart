import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'gacha_provider.dart';
import 'gacha_card_state.dart';
import 'animated_gacha_card.dart';
import 'card_detail_modal.dart';

class GachaScreen extends ConsumerWidget {
  const GachaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardStates = ref.watch(gachaControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: GoogleFonts.philosopher(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (cardStates.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(gachaControllerProvider.notifier).clear();
              },
              tooltip: 'Clear',
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.blueGrey.withValues(alpha: 0.2),
              Colors.black,
            ],
            center: Alignment.center,
            radius: 1.5,
          ),
        ),
        child: Column(
          children: [
            // Result Display Area
            Expanded(
              child: cardStates.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome, size: 64, color: Colors.amber.withValues(alpha: 0.5)),
                          const SizedBox(height: 16),
                          Text(
                            l10n.gachaPrompt,
                            style: GoogleFonts.notoSerif(
                              fontSize: 18, 
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        // Card grid
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 24,
                              runSpacing: 32,
                              children: cardStates.asMap().entries.map((entry) {
                                final index = entry.key;
                                final cardState = entry.value;
                                
                                return AnimatedGachaCard(
                                  cardState: cardState,
                                  onTap: () {
                                    if (cardState.revealState == CardRevealState.faceDown) {
                                      // Reveal the card
                                      ref.read(gachaControllerProvider.notifier).revealCard(index);
                                    } else if (cardState.revealState == CardRevealState.revealed) {
                                      // Show modal
                                      CardDetailModal.show(context, cardState.card);
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        
                        // Reveal all button (only show if there are unrevealed cards)
                        if (cardStates.any((cs) => cs.revealState == CardRevealState.faceDown))
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withValues(alpha: 0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: FilledButton.icon(
                                onPressed: () {
                                  // Reveal all cards
                                  for (int i = 0; i < cardStates.length; i++) {
                                    if (cardStates[i].revealState == CardRevealState.faceDown) {
                                      Future.delayed(Duration(milliseconds: i * 200), () {
                                        ref.read(gachaControllerProvider.notifier).revealCard(i);
                                      });
                                    }
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.9),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  textStyle: GoogleFonts.philosopher(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                icon: const Icon(Icons.visibility, size: 20),
                                label: const Text('REVEAL ALL'),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            
            // Interaction Area
            Container(
              padding: const EdgeInsets.only(bottom: 60.0, top: 30.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: FilledButton.icon(
                    onPressed: () {
                      ref.read(gachaControllerProvider.notifier).spin(l10n);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37), // Gold
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: GoogleFonts.philosopher(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.black26, width: 2),
                      ),
                    ),
                    icon: const Icon(Icons.casino, size: 28),
                    label: Text(l10n.spinButton.toUpperCase()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

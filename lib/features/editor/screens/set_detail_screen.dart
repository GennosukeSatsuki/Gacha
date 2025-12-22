import 'package:flutter/material.dart';
import 'package:idea_mixer/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../../core/utils/l10n_utils.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/models/card_model.dart';
import '../../../domain/models/custom_set_model.dart';
import '../../gacha/custom_card_provider.dart';
import 'card_edit_screen.dart';

class SetDetailScreen extends ConsumerWidget {
  final String setId;

  const SetDetailScreen({super.key, required this.setId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final customSets = ref.watch(customCardProvider);
    final setIndex = customSets.indexWhere((s) => s.id == setId);
    
    if (setIndex == -1) {
      return Scaffold(body: Center(child: Text(l10n.setNotFound)));
    }

    final currentSet = customSets[setIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF16161E),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentSet.name,
              style: GoogleFonts.philosopher(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37),
              ),
            ),
            Text(
              l10n.cardCountLabel(currentSet.cards.length),
              style: GoogleFonts.notoSerif(fontSize: 12, color: Colors.white38),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: currentSet.cards.isEmpty
          ? _buildEmptyState(context, ref, currentSet, l10n)
          : _buildCardGrid(context, ref, currentSet, l10n),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD4AF37),
        onPressed: () => _addNewCard(context, ref, currentSet, l10n),
        child: const Icon(Icons.add_circle_outline, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, CustomSetModel set, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.style_outlined, size: 64, color: Colors.white12),
          const SizedBox(height: 16),
          Text(
            l10n.emptySet,
            style: GoogleFonts.notoSerif(color: Colors.white60),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _addNewCard(context, ref, set, l10n),
            icon: const Icon(Icons.add),
            label: Text(l10n.addFirstCard),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E2E),
              foregroundColor: const Color(0xFFD4AF37),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardGrid(BuildContext context, WidgetRef ref, CustomSetModel set, AppLocalizations l10n) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: set.cards.length,
      itemBuilder: (context, index) {
        final card = set.cards[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardEditScreen(setId: setId, card: card),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.black26,
                    child: card.imagePath != null
                        ? (card.isAsset
                            ? Image.asset(card.imagePath!, fit: BoxFit.cover)
                            : Image.file(File(card.imagePath!), fit: BoxFit.cover))
                        : const Icon(Icons.image_outlined, color: Colors.white12, size: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L10nUtils.getLocalizedText(card.getDisplayTitle(Localizations.localeOf(context).languageCode), AppLocalizations.of(context)!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.philosopher(
                                color: const Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              card.type == CardType.character ? l10n.typeCharacter : l10n.typeStory,
                              style: GoogleFonts.notoSerif(
                                color: Colors.white38,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 16, color: Colors.white24),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => _confirmDeleteCard(context, ref, set, card, l10n),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDeleteCard(BuildContext context, WidgetRef ref, CustomSetModel set, CardModel card, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: Text(l10n.deleteCard, style: const TextStyle(color: Colors.redAccent)),
        content: Text(l10n.deleteCardConfirm(card.title), style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel, style: const TextStyle(color: Colors.white60)),
          ),
          TextButton(
            onPressed: () {
              final updatedCards = set.cards.where((c) => c.id != card.id).toList();
              ref.read(customCardProvider.notifier).updateSetCards(setId, updatedCards);
              Navigator.pop(context);
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _addNewCard(BuildContext context, WidgetRef ref, CustomSetModel set, AppLocalizations l10n) {
    final locale = Localizations.localeOf(context).languageCode;
    final newCard = CardModel(
      id: const Uuid().v4(),
      type: CardType.character,
      titles: {locale: l10n.newCard},
      isAsset: false,
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardEditScreen(
          setId: setId,
          card: newCard,
          isNew: true,
        ),
      ),
    );
  }

  void _editCard(BuildContext context, WidgetRef ref, CustomSetModel set, CardModel card, AppLocalizations l10n) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardEditScreen(
          setId: setId,
          card: card,
          isNew: false,
        ),
      ),
    );
  }
}

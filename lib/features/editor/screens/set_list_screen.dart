import 'package:flutter/material.dart';
import 'package:idea_mixer/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../gacha/custom_card_provider.dart';
import 'set_detail_screen.dart';

class SetListScreen extends ConsumerWidget {
  const SetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final customSets = ref.watch(customCardProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF16161E),
      appBar: AppBar(
        title: Text(
          l10n.tabStudio,
          style: GoogleFonts.philosopher(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFD4AF37),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: customSets.isEmpty
          ? _buildEmptyState(context, ref, l10n)
          : _buildSetList(context, ref, customSets, l10n),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD4AF37),
        onPressed: () => _showCreateSetDialog(context, ref, l10n),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.library_books_outlined, size: 80, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            l10n.noSetsYet,
            style: GoogleFonts.notoSerif(color: Colors.white60, fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showCreateSetDialog(context, ref, l10n),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
            ),
            child: Text(l10n.createFirstSet),
          ),
        ],
      ),
    );
  }

  Widget _buildSetList(BuildContext context, WidgetRef ref, List<dynamic> sets, AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sets.length,
      itemBuilder: (context, index) {
        final set = sets[index];
        return Card(
          color: const Color(0xFF1E1E2E),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              set.name,
              style: GoogleFonts.philosopher(
                color: const Color(0xFFD4AF37),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              l10n.cardCountLabel(set.cards.length),
              style: GoogleFonts.notoSerif(color: Colors.white60),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetDetailScreen(setId: set.id),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showCreateSetDialog(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: Text(
          l10n.createNewSet,
          style: GoogleFonts.philosopher(color: const Color(0xFFD4AF37)),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: l10n.enterSetName,
            hintStyle: const TextStyle(color: Colors.white24),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD4AF37))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel, style: const TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final error = await ref.read(customCardProvider.notifier).createSet(controller.text);
                if (context.mounted) {
                  Navigator.pop(context);
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            child: Text(l10n.create, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

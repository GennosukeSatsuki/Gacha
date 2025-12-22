import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea_mixer/l10n/app_localizations.dart';
import 'gacha_provider.dart';
import 'settings_modal.dart';
import 'widgets/gacha_widgets.dart';

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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => SettingsModal.show(context),
            tooltip: l10n.settings,
          ),
          if (cardStates.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => ref.read(gachaControllerProvider.notifier).clear(),
              tooltip: l10n.clear,
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/cards/buckground.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: cardStates.isEmpty
                  ? const GachaEmptyState()
                  : GachaCardGrid(cardStates: cardStates),
            ),
            const GachaInteractionBar(),
          ],
        ),
      ),
    );
  }
}

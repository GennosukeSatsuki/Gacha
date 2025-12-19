import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'gacha_provider.dart';
import 'card_widget.dart';

class GachaScreen extends ConsumerWidget {
  const GachaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(gachaControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Display Area
            Expanded(
              child: cards.isEmpty
                  ? Center(
                      child: Text(
                        l10n.gachaPrompt,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: cards.map((card) => CardWidget(card: card)).toList(),
                        ),
                      ),
                    ),
            ),
            
            // Interaction Area
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0, top: 20.0),
              child: FilledButton.icon(
                onPressed: () {
                  ref.read(gachaControllerProvider.notifier).spin(l10n);
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.casino),
                label: Text(l10n.spinButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

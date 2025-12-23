import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea_mixer/l10n/app_localizations.dart';
import 'widgets/settings_tabs.dart';

class SettingsModal extends ConsumerWidget {
  const SettingsModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => const SettingsModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Color(0xFFD4AF37),
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.settings,
                      style: GoogleFonts.philosopher(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    ),
                  ],
                ),
              ),
              
              // Tab Bar
              TabBar(
                indicatorColor: const Color(0xFFD4AF37),
                labelColor: const Color(0xFFD4AF37),
                unselectedLabelColor: Colors.white60,
                labelStyle: GoogleFonts.philosopher(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: l10n.basicSettings),
                  Tab(text: l10n.cardSettings),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Settings Content
              const Expanded(
                child: TabBarView(
                  children: [
                    BasicSettingsTab(),
                    CardSettingsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'gacha_settings_provider.dart';

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
    final settings = ref.watch(gachaSettingsProvider);
    
    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: const Color(0xFFD4AF37),
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            Divider(color: Colors.white.withValues(alpha: 0.1)),
            const SizedBox(height: 24),
            
            // Settings Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SettingsSection(
                      title: l10n.gachaSettings,
                      children: [
                        _SettingsTile(
                          icon: Icons.person,
                          title: l10n.characterCount,
                          subtitle: l10n.characterCountDesc,
                          trailing: _CounterWidget(
                            value: settings.characterCount,
                            maxValue: 10 - settings.storyCount,
                            onChanged: (value) {
                              ref.read(gachaSettingsProvider.notifier).setCharacterCount(value);
                            },
                          ),
                        ),
                        _SettingsTile(
                          icon: Icons.auto_stories,
                          title: l10n.storyCount,
                          subtitle: l10n.storyCountDesc,
                          trailing: _CounterWidget(
                            value: settings.storyCount,
                            maxValue: 10 - settings.characterCount,
                            onChanged: (value) {
                              ref.read(gachaSettingsProvider.notifier).setStoryCount(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    _SettingsSection(
                      title: l10n.about,
                      children: [
                        _SettingsTile(
                          icon: Icons.info_outline,
                          title: l10n.version,
                          subtitle: '1.0.0',
                        ),
                        _SettingsTile(
                          icon: Icons.code,
                          title: l10n.license,
                          subtitle: 'MIT License',
                          onTap: () {
                            // TODO: Show license dialog
                          },
                        ),
                        _SettingsTile(
                          icon: Icons.language,
                          title: l10n.github,
                          subtitle: 'github.com/GennosukeSatsuki/Gacha',
                          onTap: () {
                            // TODO: Open GitHub link
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.philosopher(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFD4AF37),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.notoSerif(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.notoSerif(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: Colors.white30,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const _CounterWidget({
    required this.value,
    this.maxValue = 10,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            color: Colors.white70,
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: GoogleFonts.philosopher(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            color: Colors.white70,
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

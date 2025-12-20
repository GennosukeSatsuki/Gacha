import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'gacha_settings_provider.dart';
import 'custom_card_provider.dart';

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
    
    return DefaultTabController(
      length: 2,
      child: Dialog(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
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
              ),
              
              // Tab Bar
              TabBar(
                indicatorColor: const Color(0xFFD4AF37),
                labelColor: const Color(0xFFD4AF37),
                unselectedLabelColor: Colors.white60,
                labelStyle: GoogleFonts.philosopher(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: '基本設定'),
                  Tab(text: 'カード設定'),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Settings Content
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1: Basic Settings
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SettingsSection(
                            title: '一般',
                            children: [
                              _SettingsTile(
                                icon: Icons.language,
                                title: l10n.language,
                                subtitle: settings.locale == 'ja' ? l10n.japanese : l10n.english,
                                trailing: _LanguageSwitcher(
                                  currentLocale: settings.locale,
                                  onChanged: (locale) {
                                    ref.read(gachaSettingsProvider.notifier).setLocale(locale);
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Tab 2: Card Settings
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SettingsSection(
                            title: '排出設定',
                            children: [
                              _SettingsTile(
                                icon: Icons.library_add_check,
                                title: 'デフォルトセットを含める',
                                subtitle: '組み込みのサンプルカードを排出に含めます',
                                trailing: Switch(
                                  value: settings.includeDefaultSet,
                                  activeColor: const Color(0xFFD4AF37),
                                  onChanged: (value) {
                                    ref.read(gachaSettingsProvider.notifier).setIncludeDefaultSet(value);
                                  },
                                ),
                              ),
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
                            title: 'インポート済みセット',
                            children: [
                              if (ref.watch(customCardProvider).isEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Text(
                                    'インポートされたセットはありません',
                                    style: TextStyle(color: Colors.white38, fontSize: 12),
                                  ),
                                )
                              else
                                ...ref.watch(customCardProvider).map((set) => _SettingsTile(
                                  icon: Icons.folder_zip,
                                  title: set.name,
                                  subtitle: '${set.cards.length} 枚のカード',
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                    onPressed: () {
                                      ref.read(customCardProvider.notifier).deleteSet(set.id);
                                    },
                                  ),
                                )),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          _SettingsSection(
                            title: 'インポート',
                            children: [
                              _SettingsTile(
                                icon: Icons.file_download,
                                title: 'カスタムセットをインポート',
                                subtitle: 'manifest.jsonを選択してください',
                                onTap: () async {
                                  final result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['json'],
                                  );
                                  
                                  if (result != null && result.files.single.path != null) {
                                    final file = File(result.files.single.path!);
                                    final message = await ref.read(customCardProvider.notifier).importFromManifest(file);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

class _LanguageSwitcher extends StatelessWidget {
  final String currentLocale;
  final ValueChanged<String> onChanged;

  const _LanguageSwitcher({
    required this.currentLocale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
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
          _buildOption('JA', 'ja'),
          Container(
            width: 1,
            height: 20,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          _buildOption('EN', 'en'),
        ],
      ),
    );
  }

  Widget _buildOption(String label, String value) {
    final isSelected = currentLocale == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD4AF37).withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.all(2),
        child: Text(
          label,
          style: GoogleFonts.philosopher(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFFD4AF37) : Colors.white60,
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../gacha_settings_provider.dart';
import '../custom_card_provider.dart';
import 'package:path/path.dart' as p;
import 'settings_widgets.dart';

class BasicSettingsTab extends ConsumerWidget {
  const BasicSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(gachaSettingsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSection(
            title: l10n.general,
            children: [
              SettingsTile(
                icon: Icons.language,
                title: l10n.language,
                subtitle: settings.locale == 'ja' ? l10n.japanese : l10n.english,
                trailing: LanguageSwitcher(
                  currentLocale: settings.locale,
                  onChanged: (locale) {
                    ref.read(gachaSettingsProvider.notifier).setLocale(locale);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SettingsSection(
            title: l10n.about,
            children: [
              const SettingsTile(
                icon: Icons.info_outline,
                title: 'Version', // Should be from l10n if available
                subtitle: '1.0.0',
              ),
              SettingsTile(
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
    );
  }
}

class CardSettingsTab extends ConsumerWidget {
  const CardSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(gachaSettingsProvider);
    final customSets = ref.watch(customCardProvider);
    final customCardNotifier = ref.read(customCardProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSection(
            title: l10n.emissionSettings,
            children: [
              SettingsTile(
                icon: Icons.library_add_check,
                title: l10n.includeDefaultSet,
                subtitle: l10n.includeDefaultSetDesc,
                trailing: Switch(
                  value: settings.includeDefaultSet,
                  activeColor: const Color(0xFFD4AF37),
                  onChanged: (value) {
                    ref.read(gachaSettingsProvider.notifier).setIncludeDefaultSet(value);
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.person,
                title: l10n.characterCount,
                subtitle: l10n.characterCountDesc,
                trailing: CounterWidget(
                  value: settings.characterCount,
                  maxValue: 10 - settings.storyCount,
                  onChanged: (value) {
                    ref.read(gachaSettingsProvider.notifier).setCharacterCount(value);
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.auto_stories,
                title: l10n.storyCount,
                subtitle: l10n.storyCountDesc,
                trailing: CounterWidget(
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
          SettingsSection(
            title: l10n.import,
            children: [
              SettingsTile(
                icon: Icons.file_download,
                title: l10n.importCustomSet,
                subtitle: l10n.selectZipOrJson,
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['json', 'zip'],
                  );

                  if (result != null && result.files.single.path != null) {
                    final file = File(result.files.single.path!);
                    final extension = p.extension(file.path).toLowerCase();
                    
                    String? error;
                    if (extension == '.zip') {
                      error = await ref.read(customCardProvider.notifier).importFromZip(file);
                    } else {
                      error = await ref.read(customCardProvider.notifier).importFromManifest(file);
                    }

                    if (context.mounted) {
                      final snackBarMessage = error == null ? l10n.importSuccess : l10n.importError(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(snackBarMessage)),
                      );
                    }
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          SettingsSection(
            title: l10n.importedSets,
            action: IconButton(
              icon: const Icon(Icons.refresh, size: 20, color: Color(0xFFD4AF37)),
              onPressed: () => customCardNotifier.refreshSets(),
            ),
            children: [
              if (customSets.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    l10n.noImportedSets,
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                )
              else
                ...customSets.map((set) => SettingsTile(
                      icon: Icons.folder_zip,
                      title: set.name,
                      subtitle: l10n.cardCountLabel(set.cards.length),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          ref.read(customCardProvider.notifier).deleteSet(set.id);
                        },
                      ),
                    )),
              const SizedBox(height: 8),
              SettingsTile(
                icon: Icons.folder_open,
                title: l10n.openCustomSetsFolder,
                subtitle: 'Manage card sets manually',
                onTap: () async {
                  final appDocDir = await getApplicationDocumentsDirectory();
                  final path = p.join(appDocDir.path, 'custom_sets');
                  final dir = Directory(path);
                  if (!await dir.exists()) {
                    await dir.create(recursive: true);
                  }
                  final url = Uri.directory(path);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    if (Platform.isMacOS) {
                      await Process.run('open', [path]);
                    } else if (Platform.isWindows) {
                      await Process.run('explorer.exe', [path]);
                    } else if (Platform.isLinux) {
                      await Process.run('xdg-open', [path]);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

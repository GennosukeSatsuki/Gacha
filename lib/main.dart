import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'core/theme.dart';
import 'features/gacha/gacha_screen.dart';

void main() {
  runApp(const ProviderScope(child: PlotMixerApp()));
}

class PlotMixerApp extends StatelessWidget {
  const PlotMixerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plot Mixer',
      theme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ja'), // Japanese
      ],
      home: const GachaScreen(),
    );
  }
}

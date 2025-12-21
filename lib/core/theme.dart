import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFF16161E);
  static const Color surface = Color(0xFF1E1E2E);

  static final TextStyle headingStyle = GoogleFonts.philosopher(
    color: gold,
    fontWeight: FontWeight.bold,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: Brightness.dark,
      surface: surface,
    ),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: const Color(0xFFE0E0E0),
      displayColor: const Color(0xFFFFFFFF),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF252535),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

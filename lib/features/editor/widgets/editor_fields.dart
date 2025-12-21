import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import '../../../core/theme.dart';
import '../../../core/utils/l10n_utils.dart';
import '../../../domain/models/card_model.dart';

class EditorSectionTitle extends StatelessWidget {
  final String title;
  const EditorSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.headingStyle.copyWith(fontSize: 14, letterSpacing: 1.2),
      ),
    );
  }
}

class EditorTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int maxLines;
  final TextInputType? keyboardType;
  final Function(String) onChanged;

  const EditorTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.maxLines = 1,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: AppTheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.gold)),
      ),
      onChanged: onChanged,
    );
  }
}

class EditorDropdown<T extends Enum> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final Function(T?) onChanged;

  const EditorDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: AppTheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: AppTheme.surface,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: items.map((item) {
            String labelText = '';
            if (item is CardType) {
              labelText = L10nUtils.getCardTypeLabel(item, l10n);
            } else if (item is CardElement) {
              labelText = L10nUtils.getElementLabel(item, l10n);
            } else if (item is CardRarity) {
              labelText = L10nUtils.getRarityLabel(item, l10n);
            }
            
            return DropdownMenuItem(
              value: item,
              child: Text(labelText),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

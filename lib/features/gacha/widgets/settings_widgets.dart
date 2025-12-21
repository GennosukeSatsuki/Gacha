import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final Widget? action;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    this.action,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.philosopher(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37),
              ),
            ),
            if (action != null) action!,
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
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

class CounterWidget extends StatelessWidget {
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const CounterWidget({
    super.key,
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

class LanguageSwitcher extends StatelessWidget {
  final String currentLocale;
  final ValueChanged<String> onChanged;

  const LanguageSwitcher({
    super.key,
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

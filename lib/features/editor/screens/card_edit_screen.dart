import 'package:flutter/material.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import 'dart:io';
import '../widgets/image_crop_dialog.dart';
import '../../../domain/models/card_model.dart';
import '../../../core/utils/l10n_utils.dart';
import '../../gacha/card_widget.dart';
import '../../gacha/custom_card_provider.dart';

class CardEditScreen extends ConsumerStatefulWidget {
  final String setId;
  final CardModel card;
  final bool isNew;

  const CardEditScreen({
    super.key,
    required this.setId,
    required this.card,
    this.isNew = false,
  });

  @override
  ConsumerState<CardEditScreen> createState() => _CardEditScreenState();
}

class _CardEditScreenState extends ConsumerState<CardEditScreen> {
  late CardModel _editingCard;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editingCard = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFF16161E),
      appBar: AppBar(
        title: Text(
          widget.isNew ? l10n.newCard : l10n.editCard,
          style: GoogleFonts.philosopher(color: const Color(0xFFD4AF37)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Color(0xFFD4AF37)),
            onPressed: _save,
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Side: Editor Form
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(l10n.basicInfo),
                    _buildTextField(
                      label: l10n.titleLabel,
                      initialValue: L10nUtils.getLocalizedText(_editingCard.getDisplayTitle(locale), l10n),
                      onChanged: (val) {
                        final newMap = Map<String, String>.from(_editingCard.titles);
                        newMap[locale] = val;
                        setState(() => _editingCard = _editingCard.copyWith(titles: newMap));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: l10n.descriptionLabel,
                      initialValue: L10nUtils.getLocalizedText(_editingCard.getDisplayDescription(locale), l10n),
                      maxLines: 3,
                      onChanged: (val) {
                        final newMap = Map<String, String>.from(_editingCard.descriptions);
                        newMap[locale] = val;
                        setState(() => _editingCard = _editingCard.copyWith(descriptions: newMap));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(l10n.cardProperties),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown<CardType>(
                          label: l10n.typeLabel,
                          value: _editingCard.type,
                          items: CardType.values,
                          l10n: l10n,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(type: val!)),
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: _buildDropdown<CardElement>(
                          label: l10n.elementLabel,
                          value: _editingCard.element,
                          items: CardElement.values,
                          l10n: l10n,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(element: val!)),
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown<CardRarity>(
                          label: l10n.rarityLabel,
                          value: _editingCard.rarity,
                          items: CardRarity.values,
                          l10n: l10n,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(rarity: val!)),
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(
                          label: l10n.manaCostLabel,
                          initialValue: _editingCard.manaCost ?? '',
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(manaCost: val.isEmpty ? null : val)),
                        )),
                      ],
                    ),
                    if (_editingCard.type == CardType.character) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildTextField(
                            label: l10n.powerLabel,
                            initialValue: _editingCard.power?.toString() ?? '',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(power: int.tryParse(val))),
                          )),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(
                            label: l10n.toughnessLabel,
                            initialValue: _editingCard.toughness?.toString() ?? '',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(toughness: int.tryParse(val))),
                          )),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Vertical Divider
          Container(width: 1, color: Colors.white12),
          // Right Side: Live Preview
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black12,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.preview,
                      style: GoogleFonts.philosopher(
                        color: Colors.white24,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CardWidget(
                      card: _editingCard, 
                      width: 220, 
                      height: 320,
                      onArtTap: _pickImage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.philosopher(
          color: const Color(0xFFD4AF37),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    int maxLines = 1,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1E1E2E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD4AF37))),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown<T extends Enum>({
    required String label,
    required T value,
    required List<T> items,
    required AppLocalizations l10n,
    required Function(T?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1E1E2E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E2E),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: items.map((item) {
            String labelText = item.name.toUpperCase();
            if (item is CardType) {
              labelText = item == CardType.character ? l10n.typeCharacter : l10n.typeStory;
            } else if (item is CardElement) {
              switch (item) {
                case CardElement.fire: labelText = l10n.elementFire; break;
                case CardElement.water: labelText = l10n.elementWater; break;
                case CardElement.wind: labelText = l10n.elementWind; break;
                case CardElement.earth: labelText = l10n.elementEarth; break;
                case CardElement.light: labelText = l10n.elementLight; break;
                case CardElement.dark: labelText = l10n.elementDark; break;
                case CardElement.neutral: labelText = l10n.elementNeutral; break;
              }
            } else if (item is CardRarity) {
              labelText = item.name.toUpperCase(); // Keep rarity as is or localize later
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

  void _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image == null) return;

    final bytes = await image.readAsBytes();
    
    if (!mounted) return;

    // MTG ratio: 268 / 160 approx 1.675
    const double ratio = 268 / 160;

    final Uint8List? croppedBytes = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCropDialog(
          imageBytes: bytes,
          aspectRatio: ratio,
        ),
      ),
    );

    if (croppedBytes != null) {
      final String? relativePath = await ref.read(customCardProvider.notifier).saveCardImage(
        widget.setId,
        _editingCard.id,
        croppedBytes,
      );

      if (relativePath != null && mounted) {
        final set = ref.read(customCardProvider).firstWhere((s) => s.id == widget.setId);
        final fullPath = p.join(set.directoryPath, relativePath);
        
        setState(() {
          _editingCard = _editingCard.copyWith(
            imagePath: fullPath,
            isAsset: false,
          );
        });
      }
    }
  }

  void _save() async {
    final customSets = ref.read(customCardProvider);
    final setIndex = customSets.indexWhere((s) => s.id == widget.setId);
    if (setIndex == -1) return;

    final currentSet = customSets[setIndex];
    List<CardModel> updatedCards = List.from(currentSet.cards);

    if (widget.isNew) {
      updatedCards.add(_editingCard);
    } else {
      final cardIndex = updatedCards.indexWhere((c) => c.id == _editingCard.id);
      if (cardIndex != -1) {
        updatedCards[cardIndex] = _editingCard;
      }
    }

    await ref.read(customCardProvider.notifier).updateSetCards(widget.setId, updatedCards);
    
    if (mounted) {
      Navigator.pop(context);
    }
  }
}

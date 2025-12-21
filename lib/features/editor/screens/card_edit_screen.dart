import 'package:flutter/material.dart';
import 'package:plot_mixer/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import '../widgets/image_crop_dialog.dart';
import '../widgets/editor_fields.dart';
import '../widgets/editor_preview_panel.dart';
import '../../../domain/models/card_model.dart';
import '../../../core/utils/l10n_utils.dart';
import '../../../core/theme.dart';
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
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          widget.isNew ? l10n.newCard : l10n.editCard,
          style: AppTheme.headingStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.gold),
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
                    const EditorSectionTitle(title: 'Basic Info'),
                    EditorTextField(
                      label: l10n.titleLabel,
                      initialValue: L10nUtils.getLocalizedText(_editingCard.getDisplayTitle(locale), l10n),
                      onChanged: (val) {
                        final newMap = Map<String, String>.from(_editingCard.titles);
                        newMap[locale] = val;
                        setState(() => _editingCard = _editingCard.copyWith(titles: newMap));
                      },
                    ),
                    const SizedBox(height: 16),
                    EditorTextField(
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
                    const EditorSectionTitle(title: 'Properties'),
                    Row(
                      children: [
                        Expanded(child: EditorDropdown<CardType>(
                          label: l10n.typeLabel,
                          value: _editingCard.type,
                          items: CardType.values,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(type: val!)),
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: EditorDropdown<CardElement>(
                          label: l10n.elementLabel,
                          value: _editingCard.element,
                          items: CardElement.values,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(element: val!)),
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: EditorDropdown<CardRarity>(
                          label: l10n.rarityLabel,
                          value: _editingCard.rarity,
                          items: CardRarity.values,
                          onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(rarity: val!)),
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: EditorTextField(
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
                          Expanded(child: EditorTextField(
                            label: l10n.powerLabel,
                            initialValue: _editingCard.power?.toString() ?? '',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() => _editingCard = _editingCard.copyWith(power: int.tryParse(val))),
                          )),
                          const SizedBox(width: 16),
                          Expanded(child: EditorTextField(
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
            child: EditorPreviewPanel(
              card: _editingCard,
              onArtTap: _pickImage,
            ),
          ),
        ],
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/card_model.dart';
import '../../domain/models/custom_set_model.dart';

final customCardProvider = NotifierProvider<CustomCardNotifier, List<CustomSetModel>>(
  CustomCardNotifier.new,
);

class CustomCardNotifier extends Notifier<List<CustomSetModel>> {
  static const String _keyCustomSets = 'custom_card_sets';
  final _uuid = const Uuid();

  @override
  List<CustomSetModel> build() {
    _loadSets();
    return [];
  }

  Future<void> _loadSets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyCustomSets) ?? [];
    
    state = jsonList.map((s) => CustomSetModel.fromJson(json.decode(s))).toList();
  }

  Future<void> _saveSets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((s) => json.encode(s.toJson())).toList();
    await prefs.setStringList(_keyCustomSets, jsonList);
  }

  Future<String?> importFromManifest(File manifestFile) async {
    try {
      final content = await manifestFile.readAsString();
      final data = json.decode(content);
      
      final String setName = data['setName'] ?? 'Unknown Set';
      final List<dynamic> cardsJson = data['cards'] ?? [];
      
      final appDocDir = await getApplicationDocumentsDirectory();
      final setId = _uuid.v4();
      final setDir = Directory(p.join(appDocDir.path, 'custom_sets', setId));
      await setDir.create(recursive: true);
      
      final List<CardModel> cards = [];
      for (var cardJson in cardsJson) {
        // Handle images
        String? localImagePath;
        if (cardJson['imagePath'] != null) {
          final sourcePath = p.join(manifestFile.parent.path, cardJson['imagePath']);
          final sourceFile = File(sourcePath);
          if (await sourceFile.exists()) {
            final fileName = p.basename(sourcePath);
            final destPath = p.join(setDir.path, 'images', fileName);
            await Directory(p.dirname(destPath)).create(recursive: true);
            await sourceFile.copy(destPath);
            localImagePath = destPath;
          }
        }

        cards.add(CardModel.fromJson(cardJson).copyWith(
          id: _uuid.v4(),
          imagePath: localImagePath,
          isAsset: false,
        ));
      }

      final newSet = CustomSetModel(
        id: setId,
        name: setName,
        directoryPath: setDir.path,
        cards: cards,
      );

      state = [...state, newSet];
      await _saveSets();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteSet(String setId) async {
    final setToRemove = state.firstWhere((s) => s.id == setId);
    
    // Delete physical files
    final dir = Directory(setToRemove.directoryPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
    
    state = state.where((s) => s.id != setId).toList();
    await _saveSets();
  }

  List<CardModel> getAllCustomCards() {
    return state.expand((s) => s.cards).toList();
  }
}

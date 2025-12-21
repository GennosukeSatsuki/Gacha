import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../domain/models/card_model.dart';
import '../../domain/models/custom_set_model.dart';

final customCardProvider = NotifierProvider<CustomCardNotifier, List<CustomSetModel>>(
  CustomCardNotifier.new,
);

class CustomCardNotifier extends Notifier<List<CustomSetModel>> {
  final _uuid = const Uuid();

  @override
  List<CustomSetModel> build() {
    // We use a separate async method to initialize, 
    // but the actual loading is triggered here.
    _initAndLoad();
    return [];
  }

  Future<void> _initAndLoad() async {
    try {
      await _ensureDefaultSetExists();
      await _loadSets();
    } catch (e) {
      print('Error in _initAndLoad: $e');
    }
  }

  Future<Directory> _getCustomSetsDir() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(appDocDir.path, 'custom_sets'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<void> _ensureDefaultSetExists() async {
    final setsDir = await _getCustomSetsDir();
    final defaultSetDir = Directory(p.join(setsDir.path, 'default_set'));
    
    // Always check for manifest.json as well to be sure it's not an empty folder
    final manifestFile = File(p.join(defaultSetDir.path, 'manifest.json'));
    if (await manifestFile.exists()) return;

    print('Initializing default set in ${defaultSetDir.path}...');
    try {
      await defaultSetDir.create(recursive: true);
      
      // Copy manifest.json from assets
      final manifestData = await rootBundle.loadString('assets/data/default_set/manifest.json');
      await manifestFile.writeAsString(manifestData);

      // Copy crystal image
      final imageDir = Directory(p.join(defaultSetDir.path, 'images'));
      await imageDir.create(recursive: true);
      
      final byteData = await rootBundle.load('assets/data/default_set/images/crystal.png');
      final bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await File(p.join(imageDir.path, 'crystal.png')).writeAsBytes(bytes);
      
      print('Default set initialized successfully.');
    } catch (e) {
      print('Error ensuring default set: $e');
    }
  }

  Future<void> _loadSets() async {
    final setsDir = await _getCustomSetsDir();
    final List<CustomSetModel> loadedSets = [];

    if (await setsDir.exists()) {
      final entities = setsDir.listSync();
      for (var entity in entities) {
        if (entity is Directory) {
          final manifestFile = File(p.join(entity.path, 'manifest.json'));
          if (await manifestFile.exists()) {
            final set = await _loadSetFromDirectory(entity);
            if (set != null) {
              loadedSets.add(set);
            }
          }
        }
      }
    }
    state = loadedSets;
  }

  Future<CustomSetModel?> _loadSetFromDirectory(Directory dir) async {
    try {
      final manifestFile = File(p.join(dir.path, 'manifest.json'));
      final content = await manifestFile.readAsString();
      final data = json.decode(content);

      final String setName = data['setName'] ?? p.basename(dir.path);
      final List<dynamic> cardsJson = data['cards'] ?? [];

      final List<CardModel> cards = [];
      for (var cardJson in cardsJson) {
        String? localImagePath;
        if (cardJson['imagePath'] != null) {
          final imagePath = p.join(dir.path, cardJson['imagePath']);
          if (await File(imagePath).exists()) {
            localImagePath = imagePath;
          }
        }

        cards.add(CardModel.fromJson(cardJson).copyWith(
          id: _uuid.v4(),
          imagePath: localImagePath,
          isAsset: false,
        ));
      }

      return CustomSetModel(
        id: p.basename(dir.path), // Use directory name as ID
        name: setName,
        directoryPath: dir.path,
        cards: cards,
      );
    } catch (e) {
      print('Error loading set from ${dir.path}: $e');
      return null;
    }
  }

  // Reload sets from directory (useful for manual changes)
  Future<void> refreshSets() async {
    await _loadSets();
  }

  Future<String?> importFromZip(File zipFile) async {
    try {
      final bytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      final fileName = p.basenameWithoutExtension(zipFile.path);
      final setsDir = await _getCustomSetsDir();
      
      String folderName = fileName.replaceAll(RegExp(r'[^\w\s-]'), '_');
      Directory targetDir = Directory(p.join(setsDir.path, folderName));
      
      int counter = 1;
      while (await targetDir.exists()) {
        targetDir = Directory(p.join(setsDir.path, '${folderName}_$counter'));
        counter++;
      }
      await targetDir.create(recursive: true);

      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          final outFile = File(p.join(targetDir.path, filename));
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(data);
        } else {
          await Directory(p.join(targetDir.path, filename)).create(recursive: true);
        }
      }

      final manifestFile = File(p.join(targetDir.path, 'manifest.json'));
      if (!await manifestFile.exists()) {
        await targetDir.delete(recursive: true);
        return 'No manifest.json found in ZIP';
      }

      final newSet = await _loadSetFromDirectory(targetDir);
      if (newSet != null) {
        state = [...state, newSet];
        return null;
      } else {
        await targetDir.delete(recursive: true);
        return 'Failed to load manifest.json';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteSet(String setId) async {
    final setsDir = await _getCustomSetsDir();
    final dir = Directory(p.join(setsDir.path, setId));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
    state = state.where((s) => s.id != setId).toList();
  }

  Future<String?> createSet(String name) async {
    try {
      final setsDir = await _getCustomSetsDir();
      // Sanitize folder name
      String folderName = name.replaceAll(RegExp(r'[^\w\s-]'), '_').toLowerCase();
      if (folderName.isEmpty) folderName = 'unnamed_set';
      
      Directory targetDir = Directory(p.join(setsDir.path, folderName));
      int counter = 1;
      while (await targetDir.exists()) {
        targetDir = Directory(p.join(setsDir.path, '${folderName}_$counter'));
        counter++;
      }
      await targetDir.create(recursive: true);

      final manifest = {
        'setName': name,
        'cards': [],
      };
      
      final manifestFile = File(p.join(targetDir.path, 'manifest.json'));
      await manifestFile.writeAsString(json.encode(manifest));

      final newSet = CustomSetModel(
        id: p.basename(targetDir.path),
        name: name,
        directoryPath: targetDir.path,
        cards: [],
      );

      state = [...state, newSet];
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSetCards(String setId, List<CardModel> cards) async {
    final setIndex = state.indexWhere((s) => s.id == setId);
    if (setIndex == -1) return;

    final updatedSet = state[setIndex].copyWith(cards: cards);
    
    // Update manifest file
    final manifestFile = File(p.join(updatedSet.directoryPath, 'manifest.json'));
    final manifestData = {
      'setName': updatedSet.name,
      'cards': cards.map((c) => c.toJson()).toList(),
    };
    await manifestFile.writeAsString(json.encode(manifestData));

    final newState = [...state];
    newState[setIndex] = updatedSet;
    state = newState;
  }

  /// Saves an image for a specific card in a set and returns the relative path from the set root.
  Future<String?> saveCardImage(String setId, String cardId, Uint8List imageBytes) async {
    final set = state.firstWhere((s) => s.id == setId);
    final imageDir = Directory(p.join(set.directoryPath, 'images'));
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    final String fileName = '${cardId}_${DateTime.now().millisecondsSinceEpoch}.png';
    final String filePath = p.join(imageDir.path, fileName);
    
    await File(filePath).writeAsBytes(imageBytes);
    
    // Return the relative path from directory root (images/filename.png)
    return p.join('images', fileName);
  }

  List<CardModel> getAllCustomCards() {
    return state.expand((s) => s.cards).toList();
  }

  Future<String?> importFromManifest(File manifestFile) async {
    try {
      final setsDir = await _getCustomSetsDir();
      final fileName = p.basenameWithoutExtension(manifestFile.path);
      String folderName = 'imported_$fileName';
      Directory targetDir = Directory(p.join(setsDir.path, folderName));
      
      int counter = 1;
      while (await targetDir.exists()) {
        targetDir = Directory(p.join(setsDir.path, '${folderName}_$counter'));
        counter++;
      }
      await targetDir.create(recursive: true);

      await manifestFile.copy(p.join(targetDir.path, 'manifest.json'));
      
      final content = await manifestFile.readAsString();
      final data = json.decode(content);
      final List<dynamic> cardsJson = data['cards'] ?? [];
      for (var cardJson in cardsJson) {
        if (cardJson['imagePath'] != null) {
          final sourcePath = p.join(manifestFile.parent.path, cardJson['imagePath']);
          final sourceFile = File(sourcePath);
          if (await sourceFile.exists()) {
            final destPath = p.join(targetDir.path, cardJson['imagePath']);
            await Directory(p.dirname(destPath)).create(recursive: true);
            await sourceFile.copy(destPath);
          }
        }
      }

      final newSet = await _loadSetFromDirectory(targetDir);
      if (newSet != null) {
        state = [...state, newSet];
        return null;
      }
      return 'Failed to load manifest';
    } catch (e) {
      return e.toString();
    }
  }
}

# Idea Mixer

[🇯🇵 日本語のREADMEはこちら (Japanese README)](README_ja.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Idea Mixer** is a gacha-style idea generator designed to stimulate creative activities. It randomly combines characters and story elements to give you new inspiration for your stories.

## ✨ Features

- 🎴 **Gacha System**: Rich card effects inspired by mobile social games.
- 🔄 **3D Flip Animation**: Smooth 3D animations when flipping cards.
- 🎨 **MTG-style Card Design**: Beautiful card designs inspired by Magic: The Gathering.
- 🛠️ **Card Creator (Studio)**: Create and edit your own cards with a live preview.
- ✂️ **Image Cropper**: Pick and crop images to fit perfectly into the card frame.
- 🖼️ **Custom Assets**: Freely change card backs and background images.
- 📂 **Custom Set Import**: Import and delete your own card sets (JSON/Images).
- ⚙️ **Tabbed Settings**: Adjust basic and card settings with an organized UI.
- 🌍 **Multi-language Support**: Supports Japanese and English (easy to add more languages).
- 📱 **Cross-platform**: Runs on macOS (Apple Silicon), Windows, and Android.

## 🎮 How to Use

1. **Spin the Gacha**: Click the "SPIN" button at the bottom of the "Gacha" tab.
2. **Reveal Cards**: Click on face-down cards to reveal them one by one.
3. **Card Creator**: Go to the "Studio" tab to create your own card sets and cards.
   - Click on the image area of a card to upload and crop your own illustrations.
4. **Settings**: Open the settings via the gear icon to customize themes and draw counts.

## 🚀 Setup

### Requirements

- [Flutter](https://flutter.dev/) 3.10.4 or higher
- Dart 3.10.4 or higher

### Installation

1. Clone the repository:

```bash
git clone https://github.com/GennosukeSatsuki/Gacha.git
cd Gacha
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
# macOS
flutter run -d macos
```

## 🏗️ Project Structure

```
lib/
├── core/                    # Core functionality
│   └── utils/              # Utilities (localization helpers)
├── domain/                  # Domain layer
│   └── models/             # Data models (CardModel, CustomSetModel)
├── features/                # Feature-based modules
│   ├── gacha/              # Gacha system and components
│   ├── editor/             # Card & Set editor (Studio)
│   └── main/               # Main navigation (Bottom Bar)
├── l10n/                    # Localization
└── main.dart               # Entry point
```

## 📦 Libraries Used

This project uses the following open-source libraries:

### Runtime Dependencies

- **[crop_your_image](https://pub.dev/packages/crop_your_image)** (^2.0.0) - MIT License
  - High-performance image cropping for all platforms.
- **[image_picker](https://pub.dev/packages/image_picker)** (^1.1.2) - BSD-3-Clause License
  - Multi-platform library for picking images from the gallery.
- **[flutter_riverpod](https://pub.dev/packages/flutter_riverpod)** (^2.5.1) - MIT License
- **[google_fonts](https://pub.dev/packages/google_fonts)** (^6.2.1) - Apache License 2.0

## 🎨 Card Design

The card design is inspired by **Magic: The Gathering** and includes:

- **Card Types**: Character (Creature), Story (Sorcery)
- **Rarity**: Common, Uncommon, Rare, Mythic
- **Elements**: Fire, Water, Wind, Earth, Light, Dark, Neutral

## 🌐 Localization

Current supported languages:
- 🇯🇵 Japanese
- 🇺🇸 English

To add a new language:
1. Create `lib/l10n/app_[language_code].arb`.
2. Add translations.
3. Run `flutter pub get`.

## 🚀 Release Process

This project uses GitHub Actions to automatically generate multi-platform builds.

### Automatic Release

To release a new version:
1. Update version in `pubspec.yaml`.
2. Commit changes.
3. Create and push a tag:

```bash
git tag v1.0.1
git push origin v1.0.1
```

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

### 📝 Changelog

#### v1.0.1 (2025-12-22)
- ✨ **Studio Feature**: Added a "Studio" tab to create and edit custom cards.
- ✂️ **Image Cropper**: Integrated a powerful image cropper to perfectly fit illustrations into cards.
- 🎨 **UI Refinement**: Fixed card layout consistency and improved card list visibility in the editor.
- 🌍 **L10n**: Full localization for card types and editor interface.

#### v1.0.0 (2025-12-21)
- Initial release with Gacha system and Custom Set Import.

---

Made with ❤️ using Flutter

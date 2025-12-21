# アイデアミキサー (Idea Mixer)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**アイデアミキサー**は、創作活動を刺激するガチャ形式のアイデアジェネレーターです。キャラクターとストーリー要素をランダムに組み合わせて、新しい物語のインスピレーションを得ることができます。

## ✨ 特徴

- 🎴 **ガチャシステム**: ソーシャルゲーム風のリッチなカード演出
- 🔄 **3Dフリップアニメーション**: カードを裏返す際のスムーズな3Dアニメーション
- 🎨 **MTG風カードデザイン**: Magic: The Gatheringにインスパイアされた美しいカードデザイン
- 🖼️ **カスタムアセット**: カード裏面や背景画像を自由に変更可能
- 📂 **カスタムセットインポート**: 独自のカードセット（JSON/画像）をインポート・削除可能
- ⚙️ **タブ形式の設定画面**: 基本設定とカード設定を整理されたUIで変更可能
- 🎲 **公平な乱数生成**: 暗号学的に安全な乱数生成器を使用し、偏りのない抽選を実現
- 🌍 **多言語対応**: 日本語と英語に対応（簡単に他の言語も追加可能）
- 📱 **クロスプラットフォーム**: macOS、Windows、Linux、Androidで動作

## 🎮 使い方

1. **設定を調整**（オプション）: 歯車アイコンから設定画面を開き、ガチャ枚数をカスタマイズ
2. **ガチャを引く**: 画面下部の「SPIN」ボタンをクリック
3. **カードをめくる**: 伏せられたカードをクリックして1枚ずつめくる
   - または「REVEAL ALL」ボタンですべて一括表示
4. **詳細を確認**: めくられたカードをクリックしてモーダルで拡大表示
5. **新しいガチャ**: もう一度「SPIN」ボタンを押すと、カードがリセットされて新しいガチャが始まります

## 🚀 セットアップ

### 必要要件

- [Flutter](https://flutter.dev/) 3.10.4 以上
- Dart 3.10.4 以上

### インストール

1. リポジトリをクローン:
```bash
git clone https://github.com/yourusername/Gacha.git
cd Gacha
```

2. 依存関係をインストール:
```bash
flutter pub get
```

3. アプリを実行:
```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

## 🏗️ プロジェクト構成

```
lib/
├── core/                    # コア機能
│   └── theme.dart          # アプリケーションテーマ
├── data/                    # データ層
│   └── repositories/       # データリポジトリ
├── domain/                  # ドメイン層
│   └── models/             # データモデル
│       ├── card_model.dart
│       └── custom_set_model.dart
├── features/                # 機能別モジュール
│   └── gacha/              # ガチャ機能
│       ├── animated_gacha_card.dart
│       ├── card_back_widget.dart
│       ├── card_detail_modal.dart
│       ├── card_widget.dart
│       ├── custom_card_provider.dart
│       ├── gacha_card_state.dart
│       ├── gacha_provider.dart
│       ├── gacha_screen.dart
│       ├── gacha_settings_provider.dart
│       └── settings_modal.dart
├── l10n/                    # 多言語対応
│   ├── app_en.arb          # 英語
│   └── app_ja.arb          # 日本語
└── main.dart               # エントリーポイント
```

## 📦 使用ライブラリ

このプロジェクトは以下のオープンソースライブラリを使用しています：

### ランタイム依存関係

- **[Flutter](https://flutter.dev/)** - BSD-3-Clause License
  - Googleによるクロスプラットフォームフレームワーク

- **[flutter_riverpod](https://pub.dev/packages/flutter_riverpod)** (^3.0.3) - MIT License
  - 状態管理ライブラリ
  - Copyright (c) 2020 Remi Rousselet

- **[google_fonts](https://pub.dev/packages/google_fonts)** (^6.3.3) - Apache License 2.0
  - Google Fontsへのアクセスを提供
  - 使用フォント: Philosopher, Noto Serif

- **[uuid](https://pub.dev/packages/uuid)** (^4.5.2) - MIT License
  - UUID生成ライブラリ

- **[cupertino_icons](https://pub.dev/packages/cupertino_icons)** (^1.0.8) - MIT License
  - iOSスタイルのアイコン

- **[intl](https://pub.dev/packages/intl)** (^0.20.2) - BSD-3-Clause License
  - 国際化とローカライゼーションのサポート

- **[shared_preferences](https://pub.dev/packages/shared_preferences)** (^2.3.3) - BSD-3-Clause License
  - ローカルストレージによる設定の永続化
  - ガチャ枚数設定の保存に使用

- **[file_picker](https://pub.dev/packages/file_picker)** (^8.1.7) - MIT License
  - ローカルファイルの選択
  - カスタムカードセットのインポートに使用

- **[path_provider](https://pub.dev/packages/path_provider)** (^2.1.5) - BSD-3-Clause License
  - アプリ専用ディレクトリの取得
  - インポートした画像の保存に使用

### 開発依存関係

- **[flutter_lints](https://pub.dev/packages/flutter_lints)** (^6.0.0) - BSD-3-Clause License
  - Flutterの推奨Lintルール

- **[build_runner](https://pub.dev/packages/build_runner)** (^2.10.4) - BSD-3-Clause License
  - コード生成ツール

- **[freezed](https://pub.dev/packages/freezed)** (^3.2.3) - MIT License
  - イミュータブルクラス生成（注: 現在は使用していません）

- **[json_serializable](https://pub.dev/packages/json_serializable)** (^6.11.2) - BSD-3-Clause License
  - JSONシリアライゼーション

## 🎨 カードデザイン

カードデザインは**Magic: The Gathering**にインスパイアされており、以下の要素を含みます：

- **カードタイプ**: キャラクター（Creature）、ストーリー（Sorcery）
- **レアリティ**: Common、Uncommon、Rare、Mythic
- **属性**: Fire、Water、Wind、Earth、Light、Dark、Neutral
- **パワー/タフネス**: キャラクターカードの強さを表す数値

## 🌐 多言語対応

現在サポートされている言語：
- 🇯🇵 日本語
- 🇺🇸 英語

新しい言語を追加するには：
1. `lib/l10n/app_[言語コード].arb` ファイルを作成
2. 翻訳を追加
3. `flutter pub get` を実行

## 🚀 リリースプロセス

このプロジェクトは、GitHub Actionsを使用して自動的にマルチプラットフォームビルドを生成します。

### 自動リリース

新しいバージョンをリリースするには：

1. バージョン番号を更新（`pubspec.yaml`）
2. 変更をコミット
3. タグを作成してプッシュ:
```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actionsが自動的に以下を実行します：
- ✅ Windows版ビルド（x64）
- ✅ macOS版ビルド（Apple Silicon & Intel）
- ✅ Android版ビルド（APK）
- ✅ リリースノート自動生成
- ✅ GitHubリリースページへの自動アップロード

### ビルド成果物

各リリースには以下のファイルが含まれます：
- `plot_mixer-windows-x64.zip` - Windows版
- `plot_mixer-macos-arm64.dmg` - macOS Apple Silicon版
- `plot_mixer-macos-x64.dmg` - macOS Intel版
- `plot_mixer-android.apk` - Android版

## 🤝 コントリビューション

プルリクエストを歓迎します！大きな変更の場合は、まずissueを開いて変更内容を議論してください。

## 📄 ライセンス

このプロジェクトは[MITライセンス](LICENSE)の下で公開されています。

```
MIT License

Copyright (c) 2025 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 🙏 謝辞

- [Flutter](https://flutter.dev/) チームによる素晴らしいフレームワーク
- [Riverpod](https://riverpod.dev/) による優れた状態管理ソリューション
- [Google Fonts](https://fonts.google.com/) による美しいフォント
- Magic: The Gathering のカードデザインからのインスピレーション

## 📞 お問い合わせ

質問や提案がある場合は、[Issues](https://github.com/GennosukeSatsuki/Gacha/issues)を開いてください。

## 📝 変更履歴

### 2025-12-21
- 🌍 **多言語対応の強化**:
  - 設定画面（SettingsModal）の全項目を多言語化
  - カードセットのインポート時やエラー時の通知メッセージをローカライズ
  - カード属性（火、水、風など）の表示を各言語に対応
  - サンプルカード（神秘のクリスタル）の名称と説明をローカライズ
- ⚙️ **インポート機能の改善**:
  - `CustomCardNotifier` の戻り値を調整し、UI側で柔軟なエラーメッセージ表示を可能に
- 🧹 **コードのクリーンアップ**:
  - `l10n.yaml` から非推奨の設定を削除
  - 不要な `const` 指定やスコープの問題を修正

---

Made with ❤️ using Flutter

# アイデアミキサー (Idea Mixer)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**アイデアミキサー**は、創作活動を刺激するガチャ形式のアイデアジェネレーターです。キャラクターとストーリー要素をランダムに組み合わせて、新しい物語のインスピレーションを得ることができます。

## ✨ 特徴

- 🎴 **ガチャシステム**: ソーシャルゲーム風のリッチなカード演出
- 🔄 **3Dフリップアニメーション**: カードを裏返す際のスムーズな3Dアニメーション
- 🎨 **MTG風カードデザイン**: Magic: The Gatheringにインスパイアされた美しいカードデザイン
- 🌍 **多言語対応**: 日本語と英語に対応（簡単に他の言語も追加可能）
- 📱 **クロスプラットフォーム**: macOS、Windows、Linuxで動作

## 🎮 使い方

1. **ガチャを引く**: 画面下部の「SPIN」ボタンをクリック
2. **カードをめくる**: 伏せられたカードをクリックして1枚ずつめくる
   - または「REVEAL ALL」ボタンですべて一括表示
3. **詳細を確認**: めくられたカードをクリックしてモーダルで拡大表示
4. **新しいガチャ**: もう一度「SPIN」ボタンを押すと、カードがリセットされて新しいガチャが始まります

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
├── features/                # 機能別モジュール
│   └── gacha/              # ガチャ機能
│       ├── animated_gacha_card.dart
│       ├── card_back_widget.dart
│       ├── card_detail_modal.dart
│       ├── card_widget.dart
│       ├── gacha_card_state.dart
│       ├── gacha_provider.dart
│       └── gacha_screen.dart
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

---

Made with ❤️ using Flutter

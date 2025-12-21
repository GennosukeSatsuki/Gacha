// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'アイデアミキサー';

  @override
  String get gachaPrompt => 'ボタンを押してインスピレーションを得よう！';

  @override
  String get spinButton => 'ガチャを回す';

  @override
  String get charDragon => 'ドラゴン';

  @override
  String get charDragonDesc => '古代から生きる伝説の生物。知恵者だが強欲。';

  @override
  String get charElf => 'エルフ';

  @override
  String get charElfDesc => '森の守護者。弓の名手で長寿。';

  @override
  String get charDwarf => 'ドワーフ';

  @override
  String get charDwarfDesc => '地下に住む鍛冶職人。頑固で酒好き。';

  @override
  String get charGoblin => 'ゴブリン';

  @override
  String get charGoblinDesc => '小賢しい魔物。集団で行動する。';

  @override
  String get charGirl => '女子高生';

  @override
  String get charGirlDesc => '現代の象徴。タピオカとSNSが好き。';

  @override
  String get charSalaryman => 'おじさん';

  @override
  String get charSalarymanDesc => '疲れたサラリーマン。実は異世界転生者かも？';

  @override
  String get charHero => '勇者';

  @override
  String get charHeroDesc => '魔王を倒す宿命を背負った若者。';

  @override
  String get charDemonKing => '魔王';

  @override
  String get charDemonKingDesc => '世界を恐怖に陥れる存在。実は寂しがり屋。';

  @override
  String get storyOfficeRomance => '職場恋愛';

  @override
  String get storyOfficeRomanceDesc => '意外な場所でのロマンス。周囲には秘密。';

  @override
  String get storyChanceEncounter => '偶然の出会い';

  @override
  String get storyChanceEncounterDesc => '街角でぶつかったのが運命の始まり。';

  @override
  String get storyStormyNight => '嵐の夜';

  @override
  String get storyStormyNightDesc => '閉ざされた空間で何かが起きる。';

  @override
  String get storyTimeLeap => 'タイムリープ';

  @override
  String get storyTimeLeapDesc => '同じ時間を繰り返して未来を変える。';

  @override
  String get storyBetrayal => '裏切り';

  @override
  String get storyBetrayalDesc => '信頼していた仲間の予想外の行動。';

  @override
  String get storyTreasureMap => '宝の地図';

  @override
  String get storyTreasureMapDesc => '隠された財宝を巡る冒険の幕開け。';

  @override
  String get typeCharacter => 'キャラ';

  @override
  String get typeStory => 'ストーリー';

  @override
  String get settings => '設定';

  @override
  String get gachaSettings => 'ガチャ設定';

  @override
  String get characterCount => 'キャラクター枚数';

  @override
  String get characterCountDesc => '1回のガチャで引くキャラクター数';

  @override
  String get storyCount => 'ストーリー枚数';

  @override
  String get storyCountDesc => '1回のガチャで引くストーリー数';

  @override
  String get revealAll => 'すべて開く';

  @override
  String get clear => 'リセット';

  @override
  String get language => '言語';

  @override
  String get japanese => '日本語';

  @override
  String get english => '英語';

  @override
  String get about => 'アプリについて';

  @override
  String get version => 'バージョン';

  @override
  String get license => 'ライセンス';

  @override
  String get github => 'GitHub';

  @override
  String get basicSettings => '基本設定';

  @override
  String get cardSettings => 'カード設定';

  @override
  String get general => '一般';

  @override
  String get emissionSettings => '排出設定';

  @override
  String get includeDefaultSet => 'デフォルトセットを含める';

  @override
  String get includeDefaultSetDesc => '組み込みのサンプルカードを排出に含めます';

  @override
  String get importedSets => 'インポート済みセット';

  @override
  String get noImportedSets => 'インポートされたセットはありません';

  @override
  String cardCountLabel(int count) {
    return '$count 枚のカード';
  }

  @override
  String get import => 'インポート';

  @override
  String get importCustomSet => 'カスタムセットをインポート';

  @override
  String get selectManifestJson => 'manifest.jsonを選択してください';

  @override
  String get importSuccess => 'インポートに成功しました';

  @override
  String importError(Object error) {
    return 'エラー: $error';
  }

  @override
  String get charCrystal => '神秘のクリスタル';

  @override
  String get charCrystalDesc => '洞窟の最深部で浮遊する巨大な結晶。見る者のインスピレーションを増幅させる。';

  @override
  String get elementFire => '火';

  @override
  String get elementWater => '水';

  @override
  String get elementWind => '風';

  @override
  String get elementEarth => '地';

  @override
  String get elementLight => '光';

  @override
  String get elementDark => '闇';

  @override
  String get elementNeutral => '無';

  @override
  String get openCustomSetsFolder => 'セットフォルダを開く';

  @override
  String get selectZipOrJson => '.zip または manifest.json を選択してください';

  @override
  String get tabGacha => 'ガチャ';

  @override
  String get tabStudio => 'スタジオ';

  @override
  String get noSetsYet => 'カスタムセットがまだありません';

  @override
  String get createFirstSet => '最初のセットを作成';

  @override
  String get createNewSet => '新規セット作成';

  @override
  String get enterSetName => 'セット名を入力 (例: ミステリー)';

  @override
  String get cancel => 'キャンセル';

  @override
  String get create => '作成';

  @override
  String get setNotFound => 'セットが見つかりません';

  @override
  String get emptySet => 'このセットにはカードがありません';

  @override
  String get addFirstCard => '最初のカードを追加';

  @override
  String get deleteCard => 'カードを削除';

  @override
  String deleteCardConfirm(String title) {
    return '「$title」を削除してもよろしいですか？';
  }

  @override
  String get delete => '削除';

  @override
  String get newCard => '新規カード';

  @override
  String get editCard => 'カードの編集';

  @override
  String get basicInfo => '基本情報';

  @override
  String get cardProperties => '属性・ステータス';

  @override
  String get titleLabel => '名前';

  @override
  String get descriptionLabel => '説明';

  @override
  String get typeLabel => 'タイプ';

  @override
  String get elementLabel => '属性';

  @override
  String get rarityLabel => 'レアリティ';

  @override
  String get manaCostLabel => 'コスト';

  @override
  String get powerLabel => 'パワー';

  @override
  String get toughnessLabel => 'タフネス';

  @override
  String get preview => 'プレビュー';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get homeTagline => 'カラフルなボールをチューブに仕分けよう';

  @override
  String get playButton => 'プレイ';

  @override
  String continueLevel(int level) {
    return 'つづきから · レベル$level';
  }

  @override
  String get chooseLevel => 'レベルを選ぶ';

  @override
  String record(int level) {
    return '記録: $level';
  }

  @override
  String get removeAdsTitle => '広告なし';

  @override
  String get removeAdsBody => 'プレイを邪魔するバナーや広告を削除。一度の支払いでずっと使えます。';

  @override
  String buyForPrice(String price) {
    return '購入 • $price';
  }

  @override
  String get restore => '復元';

  @override
  String get later => 'あとで';

  @override
  String get dailyBonusTitle => '🎁 デイリーボーナス';

  @override
  String coinsReward(int amount) {
    return '+$amount コイン';
  }

  @override
  String streakDay(int days) {
    return '連続: $days日';
  }

  @override
  String get claimReward => '受け取る 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return '今日のボーナスは受け取り済み。また明日来てね！🔥 $streak日';
  }

  @override
  String levelTitle(int level) {
    return 'レベル$level';
  }

  @override
  String hintTooltip(int cost) {
    return 'ヒント（$costコイン）';
  }

  @override
  String get soundOn => 'サウンドをオン';

  @override
  String get soundOff => 'サウンドをオフ';

  @override
  String get skipLevel => 'レベルをスキップ 🎬';

  @override
  String get resetCheckpoint => 'チェックポイントをリセット 🎬';

  @override
  String get wonTitle => '🎉 クリア！';

  @override
  String levelComplete(int level) {
    return 'レベル$level クリア！';
  }

  @override
  String get back => 'もどる';

  @override
  String get bonusLevels => '+2レベル 🎁';

  @override
  String get next => 'つぎへ';

  @override
  String get checkpointReset => '🔄 パズルをチェックポイントまで戻しました！';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2レベル解放！レベル$newMaxまで進めます';
  }

  @override
  String get noUsefulMove => '今は有効な手がありません 🤔';

  @override
  String get hintTitle => '💡 ヒント';

  @override
  String get hintNotEnoughCoins => 'コインが足りません。広告を見て無料ヒントをもらいますか？';

  @override
  String get decline => 'やめておく';

  @override
  String get watchAd => '見る 🎬';

  @override
  String get shopTitle => 'ショップ';

  @override
  String needMoreCoins(int amount) {
    return 'あと$amountコイン必要です。レベルをプレイして稼ごう！🪙';
  }

  @override
  String buySkinTitle(String name) {
    return '「$name」を購入しますか？';
  }

  @override
  String skinCost(int cost) {
    return 'コスト: $costコイン。';
  }

  @override
  String get no => 'いいえ';

  @override
  String get buy => '購入';

  @override
  String get equipped => '装備中 ✓';

  @override
  String get equip => '装備する';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => '広告を消そう';

  @override
  String get removeAdsHouseBody => 'バナーも邪魔な広告もなしでプレイ。一度きり、ずっと使えます。';

  @override
  String removeAdsForPrice(String price) {
    return '広告を削除 • $price';
  }

  @override
  String get skinDefault => 'クラシック';

  @override
  String get skinNeon => 'ネオン';

  @override
  String get skinCandy => 'キャンディ';

  @override
  String get skinOcean => 'オーシャン';

  @override
  String get skinSunset => 'サンセット';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'サクッとボール仕分けで一勝負しませんか？🎯';
}

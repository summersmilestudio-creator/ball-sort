// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get homeTagline => '把彩色小球分类装进试管';

  @override
  String get playButton => '开始';

  @override
  String continueLevel(int level) {
    return '继续 · 第$level关';
  }

  @override
  String get chooseLevel => '选择关卡';

  @override
  String record(int level) {
    return '记录：$level';
  }

  @override
  String get removeAdsTitle => '无广告';

  @override
  String get removeAdsBody => '去除打断你的横幅和广告。一次付费，永久有效。';

  @override
  String buyForPrice(String price) {
    return '购买 • $price';
  }

  @override
  String get restore => '恢复购买';

  @override
  String get later => '稍后';

  @override
  String get dailyBonusTitle => '🎁 每日奖励';

  @override
  String coinsReward(int amount) {
    return '+$amount 金币';
  }

  @override
  String streakDay(int days) {
    return '连续：$days天';
  }

  @override
  String get claimReward => '领取 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return '今天的奖励已领取，明天再来吧！🔥 $streak天';
  }

  @override
  String levelTitle(int level) {
    return '第$level关';
  }

  @override
  String hintTooltip(int cost) {
    return '提示（$cost金币）';
  }

  @override
  String get soundOn => '开启声音';

  @override
  String get soundOff => '关闭声音';

  @override
  String get skipLevel => '跳过关卡 🎬';

  @override
  String get resetCheckpoint => '重置存档点 🎬';

  @override
  String get wonTitle => '🎉 通关！';

  @override
  String levelComplete(int level) {
    return '第$level关完成！';
  }

  @override
  String get back => '返回';

  @override
  String get bonusLevels => '+2 关 🎁';

  @override
  String get next => '下一关';

  @override
  String get checkpointReset => '🔄 谜题已重置到存档点！';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 解锁 +2 关！可玩到第$newMax关';
  }

  @override
  String get noUsefulMove => '现在没有有用的移动 🤔';

  @override
  String get hintTitle => '💡 提示';

  @override
  String get hintNotEnoughCoins => '金币不够。观看广告获取免费提示吗？';

  @override
  String get decline => '暂不';

  @override
  String get watchAd => '观看 🎬';

  @override
  String get shopTitle => '商店';

  @override
  String needMoreCoins(int amount) {
    return '还差$amount金币。多玩几关来赚取吧！🪙';
  }

  @override
  String buySkinTitle(String name) {
    return '购买“$name”？';
  }

  @override
  String skinCost(int cost) {
    return '花费：$cost金币。';
  }

  @override
  String get no => '否';

  @override
  String get buy => '购买';

  @override
  String get equipped => '已装备 ✓';

  @override
  String get equip => '装备';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => '告别广告';

  @override
  String get removeAdsHouseBody => '畅玩无横幅、无打扰广告。一次付费，永久有效。';

  @override
  String removeAdsForPrice(String price) {
    return '移除广告 • $price';
  }

  @override
  String get skinDefault => '经典';

  @override
  String get skinNeon => '霓虹';

  @override
  String get skinCandy => '糖果';

  @override
  String get skinOcean => '海洋';

  @override
  String get skinSunset => '日落';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => '来局快速分球小游戏？🎯';

  @override
  String get coinsSectionTitle => '金币';

  @override
  String watchAdForCoins(int amount) {
    return '观看广告 +$amount';
  }

  @override
  String coinsAdded(int amount) {
    return '+$amount 金币！';
  }

  @override
  String get storeUnavailable => '商店不可用';
}

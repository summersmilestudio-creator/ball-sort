// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTagline => 'Sort the colored balls into tubes';

  @override
  String get playButton => 'PLAY';

  @override
  String continueLevel(int level) {
    return 'CONTINUE · Level $level';
  }

  @override
  String get chooseLevel => 'Choose a level';

  @override
  String record(int level) {
    return 'Best: $level';
  }

  @override
  String get removeAdsTitle => 'No ads';

  @override
  String get removeAdsBody =>
      'Remove the banners and ads that interrupt you. One payment, forever.';

  @override
  String buyForPrice(String price) {
    return 'Buy • $price';
  }

  @override
  String get restore => 'Restore';

  @override
  String get later => 'Later';

  @override
  String get dailyBonusTitle => '🎁 Daily bonus';

  @override
  String coinsReward(int amount) {
    return '+$amount coins';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Streak: $days $_temp0';
  }

  @override
  String get claimReward => 'Claim 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Today\'s bonus is claimed. Come back tomorrow! 🔥 $streak days';
  }

  @override
  String levelTitle(int level) {
    return 'Level $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Hint ($cost coins)';
  }

  @override
  String get soundOn => 'Turn sound on';

  @override
  String get soundOff => 'Turn sound off';

  @override
  String get skipLevel => 'Skip level 🎬';

  @override
  String get resetCheckpoint => 'Reset checkpoint 🎬';

  @override
  String get wonTitle => '🎉 You won!';

  @override
  String levelComplete(int level) {
    return 'Level $level complete!';
  }

  @override
  String get back => 'Back';

  @override
  String get bonusLevels => '+2 levels 🎁';

  @override
  String get next => 'Next';

  @override
  String get checkpointReset => '🔄 Puzzle reset to checkpoint!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 levels unlocked! Play up to $newMax';
  }

  @override
  String get noUsefulMove => 'No useful move right now 🤔';

  @override
  String get hintTitle => '💡 Hint';

  @override
  String get hintNotEnoughCoins =>
      'You don\'t have enough coins. Watch an ad for a free hint?';

  @override
  String get decline => 'No thanks';

  @override
  String get watchAd => 'Watch 🎬';

  @override
  String get shopTitle => 'Shop';

  @override
  String needMoreCoins(int amount) {
    return 'You need $amount more coins. Play levels to earn them! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Buy \"$name\"?';
  }

  @override
  String skinCost(int cost) {
    return 'Cost: $cost coins.';
  }

  @override
  String get no => 'No';

  @override
  String get buy => 'Buy';

  @override
  String get equipped => 'Equipped ✓';

  @override
  String get equip => 'Equip';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Ditch the ads';

  @override
  String get removeAdsHouseBody =>
      'Play with no banners and no ads to interrupt you. One time, forever.';

  @override
  String removeAdsForPrice(String price) {
    return 'Remove ads • $price';
  }

  @override
  String get skinDefault => 'Classic';

  @override
  String get skinNeon => 'Neon';

  @override
  String get skinCandy => 'Candy';

  @override
  String get skinOcean => 'Ocean';

  @override
  String get skinSunset => 'Sunset';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Up for a quick ball-sorting round? 🎯';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get homeTagline => 'Sortează bilele colorate în tuburi';

  @override
  String get playButton => 'JOACĂ';

  @override
  String continueLevel(int level) {
    return 'CONTINUĂ · Nivel $level';
  }

  @override
  String get chooseLevel => 'Alege nivelul';

  @override
  String record(int level) {
    return 'Record: $level';
  }

  @override
  String get removeAdsTitle => 'Fără reclame';

  @override
  String get removeAdsBody =>
      'Elimină bannerele și reclamele care te întrerup. O singură plată, pentru totdeauna.';

  @override
  String buyForPrice(String price) {
    return 'Cumpără • $price';
  }

  @override
  String get restore => 'Restaurează';

  @override
  String get later => 'Mai târziu';

  @override
  String get dailyBonusTitle => '🎁 Bonus zilnic';

  @override
  String coinsReward(int amount) {
    return '+$amount monede';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'zile',
      one: 'zi',
    );
    return 'Serie: $days $_temp0';
  }

  @override
  String get claimReward => 'Revendică 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Bonusul de azi e luat. Revino mâine! 🔥 $streak zile';
  }

  @override
  String levelTitle(int level) {
    return 'Nivel $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Indiciu ($cost monede)';
  }

  @override
  String get soundOn => 'Pornește sunetul';

  @override
  String get soundOff => 'Oprește sunetul';

  @override
  String get skipLevel => 'Sari peste nivel 🎬';

  @override
  String get resetCheckpoint => 'Reset checkpoint 🎬';

  @override
  String get wonTitle => '🎉 Câștigat!';

  @override
  String levelComplete(int level) {
    return 'Nivel $level complet!';
  }

  @override
  String get back => 'Înapoi';

  @override
  String get bonusLevels => '+2 niveluri 🎁';

  @override
  String get next => 'Următor';

  @override
  String get checkpointReset => '🔄 Puzzle resetat din checkpoint!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 niveluri deblocate! Mergi până la $newMax';
  }

  @override
  String get noUsefulMove => 'Nicio mutare utilă acum 🤔';

  @override
  String get hintTitle => '💡 Indiciu';

  @override
  String get hintNotEnoughCoins =>
      'Nu ai destule monede. Urmărești o reclamă pentru un indiciu gratuit?';

  @override
  String get decline => 'Renunț';

  @override
  String get watchAd => 'Urmărește 🎬';

  @override
  String get shopTitle => 'Magazin';

  @override
  String needMoreCoins(int amount) {
    return 'Îți mai trebuie $amount monede. Joacă niveluri ca să câștigi! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Cumperi \"$name\"?';
  }

  @override
  String skinCost(int cost) {
    return 'Cost: $cost monede.';
  }

  @override
  String get no => 'Nu';

  @override
  String get buy => 'Cumpără';

  @override
  String get equipped => 'Echipat ✓';

  @override
  String get equip => 'Echipează';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Scapă de reclame';

  @override
  String get removeAdsHouseBody =>
      'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.';

  @override
  String removeAdsForPrice(String price) {
    return 'Elimină reclamele • $price';
  }

  @override
  String get skinDefault => 'Clasic';

  @override
  String get skinNeon => 'Neon';

  @override
  String get skinCandy => 'Bomboane';

  @override
  String get skinOcean => 'Ocean';

  @override
  String get skinSunset => 'Apus';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'O partidă rapidă de sortare bile? 🎯';

  @override
  String get coinsSectionTitle => 'Monede';

  @override
  String watchAdForCoins(int amount) {
    return 'Vezi reclamă +$amount';
  }

  @override
  String coinsAdded(int amount) {
    return '+$amount monede!';
  }

  @override
  String get storeUnavailable => 'Magazin indisponibil';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get homeTagline => 'Sortiere die bunten Kugeln in die Röhren';

  @override
  String get playButton => 'SPIELEN';

  @override
  String continueLevel(int level) {
    return 'WEITER · Level $level';
  }

  @override
  String get chooseLevel => 'Level wählen';

  @override
  String record(int level) {
    return 'Rekord: $level';
  }

  @override
  String get removeAdsTitle => 'Keine Werbung';

  @override
  String get removeAdsBody =>
      'Entferne die Banner und Werbung, die dich stören. Einmal zahlen, für immer.';

  @override
  String buyForPrice(String price) {
    return 'Kaufen • $price';
  }

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get later => 'Später';

  @override
  String get dailyBonusTitle => '🎁 Täglicher Bonus';

  @override
  String coinsReward(int amount) {
    return '+$amount Münzen';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Tage',
      one: 'Tag',
    );
    return 'Serie: $days $_temp0';
  }

  @override
  String get claimReward => 'Abholen 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Der heutige Bonus ist abgeholt. Komm morgen wieder! 🔥 $streak Tage';
  }

  @override
  String levelTitle(int level) {
    return 'Level $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Tipp ($cost Münzen)';
  }

  @override
  String get soundOn => 'Ton einschalten';

  @override
  String get soundOff => 'Ton ausschalten';

  @override
  String get skipLevel => 'Level überspringen 🎬';

  @override
  String get resetCheckpoint => 'Checkpoint zurücksetzen 🎬';

  @override
  String get wonTitle => '🎉 Gewonnen!';

  @override
  String levelComplete(int level) {
    return 'Level $level geschafft!';
  }

  @override
  String get back => 'Zurück';

  @override
  String get bonusLevels => '+2 Level 🎁';

  @override
  String get next => 'Weiter';

  @override
  String get checkpointReset => '🔄 Puzzle auf Checkpoint zurückgesetzt!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 Level freigeschaltet! Spiel bis Level $newMax';
  }

  @override
  String get noUsefulMove => 'Gerade kein sinnvoller Zug 🤔';

  @override
  String get hintTitle => '💡 Tipp';

  @override
  String get hintNotEnoughCoins =>
      'Du hast nicht genug Münzen. Werbung für einen Gratis-Tipp ansehen?';

  @override
  String get decline => 'Nein danke';

  @override
  String get watchAd => 'Ansehen 🎬';

  @override
  String get shopTitle => 'Shop';

  @override
  String needMoreCoins(int amount) {
    return 'Dir fehlen $amount Münzen. Spiel Level, um sie zu verdienen! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return '\"$name\" kaufen?';
  }

  @override
  String skinCost(int cost) {
    return 'Kosten: $cost Münzen.';
  }

  @override
  String get no => 'Nein';

  @override
  String get buy => 'Kaufen';

  @override
  String get equipped => 'Ausgerüstet ✓';

  @override
  String get equip => 'Ausrüsten';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Schluss mit Werbung';

  @override
  String get removeAdsHouseBody =>
      'Spiel ohne Banner und ohne störende Werbung. Einmal, für immer.';

  @override
  String removeAdsForPrice(String price) {
    return 'Werbung entfernen • $price';
  }

  @override
  String get skinDefault => 'Klassisch';

  @override
  String get skinNeon => 'Neon';

  @override
  String get skinCandy => 'Bonbon';

  @override
  String get skinOcean => 'Ozean';

  @override
  String get skinSunset => 'Sonnenuntergang';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Lust auf eine schnelle Runde Kugelsortieren? 🎯';
}

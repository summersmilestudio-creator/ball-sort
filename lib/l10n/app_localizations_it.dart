// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get homeTagline => 'Ordina le palline colorate nei tubi';

  @override
  String get playButton => 'GIOCA';

  @override
  String continueLevel(int level) {
    return 'CONTINUA · Livello $level';
  }

  @override
  String get chooseLevel => 'Scegli un livello';

  @override
  String record(int level) {
    return 'Record: $level';
  }

  @override
  String get removeAdsTitle => 'Senza pubblicità';

  @override
  String get removeAdsBody =>
      'Elimina i banner e le pubblicità che ti interrompono. Un solo pagamento, per sempre.';

  @override
  String buyForPrice(String price) {
    return 'Acquista • $price';
  }

  @override
  String get restore => 'Ripristina';

  @override
  String get later => 'Più tardi';

  @override
  String get dailyBonusTitle => '🎁 Bonus giornaliero';

  @override
  String coinsReward(int amount) {
    return '+$amount monete';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return 'Serie: $days $_temp0';
  }

  @override
  String get claimReward => 'Riscatta 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Il bonus di oggi è stato riscattato. Torna domani! 🔥 $streak giorni';
  }

  @override
  String levelTitle(int level) {
    return 'Livello $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Suggerimento ($cost monete)';
  }

  @override
  String get soundOn => 'Attiva audio';

  @override
  String get soundOff => 'Disattiva audio';

  @override
  String get skipLevel => 'Salta livello 🎬';

  @override
  String get resetCheckpoint => 'Reimposta checkpoint 🎬';

  @override
  String get wonTitle => '🎉 Hai vinto!';

  @override
  String levelComplete(int level) {
    return 'Livello $level completato!';
  }

  @override
  String get back => 'Indietro';

  @override
  String get bonusLevels => '+2 livelli 🎁';

  @override
  String get next => 'Avanti';

  @override
  String get checkpointReset => '🔄 Puzzle ripristinato dal checkpoint!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 livelli sbloccati! Arriva fino al $newMax';
  }

  @override
  String get noUsefulMove => 'Nessuna mossa utile al momento 🤔';

  @override
  String get hintTitle => '💡 Suggerimento';

  @override
  String get hintNotEnoughCoins =>
      'Non hai abbastanza monete. Guardi una pubblicità per un suggerimento gratis?';

  @override
  String get decline => 'No, grazie';

  @override
  String get watchAd => 'Guarda 🎬';

  @override
  String get shopTitle => 'Negozio';

  @override
  String needMoreCoins(int amount) {
    return 'Ti mancano $amount monete. Gioca i livelli per guadagnarle! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Acquistare \"$name\"?';
  }

  @override
  String skinCost(int cost) {
    return 'Costo: $cost monete.';
  }

  @override
  String get no => 'No';

  @override
  String get buy => 'Acquista';

  @override
  String get equipped => 'Equipaggiato ✓';

  @override
  String get equip => 'Equipaggia';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Via la pubblicità';

  @override
  String get removeAdsHouseBody =>
      'Gioca senza banner e senza pubblicità che ti interrompono. Una sola volta, per sempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Rimuovi pubblicità • $price';
  }

  @override
  String get skinDefault => 'Classico';

  @override
  String get skinNeon => 'Neon';

  @override
  String get skinCandy => 'Caramella';

  @override
  String get skinOcean => 'Oceano';

  @override
  String get skinSunset => 'Tramonto';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Una partita veloce a ordinare palline? 🎯';
}

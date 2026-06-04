// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get homeTagline => 'Triez les billes colorées dans les tubes';

  @override
  String get playButton => 'JOUER';

  @override
  String continueLevel(int level) {
    return 'CONTINUER · Niveau $level';
  }

  @override
  String get chooseLevel => 'Choisis un niveau';

  @override
  String record(int level) {
    return 'Record : $level';
  }

  @override
  String get removeAdsTitle => 'Sans pub';

  @override
  String get removeAdsBody =>
      'Supprime les bannières et les pubs qui t\'interrompent. Un seul paiement, pour toujours.';

  @override
  String buyForPrice(String price) {
    return 'Acheter • $price';
  }

  @override
  String get restore => 'Restaurer';

  @override
  String get later => 'Plus tard';

  @override
  String get dailyBonusTitle => '🎁 Bonus quotidien';

  @override
  String coinsReward(int amount) {
    return '+$amount pièces';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Série : $days $_temp0';
  }

  @override
  String get claimReward => 'Récupérer 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Le bonus du jour est récupéré. Reviens demain ! 🔥 $streak jours';
  }

  @override
  String levelTitle(int level) {
    return 'Niveau $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Indice ($cost pièces)';
  }

  @override
  String get soundOn => 'Activer le son';

  @override
  String get soundOff => 'Couper le son';

  @override
  String get skipLevel => 'Passer le niveau 🎬';

  @override
  String get resetCheckpoint => 'Réinitialiser le checkpoint 🎬';

  @override
  String get wonTitle => '🎉 Gagné !';

  @override
  String levelComplete(int level) {
    return 'Niveau $level terminé !';
  }

  @override
  String get back => 'Retour';

  @override
  String get bonusLevels => '+2 niveaux 🎁';

  @override
  String get next => 'Suivant';

  @override
  String get checkpointReset => '🔄 Puzzle réinitialisé au checkpoint !';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 niveaux débloqués ! Va jusqu\'au $newMax';
  }

  @override
  String get noUsefulMove => 'Aucun coup utile pour l\'instant 🤔';

  @override
  String get hintTitle => '💡 Indice';

  @override
  String get hintNotEnoughCoins =>
      'Tu n\'as pas assez de pièces. Regarder une pub pour un indice gratuit ?';

  @override
  String get decline => 'Non merci';

  @override
  String get watchAd => 'Regarder 🎬';

  @override
  String get shopTitle => 'Boutique';

  @override
  String needMoreCoins(int amount) {
    return 'Il te manque $amount pièces. Joue des niveaux pour en gagner ! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Acheter « $name » ?';
  }

  @override
  String skinCost(int cost) {
    return 'Coût : $cost pièces.';
  }

  @override
  String get no => 'Non';

  @override
  String get buy => 'Acheter';

  @override
  String get equipped => 'Équipé ✓';

  @override
  String get equip => 'Équiper';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Fini les pubs';

  @override
  String get removeAdsHouseBody =>
      'Joue sans bannières ni pubs qui t\'interrompent. Une seule fois, pour toujours.';

  @override
  String removeAdsForPrice(String price) {
    return 'Supprimer les pubs • $price';
  }

  @override
  String get skinDefault => 'Classique';

  @override
  String get skinNeon => 'Néon';

  @override
  String get skinCandy => 'Bonbon';

  @override
  String get skinOcean => 'Océan';

  @override
  String get skinSunset => 'Coucher de soleil';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Une petite partie de tri de billes ? 🎯';
}

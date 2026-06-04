// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get homeTagline => 'Ordena las bolas de colores en los tubos';

  @override
  String get playButton => 'JUGAR';

  @override
  String continueLevel(int level) {
    return 'CONTINUAR · Nivel $level';
  }

  @override
  String get chooseLevel => 'Elige un nivel';

  @override
  String record(int level) {
    return 'Récord: $level';
  }

  @override
  String get removeAdsTitle => 'Sin anuncios';

  @override
  String get removeAdsBody =>
      'Elimina los banners y los anuncios que te interrumpen. Un solo pago, para siempre.';

  @override
  String buyForPrice(String price) {
    return 'Comprar • $price';
  }

  @override
  String get restore => 'Restaurar';

  @override
  String get later => 'Más tarde';

  @override
  String get dailyBonusTitle => '🎁 Bonus diario';

  @override
  String coinsReward(int amount) {
    return '+$amount monedas';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Racha: $days $_temp0';
  }

  @override
  String get claimReward => 'Reclamar 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Ya tienes el bonus de hoy. ¡Vuelve mañana! 🔥 $streak días';
  }

  @override
  String levelTitle(int level) {
    return 'Nivel $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Pista ($cost monedas)';
  }

  @override
  String get soundOn => 'Activar sonido';

  @override
  String get soundOff => 'Silenciar';

  @override
  String get skipLevel => 'Saltar nivel 🎬';

  @override
  String get resetCheckpoint => 'Reiniciar checkpoint 🎬';

  @override
  String get wonTitle => '🎉 ¡Ganaste!';

  @override
  String levelComplete(int level) {
    return '¡Nivel $level completado!';
  }

  @override
  String get back => 'Volver';

  @override
  String get bonusLevels => '+2 niveles 🎁';

  @override
  String get next => 'Siguiente';

  @override
  String get checkpointReset => '🔄 ¡Puzle reiniciado desde el checkpoint!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 ¡+2 niveles desbloqueados! Avanza hasta el $newMax';
  }

  @override
  String get noUsefulMove => 'Ningún movimiento útil ahora 🤔';

  @override
  String get hintTitle => '💡 Pista';

  @override
  String get hintNotEnoughCoins =>
      'No tienes suficientes monedas. ¿Ves un anuncio para una pista gratis?';

  @override
  String get decline => 'No, gracias';

  @override
  String get watchAd => 'Ver 🎬';

  @override
  String get shopTitle => 'Tienda';

  @override
  String needMoreCoins(int amount) {
    return 'Te faltan $amount monedas. ¡Juega niveles para conseguirlas! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return '¿Comprar \"$name\"?';
  }

  @override
  String skinCost(int cost) {
    return 'Coste: $cost monedas.';
  }

  @override
  String get no => 'No';

  @override
  String get buy => 'Comprar';

  @override
  String get equipped => 'Equipado ✓';

  @override
  String get equip => 'Equipar';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Adiós a los anuncios';

  @override
  String get removeAdsHouseBody =>
      'Juega sin banners ni anuncios que te interrumpan. Una sola vez, para siempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Quitar anuncios • $price';
  }

  @override
  String get skinDefault => 'Clásico';

  @override
  String get skinNeon => 'Neón';

  @override
  String get skinCandy => 'Caramelo';

  @override
  String get skinOcean => 'Océano';

  @override
  String get skinSunset => 'Atardecer';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => '¿Una partidita rápida ordenando bolas? 🎯';
}

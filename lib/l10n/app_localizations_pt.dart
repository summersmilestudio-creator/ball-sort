// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get homeTagline => 'Organize as bolas coloridas nos tubos';

  @override
  String get playButton => 'JOGAR';

  @override
  String continueLevel(int level) {
    return 'CONTINUAR · Nível $level';
  }

  @override
  String get chooseLevel => 'Escolha um nível';

  @override
  String record(int level) {
    return 'Recorde: $level';
  }

  @override
  String get removeAdsTitle => 'Sem anúncios';

  @override
  String get removeAdsBody =>
      'Remova os banners e anúncios que te interrompem. Um único pagamento, para sempre.';

  @override
  String buyForPrice(String price) {
    return 'Comprar • $price';
  }

  @override
  String get restore => 'Restaurar';

  @override
  String get later => 'Mais tarde';

  @override
  String get dailyBonusTitle => '🎁 Bônus diário';

  @override
  String coinsReward(int amount) {
    return '+$amount moedas';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Sequência: $days $_temp0';
  }

  @override
  String get claimReward => 'Resgatar 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'O bônus de hoje já foi resgatado. Volte amanhã! 🔥 $streak dias';
  }

  @override
  String levelTitle(int level) {
    return 'Nível $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Dica ($cost moedas)';
  }

  @override
  String get soundOn => 'Ativar som';

  @override
  String get soundOff => 'Desativar som';

  @override
  String get skipLevel => 'Pular nível 🎬';

  @override
  String get resetCheckpoint => 'Reiniciar checkpoint 🎬';

  @override
  String get wonTitle => '🎉 Você venceu!';

  @override
  String levelComplete(int level) {
    return 'Nível $level concluído!';
  }

  @override
  String get back => 'Voltar';

  @override
  String get bonusLevels => '+2 níveis 🎁';

  @override
  String get next => 'Próximo';

  @override
  String get checkpointReset => '🔄 Quebra-cabeça reiniciado do checkpoint!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 níveis desbloqueados! Avance até o $newMax';
  }

  @override
  String get noUsefulMove => 'Nenhuma jogada útil agora 🤔';

  @override
  String get hintTitle => '💡 Dica';

  @override
  String get hintNotEnoughCoins =>
      'Você não tem moedas suficientes. Assistir a um anúncio para uma dica grátis?';

  @override
  String get decline => 'Agora não';

  @override
  String get watchAd => 'Assistir 🎬';

  @override
  String get shopTitle => 'Loja';

  @override
  String needMoreCoins(int amount) {
    return 'Faltam $amount moedas. Jogue níveis para ganhá-las! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Comprar \"$name\"?';
  }

  @override
  String skinCost(int cost) {
    return 'Custo: $cost moedas.';
  }

  @override
  String get no => 'Não';

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
  String get removeAdsHouseTitle => 'Livre-se dos anúncios';

  @override
  String get removeAdsHouseBody =>
      'Jogue sem banners e sem anúncios que te interrompem. Uma única vez, para sempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Remover anúncios • $price';
  }

  @override
  String get skinDefault => 'Clássico';

  @override
  String get skinNeon => 'Neon';

  @override
  String get skinCandy => 'Doce';

  @override
  String get skinOcean => 'Oceano';

  @override
  String get skinSunset => 'Pôr do sol';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Que tal uma partida rápida organizando bolas? 🎯';

  @override
  String get coinsSectionTitle => 'Moedas';

  @override
  String watchAdForCoins(int amount) {
    return 'Ver anúncio +$amount';
  }

  @override
  String coinsAdded(int amount) {
    return '+$amount moedas!';
  }

  @override
  String get storeUnavailable => 'Loja indisponível';
}

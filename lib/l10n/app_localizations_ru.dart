// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get homeTagline => 'Сортируй цветные шарики по колбам';

  @override
  String get playButton => 'ИГРАТЬ';

  @override
  String continueLevel(int level) {
    return 'ПРОДОЛЖИТЬ · Уровень $level';
  }

  @override
  String get chooseLevel => 'Выбери уровень';

  @override
  String record(int level) {
    return 'Рекорд: $level';
  }

  @override
  String get removeAdsTitle => 'Без рекламы';

  @override
  String get removeAdsBody =>
      'Убери баннеры и рекламу, которые тебя отвлекают. Один платёж — навсегда.';

  @override
  String buyForPrice(String price) {
    return 'Купить • $price';
  }

  @override
  String get restore => 'Восстановить';

  @override
  String get later => 'Позже';

  @override
  String get dailyBonusTitle => '🎁 Ежедневный бонус';

  @override
  String coinsReward(int amount) {
    return '+$amount монет';
  }

  @override
  String streakDay(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дней',
      many: 'дней',
      few: 'дня',
      one: 'день',
    );
    return 'Серия: $days $_temp0';
  }

  @override
  String get claimReward => 'Забрать 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return 'Сегодняшний бонус уже забран. Загляни завтра! 🔥 $streak дней';
  }

  @override
  String levelTitle(int level) {
    return 'Уровень $level';
  }

  @override
  String hintTooltip(int cost) {
    return 'Подсказка ($cost монет)';
  }

  @override
  String get soundOn => 'Включить звук';

  @override
  String get soundOff => 'Выключить звук';

  @override
  String get skipLevel => 'Пропустить уровень 🎬';

  @override
  String get resetCheckpoint => 'Сбросить до чекпоинта 🎬';

  @override
  String get wonTitle => '🎉 Победа!';

  @override
  String levelComplete(int level) {
    return 'Уровень $level пройден!';
  }

  @override
  String get back => 'Назад';

  @override
  String get bonusLevels => '+2 уровня 🎁';

  @override
  String get next => 'Дальше';

  @override
  String get checkpointReset => '🔄 Головоломка сброшена до чекпоинта!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 уровня открыто! Играй до уровня $newMax';
  }

  @override
  String get noUsefulMove => 'Сейчас нет полезных ходов 🤔';

  @override
  String get hintTitle => '💡 Подсказка';

  @override
  String get hintNotEnoughCoins =>
      'Не хватает монет. Посмотреть рекламу ради бесплатной подсказки?';

  @override
  String get decline => 'Нет, спасибо';

  @override
  String get watchAd => 'Смотреть 🎬';

  @override
  String get shopTitle => 'Магазин';

  @override
  String needMoreCoins(int amount) {
    return 'Нужно ещё $amount монет. Проходи уровни, чтобы их заработать! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return 'Купить «$name»?';
  }

  @override
  String skinCost(int cost) {
    return 'Цена: $cost монет.';
  }

  @override
  String get no => 'Нет';

  @override
  String get buy => 'Купить';

  @override
  String get equipped => 'Надето ✓';

  @override
  String get equip => 'Надеть';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => 'Долой рекламу';

  @override
  String get removeAdsHouseBody =>
      'Играй без баннеров и без рекламы, которая отвлекает. Один раз — навсегда.';

  @override
  String removeAdsForPrice(String price) {
    return 'Убрать рекламу • $price';
  }

  @override
  String get skinDefault => 'Классика';

  @override
  String get skinNeon => 'Неон';

  @override
  String get skinCandy => 'Конфеты';

  @override
  String get skinOcean => 'Океан';

  @override
  String get skinSunset => 'Закат';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => 'Быстрая партия по сортировке шариков? 🎯';
}

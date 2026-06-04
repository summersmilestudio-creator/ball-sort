// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get homeTagline => '색색의 공을 시험관에 정리하세요';

  @override
  String get playButton => '플레이';

  @override
  String continueLevel(int level) {
    return '이어하기 · 레벨 $level';
  }

  @override
  String get chooseLevel => '레벨 선택';

  @override
  String record(int level) {
    return '최고 기록: $level';
  }

  @override
  String get removeAdsTitle => '광고 없음';

  @override
  String get removeAdsBody => '플레이를 방해하는 배너와 광고를 제거하세요. 한 번 결제로 영원히.';

  @override
  String buyForPrice(String price) {
    return '구매 • $price';
  }

  @override
  String get restore => '복원';

  @override
  String get later => '나중에';

  @override
  String get dailyBonusTitle => '🎁 일일 보너스';

  @override
  String coinsReward(int amount) {
    return '+$amount 코인';
  }

  @override
  String streakDay(int days) {
    return '연속: $days일';
  }

  @override
  String get claimReward => '받기 🪙';

  @override
  String dailyAlreadyClaimed(int streak) {
    return '오늘의 보너스를 이미 받았어요. 내일 또 오세요! 🔥 $streak일';
  }

  @override
  String levelTitle(int level) {
    return '레벨 $level';
  }

  @override
  String hintTooltip(int cost) {
    return '힌트 ($cost 코인)';
  }

  @override
  String get soundOn => '소리 켜기';

  @override
  String get soundOff => '소리 끄기';

  @override
  String get skipLevel => '레벨 건너뛰기 🎬';

  @override
  String get resetCheckpoint => '체크포인트 초기화 🎬';

  @override
  String get wonTitle => '🎉 클리어!';

  @override
  String levelComplete(int level) {
    return '레벨 $level 완료!';
  }

  @override
  String get back => '뒤로';

  @override
  String get bonusLevels => '+2 레벨 🎁';

  @override
  String get next => '다음';

  @override
  String get checkpointReset => '🔄 퍼즐을 체크포인트로 되돌렸어요!';

  @override
  String bonusLevelsUnlocked(int newMax) {
    return '🎁 +2 레벨 해금! 레벨 $newMax까지 진행하세요';
  }

  @override
  String get noUsefulMove => '지금은 유용한 수가 없어요 🤔';

  @override
  String get hintTitle => '💡 힌트';

  @override
  String get hintNotEnoughCoins => '코인이 부족해요. 광고를 보고 무료 힌트를 받을까요?';

  @override
  String get decline => '괜찮아요';

  @override
  String get watchAd => '보기 🎬';

  @override
  String get shopTitle => '상점';

  @override
  String needMoreCoins(int amount) {
    return '$amount 코인이 더 필요해요. 레벨을 플레이해 모아보세요! 🪙';
  }

  @override
  String buySkinTitle(String name) {
    return '\"$name\"을(를) 구매할까요?';
  }

  @override
  String skinCost(int cost) {
    return '비용: $cost 코인.';
  }

  @override
  String get no => '아니요';

  @override
  String get buy => '구매';

  @override
  String get equipped => '장착됨 ✓';

  @override
  String get equip => '장착';

  @override
  String skinPrice(int cost) {
    return '$cost 🪙';
  }

  @override
  String get removeAdsHouseTitle => '광고 없애기';

  @override
  String get removeAdsHouseBody => '배너도, 방해되는 광고도 없이 플레이하세요. 한 번이면 영원히.';

  @override
  String removeAdsForPrice(String price) {
    return '광고 제거 • $price';
  }

  @override
  String get skinDefault => '클래식';

  @override
  String get skinNeon => '네온';

  @override
  String get skinCandy => '캔디';

  @override
  String get skinOcean => '오션';

  @override
  String get skinSunset => '선셋';

  @override
  String get notifTitle => 'Ball Sort Puzzle';

  @override
  String get notifBody => '공 정리 한 판 어때요? 🎯';

  @override
  String get coinsSectionTitle => '코인';

  @override
  String watchAdForCoins(int amount) {
    return '광고 보기 +$amount';
  }

  @override
  String coinsAdded(int amount) {
    return '+$amount 코인!';
  }

  @override
  String get storeUnavailable => '상점을 이용할 수 없어요';
}

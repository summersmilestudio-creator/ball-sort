import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @homeTagline.
  ///
  /// In ro, this message translates to:
  /// **'Sortează bilele colorate în tuburi'**
  String get homeTagline;

  /// No description provided for @playButton.
  ///
  /// In ro, this message translates to:
  /// **'JOACĂ'**
  String get playButton;

  /// No description provided for @continueLevel.
  ///
  /// In ro, this message translates to:
  /// **'CONTINUĂ · Nivel {level}'**
  String continueLevel(int level);

  /// No description provided for @chooseLevel.
  ///
  /// In ro, this message translates to:
  /// **'Alege nivelul'**
  String get chooseLevel;

  /// No description provided for @record.
  ///
  /// In ro, this message translates to:
  /// **'Record: {level}'**
  String record(int level);

  /// No description provided for @removeAdsTitle.
  ///
  /// In ro, this message translates to:
  /// **'Fără reclame'**
  String get removeAdsTitle;

  /// No description provided for @removeAdsBody.
  ///
  /// In ro, this message translates to:
  /// **'Elimină bannerele și reclamele care te întrerup. O singură plată, pentru totdeauna.'**
  String get removeAdsBody;

  /// No description provided for @buyForPrice.
  ///
  /// In ro, this message translates to:
  /// **'Cumpără • {price}'**
  String buyForPrice(String price);

  /// No description provided for @restore.
  ///
  /// In ro, this message translates to:
  /// **'Restaurează'**
  String get restore;

  /// No description provided for @later.
  ///
  /// In ro, this message translates to:
  /// **'Mai târziu'**
  String get later;

  /// No description provided for @dailyBonusTitle.
  ///
  /// In ro, this message translates to:
  /// **'🎁 Bonus zilnic'**
  String get dailyBonusTitle;

  /// No description provided for @coinsReward.
  ///
  /// In ro, this message translates to:
  /// **'+{amount} monede'**
  String coinsReward(int amount);

  /// No description provided for @streakDay.
  ///
  /// In ro, this message translates to:
  /// **'Serie: {days} {days, plural, one{zi} other{zile}}'**
  String streakDay(int days);

  /// No description provided for @claimReward.
  ///
  /// In ro, this message translates to:
  /// **'Revendică 🪙'**
  String get claimReward;

  /// No description provided for @dailyAlreadyClaimed.
  ///
  /// In ro, this message translates to:
  /// **'Bonusul de azi e luat. Revino mâine! 🔥 {streak} zile'**
  String dailyAlreadyClaimed(int streak);

  /// No description provided for @levelTitle.
  ///
  /// In ro, this message translates to:
  /// **'Nivel {level}'**
  String levelTitle(int level);

  /// No description provided for @hintTooltip.
  ///
  /// In ro, this message translates to:
  /// **'Indiciu ({cost} monede)'**
  String hintTooltip(int cost);

  /// No description provided for @soundOn.
  ///
  /// In ro, this message translates to:
  /// **'Pornește sunetul'**
  String get soundOn;

  /// No description provided for @soundOff.
  ///
  /// In ro, this message translates to:
  /// **'Oprește sunetul'**
  String get soundOff;

  /// No description provided for @skipLevel.
  ///
  /// In ro, this message translates to:
  /// **'Sari peste nivel 🎬'**
  String get skipLevel;

  /// No description provided for @resetCheckpoint.
  ///
  /// In ro, this message translates to:
  /// **'Reset checkpoint 🎬'**
  String get resetCheckpoint;

  /// No description provided for @wonTitle.
  ///
  /// In ro, this message translates to:
  /// **'🎉 Câștigat!'**
  String get wonTitle;

  /// No description provided for @levelComplete.
  ///
  /// In ro, this message translates to:
  /// **'Nivel {level} complet!'**
  String levelComplete(int level);

  /// No description provided for @back.
  ///
  /// In ro, this message translates to:
  /// **'Înapoi'**
  String get back;

  /// No description provided for @bonusLevels.
  ///
  /// In ro, this message translates to:
  /// **'+2 niveluri 🎁'**
  String get bonusLevels;

  /// No description provided for @next.
  ///
  /// In ro, this message translates to:
  /// **'Următor'**
  String get next;

  /// No description provided for @checkpointReset.
  ///
  /// In ro, this message translates to:
  /// **'🔄 Puzzle resetat din checkpoint!'**
  String get checkpointReset;

  /// No description provided for @bonusLevelsUnlocked.
  ///
  /// In ro, this message translates to:
  /// **'🎁 +2 niveluri deblocate! Mergi până la {newMax}'**
  String bonusLevelsUnlocked(int newMax);

  /// No description provided for @noUsefulMove.
  ///
  /// In ro, this message translates to:
  /// **'Nicio mutare utilă acum 🤔'**
  String get noUsefulMove;

  /// No description provided for @hintTitle.
  ///
  /// In ro, this message translates to:
  /// **'💡 Indiciu'**
  String get hintTitle;

  /// No description provided for @hintNotEnoughCoins.
  ///
  /// In ro, this message translates to:
  /// **'Nu ai destule monede. Urmărești o reclamă pentru un indiciu gratuit?'**
  String get hintNotEnoughCoins;

  /// No description provided for @decline.
  ///
  /// In ro, this message translates to:
  /// **'Renunț'**
  String get decline;

  /// No description provided for @watchAd.
  ///
  /// In ro, this message translates to:
  /// **'Urmărește 🎬'**
  String get watchAd;

  /// No description provided for @shopTitle.
  ///
  /// In ro, this message translates to:
  /// **'Magazin'**
  String get shopTitle;

  /// No description provided for @needMoreCoins.
  ///
  /// In ro, this message translates to:
  /// **'Îți mai trebuie {amount} monede. Joacă niveluri ca să câștigi! 🪙'**
  String needMoreCoins(int amount);

  /// No description provided for @buySkinTitle.
  ///
  /// In ro, this message translates to:
  /// **'Cumperi \"{name}\"?'**
  String buySkinTitle(String name);

  /// No description provided for @skinCost.
  ///
  /// In ro, this message translates to:
  /// **'Cost: {cost} monede.'**
  String skinCost(int cost);

  /// No description provided for @no.
  ///
  /// In ro, this message translates to:
  /// **'Nu'**
  String get no;

  /// No description provided for @buy.
  ///
  /// In ro, this message translates to:
  /// **'Cumpără'**
  String get buy;

  /// No description provided for @equipped.
  ///
  /// In ro, this message translates to:
  /// **'Echipat ✓'**
  String get equipped;

  /// No description provided for @equip.
  ///
  /// In ro, this message translates to:
  /// **'Echipează'**
  String get equip;

  /// No description provided for @skinPrice.
  ///
  /// In ro, this message translates to:
  /// **'{cost} 🪙'**
  String skinPrice(int cost);

  /// No description provided for @removeAdsHouseTitle.
  ///
  /// In ro, this message translates to:
  /// **'Scapă de reclame'**
  String get removeAdsHouseTitle;

  /// No description provided for @removeAdsHouseBody.
  ///
  /// In ro, this message translates to:
  /// **'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.'**
  String get removeAdsHouseBody;

  /// No description provided for @removeAdsForPrice.
  ///
  /// In ro, this message translates to:
  /// **'Elimină reclamele • {price}'**
  String removeAdsForPrice(String price);

  /// No description provided for @skinDefault.
  ///
  /// In ro, this message translates to:
  /// **'Clasic'**
  String get skinDefault;

  /// No description provided for @skinNeon.
  ///
  /// In ro, this message translates to:
  /// **'Neon'**
  String get skinNeon;

  /// No description provided for @skinCandy.
  ///
  /// In ro, this message translates to:
  /// **'Bomboane'**
  String get skinCandy;

  /// No description provided for @skinOcean.
  ///
  /// In ro, this message translates to:
  /// **'Ocean'**
  String get skinOcean;

  /// No description provided for @skinSunset.
  ///
  /// In ro, this message translates to:
  /// **'Apus'**
  String get skinSunset;

  /// No description provided for @notifTitle.
  ///
  /// In ro, this message translates to:
  /// **'Ball Sort Puzzle'**
  String get notifTitle;

  /// No description provided for @notifBody.
  ///
  /// In ro, this message translates to:
  /// **'O partidă rapidă de sortare bile? 🎯'**
  String get notifBody;

  /// No description provided for @coinsSectionTitle.
  ///
  /// In ro, this message translates to:
  /// **'Monede'**
  String get coinsSectionTitle;

  /// No description provided for @watchAdForCoins.
  ///
  /// In ro, this message translates to:
  /// **'Vezi reclamă +{amount}'**
  String watchAdForCoins(int amount);

  /// No description provided for @coinsAdded.
  ///
  /// In ro, this message translates to:
  /// **'+{amount} monede!'**
  String coinsAdded(int amount);

  /// No description provided for @storeUnavailable.
  ///
  /// In ro, this message translates to:
  /// **'Magazin indisponibil'**
  String get storeUnavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ro',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

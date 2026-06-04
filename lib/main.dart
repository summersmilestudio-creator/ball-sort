import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:ball_sort/l10n/app_localizations.dart';
import 'services/notification_service.dart';
import 'services/review_service.dart';
import 'screens/home_screen.dart';
import 'services/ads_service.dart';
import 'services/audio_service.dart';
import 'services/meta_service.dart';
import 'services/purchase_service.dart';
import 'widgets/remove_ads_offer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseService.instance.initialize();
  await AdsService.instance.initialize();
  await MetaService.instance.init();
  AudioService.instance.init();
  ReviewService.instance.registerLaunch();
  NotificationService.instance.scheduleEvery6Hours(
    title: NotificationStrings.title(),
    body: NotificationStrings.body(),
  );
  runApp(const BallSortApp());
}

class BallSortApp extends StatefulWidget {
  const BallSortApp({super.key});

  @override
  State<BallSortApp> createState() => _BallSortAppState();
}

class _BallSortAppState extends State<BallSortApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Show the upsell right after a full-screen ad (App Open / interstitial) closes.
    AdsService.instance.adClosedTick.addListener(_onAdClosed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AdsService.instance.adClosedTick.removeListener(_onAdClosed);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AdsService.instance.showAppOpenIfReady();
    }
  }

  void _onAdClosed() {
    final ctx = navigatorKey.currentContext;
    if (ctx != null) RemoveAdsOffer.maybeShow(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ball Sort',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6F00),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: UpgradeAlert(child: const HomeScreen()),
    );
  }
}

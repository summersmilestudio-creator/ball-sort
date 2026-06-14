import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'meta_service.dart';

/// A consumable coin pack sold for real money. [coins] is the base amount and
/// [bonus] is the extra granted on top; [total] is what the player receives.
class CoinPack {
  final String id;
  final int coins;
  final int bonus;
  const CoinPack(this.id, this.coins, this.bonus);
  int get total => coins + bonus;
}

/// Singleton handling in-app purchases for Ball Sort: the single "Remove Ads"
/// non-consumable plus consumable coin packs.
///
/// All product ids are *logical*; on iOS the platform product id carries a
/// `_ball` suffix (e.g. `noads_ball`, `coins_500_ball`) while Android uses the
/// bare logical id. The no-ads state is persisted under SharedPreferences key
/// `noAds_ball` and exposed via [noAds] / [noAdsNotifier] so ad widgets can gate
/// themselves; coin packs deposit into [MetaService].
class PurchaseService {
  PurchaseService._();
  static final PurchaseService instance = PurchaseService._();

  static const String noAdsId = 'noads';

  /// Coin packs in display order. LOGICAL ids only — [_platformId] adds the
  /// `_ball` suffix on iOS.
  static const List<CoinPack> coinPacks = [
    CoinPack('coins_500', 500, 0),
    CoinPack('coins_1500', 1500, 200),
    CoinPack('coins_5000', 5000, 1000),
    CoinPack('coins_15000', 15000, 5000),
  ];

  static const _kNoAdsKey = 'noAds_ball';

  /// The iOS "remove ads" product is configured in App Store Connect as
  /// `ballsort_remove_ads` (coin packs keep the `_ball` suffix). Android keeps
  /// the bare logical id.
  static const String _iosNoAdsId = 'ballsort_remove_ads';

  static String _platformId(String logicalId) {
    if (!Platform.isIOS) return logicalId;
    if (logicalId == noAdsId) return _iosNoAdsId;
    return '${logicalId}_ball';
  }

  static String _logicalId(String platformId) {
    if (platformId == _iosNoAdsId) return noAdsId;
    return platformId.endsWith('_ball')
        ? platformId.substring(0, platformId.length - 5)
        : platformId;
  }

  static bool _isCoinPack(String logicalId) =>
      coinPacks.any((p) => p.id == logicalId);

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _sub;
  final Map<String, ProductDetails> _products = {}; // keyed by logical ID
  bool _available = false;
  bool _noAds = false;
  final ValueNotifier<bool> noAdsNotifier = ValueNotifier(false);

  bool get available => _available;
  bool get noAds => _noAds;
  ProductDetails? productFor(String logicalId) => _products[logicalId];

  /// Coin pack products in [coinPacks] order, skipping any the store didn't
  /// return.
  List<ProductDetails> get coinProducts => coinPacks
      .map((p) => _products[p.id])
      .whereType<ProductDetails>()
      .toList();

  Future<void> initialize() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    final prefs = await SharedPreferences.getInstance();
    _noAds = prefs.getBool(_kNoAdsKey) ?? false;
    noAdsNotifier.value = _noAds;
    _available = await _iap.isAvailable();
    if (!_available) return;
    final ids = <String>{
      _platformId(noAdsId),
      ...coinPacks.map((p) => _platformId(p.id)),
    };
    final response = await _iap.queryProductDetails(ids);
    for (final p in response.productDetails) {
      _products[_logicalId(p.id)] = p;
    }
    _sub = _iap.purchaseStream
        .listen(_onPurchaseUpdated, onDone: () => _sub?.cancel());
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        await _grant(p);
      }
      if (p.pendingCompletePurchase) {
        await _iap.completePurchase(p);
      }
    }
  }

  Future<void> _grant(PurchaseDetails p) async {
    final logicalId = _logicalId(p.productID);
    if (logicalId == noAdsId) {
      final prefs = await SharedPreferences.getInstance();
      _noAds = true;
      noAdsNotifier.value = true;
      await prefs.setBool(_kNoAdsKey, true);
      return;
    }
    final pack = coinPacks.where((cp) => cp.id == logicalId).firstOrNull;
    if (pack != null) {
      await MetaService.instance.addCoins(pack.total);
    }
  }

  Future<bool> buy(String logicalId) async {
    final product = _products[logicalId];
    if (product == null || !_available) return false;
    final param = PurchaseParam(productDetails: product);
    if (_isCoinPack(logicalId)) {
      // Consumable: autoConsume so Android lets the player buy it again.
      return _iap.buyConsumable(purchaseParam: param, autoConsume: true);
    }
    return _iap.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restore() async {
    if (!_available) return;
    await _iap.restorePurchases();
  }

  void dispose() {
    _sub?.cancel();
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

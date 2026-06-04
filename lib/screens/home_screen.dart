import 'package:flutter/material.dart';
import 'package:ball_sort/l10n/app_localizations.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/game_juice.dart';
import '../services/meta_service.dart';
import '../services/audio_service.dart';
import '../services/purchase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_screen.dart';
import 'shop_screen.dart';

const _bgCenter = Color(0xFF3A2A52);
const _bgMid = Color(0xFF241A38);
const _bgEdge = Color(0xFF140E22);
const _bokeh = Color(0xFFFF8A3D);
const _accent = Color(0xFFFF6F00);

const _decoBalls = [
  Color(0xFFFF5252),
  Color(0xFF2196F3),
  Color(0xFF4CAF50),
  Color(0xFFFFEB3B),
  Color(0xFF9C27B0),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _maxLevel = 1;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _maxLevel = p.getInt('ballMax') ?? 1);
    // Auto-offer the daily bonus once when entering the home screen.
    if (MetaService.instance.canClaimDaily) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showDaily());
    }
  }

  Future<void> _play(int lvl) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GameScreen(level: lvl)));
    _load();
  }

  Future<void> _openShop() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ShopScreen()));
    if (mounted) setState(() {}); // palette may have changed
  }

  Future<void> _showRemoveAds() async {
    AudioService.instance.tap();
    final l10n = AppLocalizations.of(context)!;
    final ps = PurchaseService.instance;
    final price = ps.productFor(PurchaseService.noAdsId)?.price ?? '15 lei';
    await showDialog<void>(
      context: context,
      builder: (c) => Dialog(
        backgroundColor: const Color(0xFF2A1E40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF8F2D), _accent]),
                ),
                child: const Icon(Icons.block, color: Colors.white, size: 34),
              ),
              const SizedBox(height: 16),
              Text(l10n.removeAdsTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(
                l10n.removeAdsBody,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 14, height: 1.3),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.of(c).pop();
                    ps.buy(PurchaseService.noAdsId);
                  },
                  child: Text(l10n.buyForPrice(price),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  Navigator.of(c).pop();
                  ps.restore();
                },
                child: Text(l10n.restore,
                    style: const TextStyle(color: Color(0xFFFFD740))),
              ),
              TextButton(
                onPressed: () => Navigator.of(c).pop(),
                child: Text(l10n.later,
                    style: const TextStyle(color: Colors.white54)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDaily() async {
    final l10n = AppLocalizations.of(context)!;
    final meta = MetaService.instance;
    if (!meta.canClaimDaily) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.dailyAlreadyClaimed(meta.streak)),
          duration: const Duration(seconds: 2)));
      return;
    }
    final reward = meta.pendingDailyReward;
    final claimed = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: const Color(0xFF2A1E40),
        title: Text(l10n.dailyBonusTitle,
            style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_fire_department_rounded,
                color: Color(0xFFFF6F00), size: 48),
            const SizedBox(height: 8),
            Text(l10n.coinsReward(reward),
                style: const TextStyle(
                    color: Color(0xFFFFD740),
                    fontSize: 26,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(l10n.streakDay(meta.streak + 1),
                style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(l10n.claimReward,
                  style: const TextStyle(
                      color: Color(0xFFFFD740),
                      fontWeight: FontWeight.w800))),
        ],
      ),
    );
    if (claimed == true) {
      await meta.claimDaily();
      AudioService.instance.coin();
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: _bgMid,
      bottomNavigationBar: const BannerAdWidget(),
      body: PremiumBackground(
        colors: const [_bgCenter, _bgMid, _bgEdge],
        bokeh: _bokeh,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // top bar: coins + daily + shop
                Row(
                  children: [
                    ListenableBuilder(
                      listenable: MetaService.instance,
                      builder: (context, _) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.monetization_on_rounded,
                                color: Color(0xFFFFD740), size: 20),
                            const SizedBox(width: 6),
                            Text('${MetaService.instance.coins}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    _TopIconButton(
                      icon: Icons.card_giftcard_rounded,
                      badge: MetaService.instance.canClaimDaily,
                      onTap: _showDaily,
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<bool>(
                      valueListenable:
                          PurchaseService.instance.noAdsNotifier,
                      builder: (context, noAds, _) {
                        if (noAds) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _TopIconButton(
                            icon: Icons.block_rounded,
                            onTap: _showRemoveAds,
                          ),
                        );
                      },
                    ),
                    _TopIconButton(
                      icon: Icons.storefront_rounded,
                      onTap: _openShop,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // decorative row of glossy balls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final c in _decoBalls)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _MiniBall(color: c, size: 26),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [Color(0xFFFFB74D), _accent, Color(0xFFE91E63)],
                  ).createShader(r),
                  child: const Text(
                    'BALL SORT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.0,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    l10n.homeTagline,
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 22),
                // primary play button
                _PlayButton(
                  label: _maxLevel > 1
                      ? l10n.continueLevel(_maxLevel)
                      : l10n.playButton,
                  onTap: () => _play(_maxLevel),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Text(l10n.chooseLevel,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(l10n.record(_maxLevel),
                          style: const TextStyle(
                              color: _accent, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 40,
                    itemBuilder: (ctx, i) {
                      final lvl = i + 1;
                      final unlocked = lvl <= _maxLevel;
                      final isCurrent = lvl == _maxLevel;
                      return _LevelTile(
                        level: lvl,
                        unlocked: unlocked,
                        current: isCurrent,
                        onTap: unlocked ? () => _play(lvl) : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PlayButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8F2D), _accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _accent.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }
}

class _LevelTile extends StatelessWidget {
  final int level;
  final bool unlocked;
  final bool current;
  final VoidCallback? onTap;
  const _LevelTile({
    required this.level,
    required this.unlocked,
    required this.current,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: unlocked
                ? const LinearGradient(
                    colors: [Color(0xFFFF8F2D), _accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: unlocked ? null : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: current
                ? Border.all(color: Colors.white, width: 2.5)
                : null,
            boxShadow: unlocked
                ? [
                    BoxShadow(
                      color: _accent.withValues(alpha: 0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: unlocked
                ? Text('$level',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900))
                : const Icon(Icons.lock_rounded,
                    color: Colors.white24, size: 20),
          ),
        ),
      ),
    );
  }
}

/// Round translucent app-bar style button with an optional notification dot.
class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final VoidCallback onTap;
  const _TopIconButton(
      {required this.icon, this.badge = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          if (badge)
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF1744),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Small glossy decorative ball for the header.
class _MiniBall extends StatelessWidget {
  final Color color;
  final double size;
  const _MiniBall({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.4),
          colors: [
            Color.lerp(color, Colors.white, 0.6)!,
            color,
            Color.lerp(color, Colors.black, 0.3)!,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ball_sort/l10n/app_localizations.dart';
import '../services/meta_service.dart';
import '../services/audio_service.dart';
import '../game/skins.dart';

const _accent = Color(0xFFFF6F00);

/// Localized display name for a skin (the model stores only a stable id).
String _skinName(AppLocalizations l10n, BallSkin skin) {
  switch (skin.id) {
    case 'neon':
      return l10n.skinNeon;
    case 'candy':
      return l10n.skinCandy;
    case 'ocean':
      return l10n.skinOcean;
    case 'sunset':
      return l10n.skinSunset;
    case 'default':
    default:
      return l10n.skinDefault;
  }
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  Future<void> _onTapSkin(BallSkin skin) async {
    final l10n = AppLocalizations.of(context)!;
    final meta = MetaService.instance;
    if (meta.isUnlocked(skin.id)) {
      await meta.equip(skin.id);
      AudioService.instance.tap();
      setState(() {});
      return;
    }
    // buy
    if (meta.coins < skin.cost) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.needMoreCoins(skin.cost - meta.coins)),
          duration: const Duration(seconds: 2)));
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l10n.buySkinTitle(_skinName(l10n, skin))),
        content: Text(l10n.skinCost(skin.cost)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l10n.no)),
          TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(l10n.buy)),
        ],
      ),
    );
    if (ok != true) return;
    if (await meta.spend(skin.cost)) {
      await meta.unlock(skin.id);
      await meta.equip(skin.id);
      AudioService.instance.coin();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta = MetaService.instance;
    return Scaffold(
      backgroundColor: const Color(0xFF241A38),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.shopTitle,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          Center(
            child: ListenableBuilder(
              listenable: meta,
              builder: (context, _) => Container(
                margin: const EdgeInsets.only(right: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    Text('${meta.coins}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: meta,
        builder: (context, _) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.82,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemCount: ballSkins.length,
          itemBuilder: (ctx, i) {
            final skin = ballSkins[i];
            final unlocked = meta.isUnlocked(skin.id);
            final equipped = meta.equipped == skin.id;
            return _SkinCard(
              skin: skin,
              name: _skinName(AppLocalizations.of(context)!, skin),
              unlocked: unlocked,
              equipped: equipped,
              onTap: () => _onTapSkin(skin),
            );
          },
        ),
      ),
    );
  }
}

class _SkinCard extends StatelessWidget {
  final BallSkin skin;
  final String name;
  final bool unlocked;
  final bool equipped;
  final VoidCallback onTap;
  const _SkinCard({
    required this.skin,
    required this.name,
    required this.unlocked,
    required this.equipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.2,
            colors: skin.bg,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: equipped ? _accent : Colors.white.withValues(alpha: 0.12),
            width: equipped ? 3 : 1.5,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16)),
            const SizedBox(height: 12),
            // preview balls
            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final c in skin.balls.take(6)) _previewBall(c),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _actionChip(l10n),
          ],
        ),
      ),
    );
  }

  Widget _previewBall(Color color) {
    return Container(
      width: 26,
      height: 26,
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
      ),
    );
  }

  Widget _actionChip(AppLocalizations l10n) {
    if (equipped) {
      return _chip(l10n.equipped, _accent, Colors.white);
    }
    if (unlocked) {
      return _chip(l10n.equip, Colors.white.withValues(alpha: 0.15),
          Colors.white);
    }
    return _chip(l10n.skinPrice(skin.cost), const Color(0xFFFFD740), Colors.black);
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(color: fg, fontWeight: FontWeight.w800)),
    );
  }
}

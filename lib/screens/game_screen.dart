import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ball_sort/l10n/app_localizations.dart';
import '../widgets/banner_ad_widget.dart';
import '../services/ads_service.dart';
import '../services/audio_service.dart';
import '../services/meta_service.dart';
import '../widgets/game_juice.dart';
import '../game/level_data.dart';
import '../game/skins.dart';

const _bgMid = Color(0xFF241A38);
const _hintCost = 30;
const _coinsPerTube = 5;
const _coinsPerLevel = 30;

/// Describes where every tube and ball slot sits on the board, so taps and
/// move animations can be computed in board-local coordinates.
class _Layout {
  final double tubeW, tubeH, ballD, slot, bottomPad, topLift, boardW, boardH;
  final List<Offset> tops; // top-left of each tube
  _Layout(this.tubeW, this.tubeH, this.ballD, this.slot, this.bottomPad,
      this.topLift, this.boardW, this.boardH, this.tops);

  Offset ballCenter(int tube, int j) => tops[tube] +
      Offset(tubeW / 2, tubeH - bottomPad - (j + 0.5) * slot);

  /// Hover position of a lifted/selected ball, above the tube mouth.
  Offset floatCenter(int tube) =>
      tops[tube] + Offset(tubeW / 2, -ballD * 0.55);
}

class _Flying {
  final Color color;
  final int to;
  final Offset start, end, ctrl;
  _Flying(this.color, this.to, this.start, this.end, this.ctrl);
}

class GameScreen extends StatefulWidget {
  final int level;
  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  late BallLevel _level;
  int? _selected;
  final List<BallLevel> _undoStack = [];
  bool _won = false;
  late BallLevel _checkpoint;

  _Layout? _layout;
  _Flying? _flying;
  late final AnimationController _moveCtrl;
  late final AnimationController _bobCtrl;
  bool _muted = AudioService.instance.muted;

  @override
  void initState() {
    super.initState();
    _level = BallLevel.generate(widget.level);
    _checkpoint = _level.clone();
    _moveCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && _flying != null) _finishMove();
      });
    _bobCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _moveCtrl.dispose();
    _bobCtrl.dispose();
    super.dispose();
  }

  // ---- moves ----------------------------------------------------------------

  void _onTap(int i) {
    if (_won || _flying != null) return;
    final L = _layout;
    if (L == null) return;
    HapticFeedback.lightImpact();
    if (_selected == null) {
      if (_level.tubes[i].isEmpty) return;
      AudioService.instance.tap();
      setState(() => _selected = i);
      return;
    }
    if (_selected == i) {
      setState(() => _selected = null);
      return;
    }
    final from = _selected!;
    if (!_level.canMove(from, i)) {
      AudioService.instance.error();
      // reselect tapped tube if it has balls, else just clear
      setState(() => _selected = _level.tubes[i].isEmpty ? null : i);
      return;
    }
    _startMove(from, i, L);
  }

  void _startMove(int from, int to, _Layout L) {
    final color = _level.tubes[from].top!;
    final destSlot = _level.tubes[to].balls.length;

    _undoStack.add(_level.clone());
    if (_undoStack.length > 30) _undoStack.removeAt(0);

    final start = L.floatCenter(from);
    final end = L.ballCenter(to, destSlot);
    // arc control point: above the higher of the two endpoints
    final ctrl = Offset(
      (start.dx + end.dx) / 2,
      math.min(start.dy, end.dy) - L.tubeH * 0.35 - 20,
    );

    _level.tubes[from].balls.removeLast();
    AudioService.instance.pop();
    setState(() {
      _selected = null;
      _flying = _Flying(color, to, start, end, ctrl);
    });
    _moveCtrl.forward(from: 0);
  }

  void _finishMove() {
    final f = _flying;
    if (f == null) return;
    _level.tubes[f.to].balls.add(f.color);
    AudioService.instance.place();
    HapticFeedback.selectionClick();
    final justCompleted = _level.tubes[f.to].sorted;
    setState(() => _flying = null);

    if (justCompleted) {
      AudioService.instance.match();
      AudioService.instance.coin();
      HapticFeedback.mediumImpact();
      MetaService.instance.addCoins(_coinsPerTube);
      final L = _layout;
      final boardPos = _boardOrigin;
      if (L != null && boardPos != null) {
        // burst at the mouth of the completed tube, in global coords
        final local = L.tops[f.to] + Offset(L.tubeW / 2, 0);
        BurstOverlay.show(context, boardPos + local, f.color);
      }
    }

    if (_level.isSolved && !_won) {
      _won = true;
      MetaService.instance.addCoins(_coinsPerLevel);
      _save();
      Future.delayed(const Duration(milliseconds: 350), _celebrate);
    }
  }

  Offset? _boardOrigin;

  void _celebrate() {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    AdsService.instance.maybeShowInterstitial();
    Celebrate.show(context);
    AudioService.instance.win();
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l10n.wonTitle),
        content: Text(l10n.levelComplete(widget.level)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(c);
                Navigator.pop(context);
              },
              child: Text(l10n.back)),
          TextButton.icon(
              icon: const Icon(Icons.play_circle, color: Color(0xFFFFD740)),
              label: Text(l10n.bonusLevels,
                  style: const TextStyle(color: Color(0xFFFFD740))),
              onPressed: () async {
                Navigator.pop(c);
                await _watchAdForBonusLevels();
              }),
          TextButton(
              onPressed: () {
                Navigator.pop(c);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => GameScreen(level: widget.level + 1)));
              },
              child: Text(l10n.next)),
        ],
      ),
    );
  }

  // ---- rewarded / persistence ----------------------------------------------

  Future<void> _watchAdForUndos() async {
    final got = await AdsService.instance.showBonusAd();
    if (!mounted || !got) return;
    setState(() {
      _level = _checkpoint.clone();
      _selected = null;
      _flying = null;
      _undoStack.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(AppLocalizations.of(context)!.checkpointReset),
          duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _watchAdToSkip() async {
    final got = await AdsService.instance.showBonusAd();
    if (!mounted || !got) return;
    _won = true;
    await _save();
    if (!mounted) return;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => GameScreen(level: widget.level + 1)));
  }

  Future<void> _watchAdForBonusLevels() async {
    final got = await AdsService.instance.showBonusAd();
    if (!mounted || !got) return;
    final p = await SharedPreferences.getInstance();
    final cur = p.getInt('ballMax') ?? 1;
    final newMax = (widget.level + 3).clamp(cur, 1 << 30);
    await p.setInt('ballMax', newMax);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(AppLocalizations.of(context)!.bonusLevelsUnlocked(newMax)),
          duration: const Duration(seconds: 3)),
    );
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    final cur = p.getInt('ballMax') ?? 1;
    if (widget.level + 1 > cur) await p.setInt('ballMax', widget.level + 1);
  }

  /// Finds a helpful move: prefer consolidating onto a matching tube, then a
  /// productive move into an empty tube. Returns null if nothing useful exists.
  List<int>? _findHint() {
    final t = _level.tubes;
    // 1. move onto a non-empty matching tube
    for (var from = 0; from < t.length; from++) {
      if (t[from].isEmpty || t[from].sorted) continue;
      for (var to = 0; to < t.length; to++) {
        if (to == from || t[to].isEmpty) continue;
        if (_level.canMove(from, to)) return [from, to];
      }
    }
    // 2. move into an empty tube (only if it actually unblocks something)
    for (var from = 0; from < t.length; from++) {
      if (t[from].isEmpty) continue;
      // pointless to move from a tube that's already uniform
      final uniform = t[from].balls.every((c) => c == t[from].balls.first);
      if (uniform) continue;
      for (var to = 0; to < t.length; to++) {
        if (to == from) continue;
        if (t[to].isEmpty && _level.canMove(from, to)) return [from, to];
      }
    }
    return null;
  }

  Future<void> _useHint() async {
    if (_won || _flying != null) return;
    final l10n = AppLocalizations.of(context)!;
    final hint = _findHint();
    if (hint == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.noUsefulMove),
          duration: const Duration(seconds: 2)));
      return;
    }
    if (MetaService.instance.coins >= _hintCost) {
      await MetaService.instance.spend(_hintCost);
      _playHint(hint);
      return;
    }
    // not enough coins → offer a rewarded ad for a free hint
    if (!mounted) return;
    final watch = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l10n.hintTitle),
        content: Text(l10n.hintNotEnoughCoins),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l10n.decline)),
          TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(l10n.watchAd)),
        ],
      ),
    );
    if (watch != true) return;
    final got = await AdsService.instance.showBonusAd();
    if (!mounted || !got) return;
    final fresh = _findHint();
    if (fresh != null) _playHint(fresh);
  }

  void _playHint(List<int> hint) {
    final L = _layout;
    if (L == null) return;
    HapticFeedback.lightImpact();
    setState(() => _selected = hint[0]);
    Future.delayed(const Duration(milliseconds: 280), () {
      if (!mounted || _flying != null || _won) return;
      if (_level.canMove(hint[0], hint[1])) _startMove(hint[0], hint[1], L);
    });
  }

  void _undo() {
    if (_undoStack.isEmpty || _flying != null) return;
    HapticFeedback.lightImpact();
    AudioService.instance.swap();
    setState(() {
      _level = _undoStack.removeLast();
      _selected = null;
    });
  }

  void _restart() {
    setState(() {
      _level = BallLevel.generate(widget.level);
      _selected = null;
      _flying = null;
      _undoStack.clear();
      _won = false;
    });
  }

  // ---- layout ---------------------------------------------------------------

  _Layout _computeLayout(double maxW, double maxH) {
    final n = _level.tubes.length;
    final rows = n <= 5 ? 1 : 2;
    final perRow = (n / rows).ceil();
    const gapX = 16.0;
    const gapY = 34.0;

    double tubeW = ((maxW - (perRow + 1) * gapX) / perRow).clamp(40.0, 66.0);
    final ballD = tubeW * 0.74;
    final slot = ballD + 5;
    const bottomPad = 10.0;
    final tubeH = kTubeCapacity * slot + bottomPad + 10;
    final topLift = ballD * 0.9;
    final rowBlock = topLift + tubeH + gapY;

    final boardW = maxW;
    final boardH = rows * rowBlock - gapY;

    final tops = <Offset>[];
    for (var i = 0; i < n; i++) {
      final r = i ~/ perRow;
      final c = i % perRow;
      final countInRow = (r == rows - 1) ? (n - perRow * (rows - 1)) : perRow;
      final rowWidth = countInRow * tubeW + (countInRow - 1) * gapX;
      final startX = (boardW - rowWidth) / 2;
      final x = startX + c * (tubeW + gapX);
      final y = r * rowBlock + topLift;
      tops.add(Offset(x, y));
    }
    return _Layout(
        tubeW, tubeH, ballD, slot, bottomPad, topLift, boardW, boardH, tops);
  }

  // ---- build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: _bgMid,
      bottomNavigationBar: const BannerAdWidget(),
      appBar: AppBar(
        title: Text(l10n.levelTitle(widget.level),
            style: const TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          const _CoinChip(),
          IconButton(
            tooltip: l10n.hintTooltip(_hintCost),
            icon: const Icon(Icons.lightbulb_rounded, color: Color(0xFFFFD740)),
            onPressed: _useHint,
          ),
          IconButton(icon: const Icon(Icons.undo_rounded), onPressed: _undo),
          IconButton(icon: const Icon(Icons.refresh_rounded), onPressed: _restart),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'mute') {
                AudioService.instance.toggleMuted();
                setState(() => _muted = AudioService.instance.muted);
              } else if (v == 'skip') {
                _watchAdToSkip();
              } else if (v == 'reset') {
                _watchAdForUndos();
              }
            },
            itemBuilder: (c) => [
              PopupMenuItem(
                  value: 'mute',
                  child: Row(children: [
                    Icon(_muted
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded),
                    const SizedBox(width: 10),
                    Text(_muted ? l10n.soundOn : l10n.soundOff),
                  ])),
              PopupMenuItem(
                  value: 'skip',
                  child: Row(children: [
                    const Icon(Icons.skip_next_rounded,
                        color: Color(0xFF69F0AE)),
                    const SizedBox(width: 10),
                    Text(l10n.skipLevel),
                  ])),
              PopupMenuItem(
                  value: 'reset',
                  child: Row(children: [
                    const Icon(Icons.restore, color: Color(0xFFFFD740)),
                    const SizedBox(width: 10),
                    Text(l10n.resetCheckpoint),
                  ])),
            ],
          ),
        ],
      ),
      body: PremiumBackground(
        colors: activeSkin().bg,
        bokeh: activeSkin().bokeh,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: LayoutBuilder(builder: (ctx, c) {
                final L = _computeLayout(c.maxWidth, c.maxHeight);
                _layout = L;
                return SizedBox(
                  width: L.boardW,
                  height: L.boardH,
                  child: _buildBoard(L),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBoard(_Layout L) {
    return AnimatedBuilder(
      animation: Listenable.merge([_moveCtrl, _bobCtrl]),
      builder: (context, _) {
        // capture board origin in global coords for burst placement
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final rb = context.findRenderObject() as RenderBox?;
          if (rb != null && rb.hasSize) {
            _boardOrigin = rb.localToGlobal(Offset.zero);
          }
        });

        final children = <Widget>[];

        // 1. tube back fills
        for (var i = 0; i < _level.tubes.length; i++) {
          children.add(Positioned(
            left: L.tops[i].dx,
            top: L.tops[i].dy,
            child: CustomPaint(
              size: Size(L.tubeW, L.tubeH),
              painter: _TubeBackPainter(),
            ),
          ));
        }

        // 2. resting balls (skip the selected tube's top ball — it floats)
        for (var i = 0; i < _level.tubes.length; i++) {
          final balls = _level.tubes[i].balls;
          final topIsFloating = _selected == i && balls.isNotEmpty;
          for (var j = 0; j < balls.length; j++) {
            if (topIsFloating && j == balls.length - 1) continue;
            final cpos = L.ballCenter(i, j);
            children.add(_positionedBall(cpos, balls[j], L.ballD));
          }
        }

        // 3. tube front glass (outline + shine + glow if completed)
        for (var i = 0; i < _level.tubes.length; i++) {
          children.add(Positioned(
            left: L.tops[i].dx,
            top: L.tops[i].dy,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _onTap(i),
              child: CustomPaint(
                size: Size(L.tubeW, L.tubeH),
                painter: _TubeFrontPainter(
                  selected: _selected == i,
                  completed: _level.tubes[i].sorted,
                  glow: _level.tubes[i].sorted
                      ? _level.tubes[i].balls.first
                      : null,
                ),
              ),
            ),
          ));
        }

        // 4. floating selected top ball (above the glass) with a gentle bob
        if (_selected != null && _level.tubes[_selected!].balls.isNotEmpty) {
          final bob = math.sin(_bobCtrl.value * math.pi) * 5;
          final pos = L.floatCenter(_selected!) + Offset(0, -bob);
          children.add(_positionedBall(
              pos, _level.tubes[_selected!].balls.last, L.ballD));
        }

        // 5. flying ball on a bezier arc with a small landing squash
        final f = _flying;
        if (f != null) {
          final t = Curves.easeInOut.transform(_moveCtrl.value);
          final pos = _bezier(f.start, f.ctrl, f.end, t);
          // squash near the end of travel
          final landing = ((t - 0.82) / 0.18).clamp(0.0, 1.0);
          final sx = 1 + 0.18 * landing;
          final sy = 1 - 0.18 * landing;
          children.add(Positioned(
            left: pos.dx - L.ballD / 2,
            top: pos.dy - L.ballD / 2,
            child: Transform.scale(
              scaleX: sx,
              scaleY: sy,
              child: _BallView(color: f.color, size: L.ballD),
            ),
          ));
        }

        return Stack(clipBehavior: Clip.none, children: children);
      },
    );
  }

  Widget _positionedBall(Offset center, Color color, double d) => Positioned(
        left: center.dx - d / 2,
        top: center.dy - d / 2,
        child: _BallView(color: color, size: d),
      );

  Offset _bezier(Offset p0, Offset p1, Offset p2, double t) {
    final u = 1 - t;
    return p0 * (u * u) + p1 * (2 * u * t) + p2 * (t * t);
  }
}

// ---- visual building blocks -------------------------------------------------

/// Live coin counter for the app bar.
class _CoinChip extends StatelessWidget {
  const _CoinChip();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListenableBuilder(
        listenable: MetaService.instance,
        builder: (context, _) => Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.monetization_on_rounded,
                  color: Color(0xFFFFD740), size: 18),
              const SizedBox(width: 5),
              Text('${MetaService.instance.coins}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Glossy 3D ball: radial body gradient, soft drop shadow and a specular spot.
class _BallView extends StatelessWidget {
  final Color color;
  final double size;
  const _BallView({required this.color, required this.size});

  Color _lighten(Color c, double a) => Color.lerp(c, Colors.white, a)!;
  Color _darken(Color c, double a) => Color.lerp(c, Colors.black, a)!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.42),
                radius: 0.95,
                colors: [
                  _lighten(color, 0.65),
                  color,
                  _darken(color, 0.34),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.38),
                  blurRadius: size * 0.16,
                  offset: Offset(0, size * 0.09),
                ),
              ],
            ),
          ),
          // specular glossy highlight
          Positioned(
            left: size * 0.20,
            top: size * 0.14,
            child: Container(
              width: size * 0.34,
              height: size * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.85),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Behind the balls: faint glass interior fill so empty tubes read as glass.
class _TubeBackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final body = _tubeBody(size);
    canvas.drawRRect(body, Paint()..color = Colors.white.withValues(alpha: 0.06));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Above the balls: glass outline, vertical shine strip, mouth ellipse, and a
/// soft colored glow ring when the tube is fully sorted.
class _TubeFrontPainter extends CustomPainter {
  final bool selected;
  final bool completed;
  final Color? glow;
  _TubeFrontPainter({required this.selected, required this.completed, this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final body = _tubeBody(size);

    // completed glow
    if (completed && glow != null) {
      canvas.drawRRect(
        body,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = glow!.withValues(alpha: 0.9)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      );
    }

    // vertical glass shine
    canvas.save();
    canvas.clipRRect(body);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, 8, w * 0.13, size.height - 24),
        Radius.circular(w * 0.07),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.14),
    );
    canvas.restore();

    // glass outline
    final glass = selected
        ? const Color(0xFFFFD54F)
        : Colors.white.withValues(alpha: 0.5);
    canvas.drawRRect(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 3.2 : 2.2
        ..color = glass,
    );

    // mouth ellipse (3D rim)
    canvas.drawOval(
      Rect.fromLTWH(1.5, 0, w - 3, w * 0.22),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 3.0 : 2.0
        ..color = glass,
    );
  }

  @override
  bool shouldRepaint(covariant _TubeFrontPainter old) =>
      old.selected != selected || old.completed != completed || old.glow != glow;
}

/// Shared U-shaped glass body: small top corners, deeply rounded bottom.
RRect _tubeBody(Size size) {
  final w = size.width;
  return RRect.fromRectAndCorners(
    Rect.fromLTWH(0, w * 0.11, w, size.height - w * 0.11),
    topLeft: Radius.circular(w * 0.10),
    topRight: Radius.circular(w * 0.10),
    bottomLeft: Radius.circular(w * 0.46),
    bottomRight: Radius.circular(w * 0.46),
  );
}

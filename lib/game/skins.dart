import 'package:flutter/material.dart';
import '../services/meta_service.dart';

/// A cosmetic skin: the ball palette + the background it pairs with.
/// Unlockable with coins — the core long-term retention lever.
class BallSkin {
  final String id;
  final String name;
  final int cost; // 0 = free/default
  final List<Color> balls; // 10 distinct colors
  final List<Color> bg; // 3 colors: center → mid → edge
  final Color bokeh;
  const BallSkin({
    required this.id,
    required this.name,
    required this.cost,
    required this.balls,
    required this.bg,
    required this.bokeh,
  });
}

const ballSkins = <BallSkin>[
  BallSkin(
    id: 'default',
    name: 'Clasic',
    cost: 0,
    balls: [
      Color(0xFFFF5252), Color(0xFF2196F3), Color(0xFFFF9800),
      Color(0xFF4CAF50), Color(0xFF9C27B0), Color(0xFFFFEB3B),
      Color(0xFF00BCD4), Color(0xFFE91E63), Color(0xFF795548),
      Color(0xFF8BC34A),
    ],
    bg: [Color(0xFF3A2A52), Color(0xFF241A38), Color(0xFF140E22)],
    bokeh: Color(0xFFFF8A3D),
  ),
  BallSkin(
    id: 'neon',
    name: 'Neon',
    cost: 300,
    balls: [
      Color(0xFFFF1744), Color(0xFF00E5FF), Color(0xFFFFEA00),
      Color(0xFF00E676), Color(0xFFD500F9), Color(0xFFFF9100),
      Color(0xFF2979FF), Color(0xFFF50057), Color(0xFF76FF03),
      Color(0xFF1DE9B6),
    ],
    bg: [Color(0xFF1A0B2E), Color(0xFF0F0820), Color(0xFF050210)],
    bokeh: Color(0xFF00E5FF),
  ),
  BallSkin(
    id: 'candy',
    name: 'Bomboane',
    cost: 400,
    balls: [
      Color(0xFFFF8A80), Color(0xFF82B1FF), Color(0xFFFFD180),
      Color(0xFFB9F6CA), Color(0xFFEA80FC), Color(0xFFFFFF8D),
      Color(0xFF84FFFF), Color(0xFFFF80AB), Color(0xFFFFAB91),
      Color(0xFFCCFF90),
    ],
    bg: [Color(0xFF4A2C5A), Color(0xFF33203F), Color(0xFF1E1228)],
    bokeh: Color(0xFFFF80AB),
  ),
  BallSkin(
    id: 'ocean',
    name: 'Ocean',
    cost: 500,
    balls: [
      Color(0xFF00B0FF), Color(0xFF1DE9B6), Color(0xFF18FFFF),
      Color(0xFF536DFE), Color(0xFF64FFDA), Color(0xFF40C4FF),
      Color(0xFF0091EA), Color(0xFF00BFA5), Color(0xFF2962FF),
      Color(0xFF80D8FF),
    ],
    bg: [Color(0xFF0A3D5C), Color(0xFF062A40), Color(0xFF031824)],
    bokeh: Color(0xFF18FFFF),
  ),
  BallSkin(
    id: 'sunset',
    name: 'Apus',
    cost: 700,
    balls: [
      Color(0xFFFF6F00), Color(0xFFFF3D00), Color(0xFFFFC400),
      Color(0xFFD500F9), Color(0xFFFF1744), Color(0xFFFFAB00),
      Color(0xFFF50057), Color(0xFFFF6E40), Color(0xFFFFD740),
      Color(0xFFE040FB),
    ],
    bg: [Color(0xFF5A2A3E), Color(0xFF3D1E2E), Color(0xFF24121C)],
    bokeh: Color(0xFFFF6E40),
  ),
];

BallSkin skinById(String id) =>
    ballSkins.firstWhere((s) => s.id == id, orElse: () => ballSkins.first);

/// The currently equipped skin (falls back to default).
BallSkin activeSkin() => skinById(MetaService.instance.equipped);

/// Number of distinct ball colors available — used by level generation.
int get kPaletteSize => ballSkins.first.balls.length;

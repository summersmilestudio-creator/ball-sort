import 'dart:math';
import 'package:flutter/material.dart';

const kTubeCapacity = 5;

const kBallColors = [
  Color(0xFFFF5252),
  Color(0xFF2196F3),
  Color(0xFFFF9800),
  Color(0xFF4CAF50),
  Color(0xFF9C27B0),
  Color(0xFFFFEB3B),
  Color(0xFF00BCD4),
  Color(0xFFE91E63),
  Color(0xFF795548),
  Color(0xFF8BC34A),
];

class Tube {
  final List<Color> balls;
  Tube(this.balls);
  Tube clone() => Tube(List.of(balls));
  bool get isEmpty => balls.isEmpty;
  bool get isFull => balls.length >= kTubeCapacity;
  Color? get top => balls.isEmpty ? null : balls.last;
  bool get sorted =>
      balls.length == kTubeCapacity && balls.every((c) => c == balls.first);
}

class BallLevel {
  final List<Tube> tubes;
  BallLevel(this.tubes);

  static BallLevel generate(int level) {
    final numColors = (3 + (level / 3).floor()).clamp(3, kBallColors.length);
    final emptyTubes = level >= 4 ? 2 : 1;

    final all = <Color>[];
    for (var i = 0; i < numColors; i++) {
      for (var j = 0; j < kTubeCapacity; j++) {
        all.add(kBallColors[i]);
      }
    }
    all.shuffle(Random(level * 777 + 13));

    final tubes = <Tube>[];
    for (var i = 0; i < numColors; i++) {
      tubes.add(Tube(all.sublist(i * kTubeCapacity, (i + 1) * kTubeCapacity)));
    }
    for (var i = 0; i < emptyTubes; i++) {
      tubes.add(Tube([]));
    }
    return BallLevel(tubes);
  }

  BallLevel clone() => BallLevel(tubes.map((t) => t.clone()).toList());

  bool moveBall(int from, int to) {
    if (from == to) return false;
    final src = tubes[from];
    final dst = tubes[to];
    if (src.isEmpty) return false;
    if (dst.isFull) return false;
    if (dst.isNotEmpty && dst.top != src.top) return false;
    dst.balls.add(src.balls.removeLast());
    return true;
  }

  bool get isSolved => tubes.every((t) => t.isEmpty || t.sorted);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../game/level_data.dart';

class GameScreen extends StatefulWidget {
  final int level;
  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late BallLevel _level;
  int? _selected;
  final List<BallLevel> _undoStack = [];
  bool _won = false;

  @override
  void initState() {
    super.initState();
    _level = BallLevel.generate(widget.level);
  }

  void _onTap(int i) {
    if (_won) return;
    HapticFeedback.lightImpact();
    if (_selected == null) {
      if (_level.tubes[i].isEmpty) return;
      setState(() => _selected = i);
    } else if (_selected == i) {
      setState(() => _selected = null);
    } else {
      _undoStack.add(_level.clone());
      if (_undoStack.length > 30) _undoStack.removeAt(0);
      final ok = _level.moveBall(_selected!, i);
      if (!ok) _undoStack.removeLast();
      setState(() => _selected = null);
      if (_level.isSolved && !_won) {
        _won = true;
        _save();
        Future.delayed(const Duration(milliseconds: 400), () {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text('🎉 Câștigat!'),
              content: Text('Nivel ${widget.level} complet!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(c);
                      Navigator.pop(context);
                    },
                    child: const Text('Înapoi')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(c);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => GameScreen(level: widget.level + 1)));
                    },
                    child: const Text('Următor')),
              ],
            ),
          );
        });
      }
    }
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    final cur = p.getInt('ballMax') ?? 1;
    if (widget.level + 1 > cur) {
      await p.setInt('ballMax', widget.level + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel ${widget.level}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: () {
            if (_undoStack.isEmpty) return;
            setState(() {
              _level = _undoStack.removeLast();
              _selected = null;
            });
          }),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {
            setState(() {
              _level = BallLevel.generate(widget.level);
              _selected = null;
              _undoStack.clear();
              _won = false;
            });
          }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 24,
              children: [
                for (var i = 0; i < _level.tubes.length; i++)
                  GestureDetector(
                    onTap: () => _onTap(i),
                    child: _TubeWidget(
                      tube: _level.tubes[i],
                      selected: _selected == i,
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

class _TubeWidget extends StatelessWidget {
  final Tube tube;
  final bool selected;
  const _TubeWidget({required this.tube, required this.selected});

  @override
  Widget build(BuildContext context) {
    const w = 56.0;
    const ballSize = 44.0;
    final h = kTubeCapacity * (ballSize + 4) + 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: w,
      height: h + (selected ? 12 : 0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              border: Border.all(
                  color: selected ? const Color(0xFFFFEB3B) : Colors.white60,
                  width: selected ? 3 : 2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = tube.balls.length - 1; i >= 0; i--)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            tube.balls[i].withValues(alpha: 1),
                            tube.balls[i],
                          ],
                          center: const Alignment(-0.4, -0.4),
                          radius: 0.8,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Colors.black54, blurRadius: 2, offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Basic smoke test: the app builds and renders without throwing.

import 'package:flutter_test/flutter_test.dart';

import 'package:ball_sort/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BallSortApp());
    await tester.pump();
  });
}

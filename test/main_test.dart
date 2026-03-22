// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:hello_world_android/main.dart';

void main() {
  testWidgets('Favorite icon change test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: const MyApp(),
    );

    var state = MyAppState();
    var number = 5;

    expect(state.favorites.isEmpty, true);

    state.favorites.add(number);
    await tester.pump();
    expect(state.favorites.contains(number), true);

    // await tester.tap(find.byIcon(Icons.favorite_border));
    // await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}

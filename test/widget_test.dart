import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clockdesign/main.dart';

void main() {
  testWidgets('Toggle theme test', (WidgetTester tester) async {
    
    await tester.pumpWidget(MaterialApp(home: MyApp()));

    
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsNothing);

    
    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pump();

    
    expect(find.byIcon(Icons.light_mode), findsNothing);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
}

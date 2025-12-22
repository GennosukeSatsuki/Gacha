import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idea_mixer/main.dart';
import 'package:idea_mixer/features/gacha/card_widget.dart';

void main() {
  testWidgets('Gacha spin smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrap in ProviderScope since main.dart does it but pumpWidget might need explicit scope if testing parts,
    // but here we pump IdeaMixerApp which includes ProviderScope? 
    // No, IdeaMixerApp in main.dart is wrapped by ProviderScope in main function.
    // So we need to wrap it here too.
    
    await tester.pumpWidget(const ProviderScope(child: IdeaMixerApp()));

    // Verify that we start with the prompt.
    expect(find.text('Press the button to draw inspiration!'), findsOneWidget);
    expect(find.byType(CardWidget), findsNothing);

    // Tap the 'SPIN GACHA' button.
    await tester.tap(find.text('SPIN GACHA'));
    await tester.pump(); // Start animation/state change
    // Gacha might be instant, but if there were animations we'd need to pumpFrames.

    await tester.pumpAndSettle();

    // Verify that cards are displayed.
    // Default spin gives 3 cards (2 char + 1 story).
    expect(find.byType(CardWidget), findsNWidgets(3));
  });
}

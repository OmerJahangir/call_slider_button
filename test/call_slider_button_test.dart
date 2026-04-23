import 'package:call_slider_button/call_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CallSliderButton', () {
    // Helper to pump the widget and advance past the initial frame.
    // We use pump() instead of pumpAndSettle() because the pulse animation
    // never completes (it repeats indefinitely).
    Future<void> pumpSlider(
      WidgetTester tester, {
      required CallSliderButton slider,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: slider),
        ),
      );
      // Advance one frame so the widget tree is fully built.
      await tester.pump();
    }

    testWidgets('renders with default parameters', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
        ),
      );

      expect(find.text('Accept'), findsOneWidget);
      expect(find.text('Decline'), findsOneWidget);
      expect(find.byType(CallSliderButton), findsOneWidget);
    });

    testWidgets('renders with custom text', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          acceptText: 'Answer',
          declineText: 'Reject',
        ),
      );

      expect(find.text('Answer'), findsOneWidget);
      expect(find.text('Reject'), findsOneWidget);
    });

    testWidgets('fires onAccept when dragged right past threshold',
        (tester) async {
      var accepted = false;

      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () => accepted = true,
          onDecline: () {},
          dragThreshold: 50,
        ),
      );

      // Drag the center button to the right.
      final center = find.byType(CircleAvatar);
      await tester.drag(center, const Offset(120, 0));
      await tester.pump();

      expect(accepted, isTrue);
    });

    testWidgets('fires onDecline when dragged left past threshold',
        (tester) async {
      var declined = false;

      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () => declined = true,
          dragThreshold: 50,
        ),
      );

      final center = find.byType(CircleAvatar);
      await tester.drag(center, const Offset(-120, 0));
      await tester.pump();

      expect(declined, isTrue);
    });

    testWidgets('does not fire callbacks when drag is below threshold',
        (tester) async {
      var accepted = false;
      var declined = false;

      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () => accepted = true,
          onDecline: () => declined = true,
          dragThreshold: 100,
        ),
      );

      final center = find.byType(CircleAvatar);
      await tester.drag(center, const Offset(30, 0));
      await tester.pump();

      expect(accepted, isFalse);
      expect(declined, isFalse);
    });

    testWidgets('hides labels during drag', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
        ),
      );

      // Labels visible before drag.
      expect(find.text('Accept'), findsOneWidget);
      expect(find.text('Decline'), findsOneWidget);

      // Start a drag.
      final center = find.byType(CircleAvatar);
      final gesture = await tester.startGesture(tester.getCenter(center));
      await gesture.moveBy(const Offset(20, 0));
      await tester.pump();

      // Labels should be hidden during drag.
      expect(find.text('Accept'), findsNothing);
      expect(find.text('Decline'), findsNothing);

      // Clean up — release the gesture and advance frames.
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('applies custom width', (tester) async {
      const testWidth = 300.0;

      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          width: testWidth,
        ),
      );

      // Find the specific decorated Container inside CallSliderButton
      // by looking for the one with a BoxDecoration.
      final containerFinder = find.descendant(
        of: find.byType(CallSliderButton),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              widget.constraints != null &&
              widget.constraints!.maxWidth == testWidth,
        ),
      );

      expect(containerFinder, findsOneWidget);
    });

    testWidgets('applies custom height', (tester) async {
      const testHeight = 90.0;

      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          height: testHeight,
        ),
      );

      final containerFinder = find.descendant(
        of: find.byType(CallSliderButton),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              widget.constraints != null &&
              widget.constraints!.maxHeight == testHeight,
        ),
      );

      expect(containerFinder, findsOneWidget);
    });

    testWidgets('uses custom acceptIcon widget', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          acceptIcon: const Icon(Icons.phone, key: Key('custom_accept')),
        ),
      );

      expect(find.byKey(const Key('custom_accept')), findsOneWidget);
    });

    testWidgets('resets to center after incomplete drag', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          dragThreshold: 100,
        ),
      );

      final center = find.byType(CircleAvatar);
      await tester.drag(center, const Offset(30, 0));

      // Advance past the 200ms reset animation.
      await tester.pump(const Duration(milliseconds: 250));

      // After the reset animation, labels should reappear.
      expect(find.text('Accept'), findsOneWidget);
      expect(find.text('Decline'), findsOneWidget);
    });

    testWidgets('uses custom declineIcon when dragging left', (tester) async {
      await pumpSlider(
        tester,
        slider: CallSliderButton(
          onAccept: () {},
          onDecline: () {},
          declineIcon:
              const Icon(Icons.phone_disabled, key: Key('custom_decline')),
        ),
      );

      // Start dragging left to trigger the decline icon.
      final center = find.byType(CircleAvatar);
      final gesture = await tester.startGesture(tester.getCenter(center));
      await gesture.moveBy(const Offset(-30, 0));
      await tester.pump();

      expect(find.byKey(const Key('custom_decline')), findsOneWidget);

      await gesture.up();
      await tester.pump(const Duration(milliseconds: 300));
    });
  });
}

import 'package:call_slider_button/call_slider_button.dart';
import 'package:call_slider_button_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders both demo sliders', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(CallSliderButton), findsNWidgets(2));
    expect(find.text('Answer'), findsOneWidget);
  });
}

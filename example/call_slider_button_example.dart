import 'package:call_slider_button/call_slider_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Example app showcasing [CallSliderButton] with default and custom styles.
class MyApp extends StatelessWidget {
  /// Creates the example app.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CallSliderDemo(),
    );
  }
}

/// A demo screen showing two slider variants.
class CallSliderDemo extends StatelessWidget {
  /// Creates the demo screen.
  const CallSliderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Call Slider Button Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Default style
            const Text(
              'Default',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            CallSliderButton(
              onAccept: () => debugPrint('Call accepted!'),
              onDecline: () => debugPrint('Call declined!'),
            ),
            const SizedBox(height: 40),

            // Custom style
            const Text(
              'Custom Colors & Size',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            CallSliderButton(
              onAccept: () => debugPrint('Custom call accepted!'),
              onDecline: () => debugPrint('Custom call declined!'),
              acceptText: 'Answer',
              declineText: 'Reject',
              acceptIcon: const Icon(Icons.call),
              declineIcon: const Icon(Icons.call_end),
              acceptColor: Colors.teal,
              declineColor: Colors.orange,
              backgroundColor: const Color(0xFF1E1E1E),
              iconColor: Colors.tealAccent,
              callBtnBackgroundColor: Colors.black87,
              height: 80,
              width: 320,
              borderRadius: 40,
              iconSize: 30,
              iconRadius: 28,
              dragThreshold: 100,
            ),
          ],
        ),
      ),
    );
  }
}

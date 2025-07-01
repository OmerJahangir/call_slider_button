import 'package:flutter/material.dart';
import 'package:call_slider_button/call_slider_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CallSliderButton(
            onAccept: () => debugPrint("Call accepted!"),
            onDecline: () => debugPrint("Call declined!"),
          ),
        ),
      ),
    );
  }
}

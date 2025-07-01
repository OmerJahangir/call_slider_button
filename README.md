# Call Slider Button

A Flutter widget that mimics a call slider — swipe right to accept, left to decline. Fully customizable and animated.

## Features

- Swipe to Accept or Decline
- Custom icons, text, colors, radius, etc.
- Smooth animations with haptic feedback

## Usage

```dart
import 'package:call_slider_button/call_slider_button.dart';

CallSliderButton(
  onAccept: () => print("Accepted"),
  onDecline: () => print("Declined"),
);

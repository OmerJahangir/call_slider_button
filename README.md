<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->
# Call Slider Button
A Flutter widget that mimics a call slider — swipe right to accept, left to decline. Fully customizable and animated.


## Features

- Swipe to Accept or Decline
- Custom icons, text, colors, radius, etc.
- Smooth animations with haptic feedback

## Getting started

```dart
import 'package:call_slider_button/call_slider_button.dart';

CallSliderButton(
  onAccept: () => print("Accepted"),
  onDecline: () => print("Declined"),
);

## Parameters

| Parameter             | Type           | Description                                           | Default             |
| --------------------- | -------------- | ----------------------------------------------------- | ------------------- |
| `onAccept`            | `VoidCallback` | Callback when user slides right to accept.            | **Required**        |
| `onDecline`           | `VoidCallback` | Callback when user slides left to decline.            | **Required**        |
| `acceptText`          | `String`       | Text displayed on the right side (Accept).            | `'Accept'`          |
| `declineText`         | `String`       | Text displayed on the left side (Decline).            | `'Decline'`         |
| `textStyle`           | `TextStyle?`   | Style applied to both `acceptText` and `declineText`. | `null`              |
| `acceptColor`         | `Color`        | Background glow color when dragging right.            | `Colors.green`      |
| `declineColor`        | `Color`        | Background glow color when dragging left.             | `Colors.red`        |
| `idleBackgroundColor` | `Color`        | Background color when idle (not being dragged).       | `Color(0x22FFFFFF)` |
| `iconColor`           | `Color`        | Icon color in the center when idle.                   | `Colors.green`      |
| `acceptIcon`          | `IconData`     | Icon shown when sliding right.                        | `Icons.call`        |
| `declineIcon`         | `IconData`     | Icon shown when sliding left.                         | `Icons.call_end`    |
| `height`              | `double`       | Height of the slider button container.                | `70`                |
| `borderRadius`        | `double`       | Border radius of the slider container.                | `50`                |
| `iconSize`            | `double`       | Size of the center icon inside the circular avatar.   | `35`                |
| `iconRadius`          | `double`       | Radius of the circular avatar around the icon.        | `30`                |



## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.

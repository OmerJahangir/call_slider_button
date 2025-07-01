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

| Property      | Description                    | Default   |
| ------------- | ------------------------------ | --------- |
| `onAccept`    | Callback when call is accepted | —         |
| `onDecline`   | Callback when call is declined | —         |
| `acceptText`  | Label for accept button        | "Accept"  |
| `declineText` | Label for decline button       | "Decline" |
| ...           | *(List all others)*            |           |


## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.

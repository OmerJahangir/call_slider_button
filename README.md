# 📞 Call Slider Button

[![Pub Version](https://img.shields.io/pub/v/call_slider_button.svg)](https://pub.dev/packages/call_slider_button)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.41+-02569B?logo=flutter)](https://flutter.dev)

A beautiful, fully customizable Flutter widget that mimics an incoming call slider — swipe right to accept, swipe left to decline. Ideal for call interfaces, custom UIs, or any interactive action slider.

---

## 📷 Screenshots

### Slide to Accept

![Accept Demo](https://raw.githubusercontent.com/OmerJahangir/call_slider_button/main/screenshots/demo1.gif)

### Slide to Decline

![Decline Demo](https://raw.githubusercontent.com/OmerJahangir/call_slider_button/main/screenshots/demo2.gif)

---

## ✨ Features

- Swipe to **Accept** or **Decline** interactions
- Customizable icons, text, colors, radius, and animations
- Haptic feedback on successful drag
- Smooth animations with reset pulse effect
- Configurable drag threshold and slider width
- Lightweight and easy to integrate

---

## 🚀 Getting Started

### Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  call_slider_button: ^2.0.0
```

Or install via the command line:

```bash
flutter pub add call_slider_button
```

---

## 📦 Usage

```dart
import 'package:call_slider_button/call_slider_button.dart';

CallSliderButton(
  onAccept: () => print("Call accepted"),
  onDecline: () => print("Call declined"),
);
```

### Customised Example

```dart
CallSliderButton(
  onAccept: () => print("Call accepted"),
  onDecline: () => print("Call declined"),
  acceptText: 'Answer',
  declineText: 'Reject',
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
);
```

---

## ⚙️ Parameters

| Parameter               | Type             | Description                                                    | Default             |
| ----------------------- | ---------------- | -------------------------------------------------------------- | ------------------- |
| `onAccept`              | `VoidCallback`   | Callback when the user slides right past the threshold.        | **Required**        |
| `onDecline`             | `VoidCallback`   | Callback when the user slides left past the threshold.         | **Required**        |
| `acceptText`            | `String`         | Label displayed on the right side (Accept).                    | `'Accept'`          |
| `declineText`           | `String`         | Label displayed on the left side (Decline).                    | `'Decline'`         |
| `textStyle`             | `TextStyle?`     | Style applied to both `acceptText` and `declineText`.          | `null`              |
| `acceptColor`           | `Color`          | Background glow color when dragging right.                     | `Colors.green`      |
| `declineColor`          | `Color`          | Background glow color when dragging left.                      | `Colors.red`        |
| `backgroundColor`       | `Color`          | Background color when idle (not being dragged).                | `Color(0xFFF6F6F6)` |
| `iconColor`             | `Color`          | Default accept icon color.                                     | `Colors.green`      |
| `borderColor`           | `Color`          | Border color of the slider track.                              | `Color(0xFFEBEBEB)` |
| `callBtnBackgroundColor`| `Color`          | Background color of the circular call button.                  | `Colors.white`      |
| `acceptIcon`            | `Widget?`        | Custom widget shown when sliding right.                        | `Icon(Icons.call)`  |
| `declineIcon`           | `Widget?`        | Custom widget shown when sliding left.                         | `Icon(Icons.call_end)` |
| `height`                | `double`         | Height of the slider container.                                | `70`                |
| `width`                 | `double?`        | Width of the slider container. Defaults to 80 % screen width.  | `null`              |
| `borderRadius`          | `double`         | Corner radius of the slider container.                         | `50`                |
| `iconSize`              | `double`         | Size of the center icon inside the circular avatar.            | `35`                |
| `iconRadius`            | `double`         | Radius of the circular avatar around the icon.                 | `30`                |
| `dragThreshold`         | `double`         | Minimum drag distance to trigger accept / decline.             | `80.0`              |

---

## 📂 Example

You can find a complete example in the [`/example`](example/) folder.

To run it:

```bash
cd example
flutter run
```

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 🔗 Author

Built with ❤️ by [Omer Jahangir](https://github.com/OmerJahangir)

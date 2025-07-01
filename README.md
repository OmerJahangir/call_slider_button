# 📞 Call Slider Button

A beautiful, fully customizable Flutter widget that mimics an incoming call slider — swipe right to accept, swipe left to decline. Ideal for call interfaces, custom UIs, or any interactive action slider.

---

## ✨ Features

- Swipe to **Accept** or **Decline** interactions
- Customizable icons, text, colors, radius, animations
- Haptic feedback on successful drag
- Smooth animations with reset pulse effect
- Lightweight and easy to integrate

---

## 🚀 Getting Started

To start using the Call Slider Button in your Flutter project:

### 1. Add the dependency

If you're using it locally:

```yaml
dependencies:
  call_slider_button:
    path: ../call_slider_button
```
If published on pub.dev (replace with actual version):
dependencies:
  call_slider_button: ^1.0.0
  
## 📦Usage
import 'package:call_slider_button/call_slider_button.dart';

CallSliderButton(
  onAccept: () => print("Call accepted"),
  onDecline: () => print("Call declined"),
);

## ⚙️ Parameters

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

## 📂 Example
You can find a complete example in the /example folder.

To run it:

cd example
flutter run

## 📄 License
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## 🔗 Author

Built with ❤️ by[Omer Jahangir]






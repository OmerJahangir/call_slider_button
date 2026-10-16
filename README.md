# 📞 Call Slider Button

[![pub package](https://img.shields.io/pub/v/call_slider_button.svg?logo=dart&label=pub)](https://pub.dev/packages/call_slider_button)
[![pub points](https://img.shields.io/pub/points/call_slider_button?logo=dart)](https://pub.dev/packages/call_slider_button/score)
[![likes](https://img.shields.io/pub/likes/call_slider_button?logo=dart)](https://pub.dev/packages/call_slider_button/score)
[![Flutter](https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A beautiful, fully customizable **incoming-call slider** for Flutter.
Swipe right to accept, swipe left to decline — with smooth animations, haptic
feedback and built-in screen-reader support.

<p align="center">
  <img src="https://raw.githubusercontent.com/OmerJahangir/call_slider_button/main/screenshots/demo1.gif" alt="Slide right to accept" width="280">
  &nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/OmerJahangir/call_slider_button/main/screenshots/demo2.gif" alt="Slide left to decline" width="280">
</p>

<p align="center"><em>Slide to accept&nbsp;&nbsp;·&nbsp;&nbsp;Slide to decline</em></p>

---

## ✨ Features

- 👉 **Swipe to accept / decline** with a pulsing call button
- 🎨 **Fully customizable** — text, colors, icons, size, radius and drag threshold
- 📳 **Haptic feedback** when the drag passes the threshold
- 🌀 **Smooth animations** — color glow while dragging, springs back to center on release
- ♿ **Accessible** — TalkBack and VoiceOver users get **Accept** / **Decline** actions, no dragging needed
- 🧩 **Material 3 ready** — built on Flutter's standalone [`material_ui`](https://pub.dev/packages/material_ui) package
- 📱 **Every platform** — Android, iOS, web, macOS, Windows and Linux (pure Dart, no native code)

---

## 🚀 Getting started

### Install

```bash
flutter pub add call_slider_button
```

or add it to your `pubspec.yaml` manually:

```yaml
dependencies:
  call_slider_button: ^3.0.0
```

### Requirements

| call_slider_button | Flutter            | Dart       |
| ------------------ | ------------------ | ---------- |
| **3.x**            | `>=3.47.0`         | `^3.13.0`  |
| 2.x                | `>=3.27.0 <3.47.0` | `>=3.6.0`  |

Version 3 works in apps that have migrated to `material_ui` **and** in apps
still using the SDK's built-in `package:flutter/material.dart`.

---

## 📦 Usage

```dart
import 'package:call_slider_button/call_slider_button.dart';

CallSliderButton(
  onAccept: () => debugPrint('Call accepted'),
  onDecline: () => debugPrint('Call declined'),
);
```

### Customized

```dart
CallSliderButton(
  onAccept: () => debugPrint('Call accepted'),
  onDecline: () => debugPrint('Call declined'),
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

### Callbacks

| Parameter   | Type           | Description                                     | Default      |
| ----------- | -------------- | ----------------------------------------------- | ------------ |
| `onAccept`  | `VoidCallback` | Called when the button is dragged right past `dragThreshold`. | **required** |
| `onDecline` | `VoidCallback` | Called when the button is dragged left past `dragThreshold`.  | **required** |

### Text

| Parameter     | Type         | Description                                   | Default                     |
| ------------- | ------------ | --------------------------------------------- | --------------------------- |
| `acceptText`  | `String`     | Label on the right side while idle.           | `'Accept'`                  |
| `declineText` | `String`     | Label on the left side while idle.            | `'Decline'`                 |
| `textStyle`   | `TextStyle?` | Style for both labels.                        | white, 20 px, medium weight |

### Colors

| Parameter                | Type    | Description                                   | Default                          |
| ------------------------ | ------- | --------------------------------------------- | -------------------------------- |
| `acceptColor`            | `Color` | Track glow while dragging right.              | `Colors.green`                   |
| `declineColor`           | `Color` | Track glow while dragging left.               | `Colors.red`                     |
| `backgroundColor`        | `Color` | Track color while idle.                       | `Color(0x33FFFFFF)` (translucent white) |
| `iconColor`              | `Color` | Color of the default accept icon.             | `Colors.green`                   |
| `borderColor`            | `Color` | Border color of the track.                    | `Color(0xFFEBEBEB)`              |
| `callBtnBackgroundColor` | `Color` | Background of the round call button.          | `Colors.white`                   |

### Icons

| Parameter     | Type      | Description                        | Default                |
| ------------- | --------- | ---------------------------------- | ---------------------- |
| `acceptIcon`  | `Widget?` | Shown while idle or dragging right. | `Icon(Icons.call)`     |
| `declineIcon` | `Widget?` | Shown while dragging left.          | `Icon(Icons.call_end)` |

### Size & behavior

| Parameter       | Type      | Description                                        | Default             |
| --------------- | --------- | -------------------------------------------------- | ------------------- |
| `width`         | `double?` | Track width.                                       | 80 % of screen width |
| `height`        | `double`  | Track height.                                      | `70`                |
| `borderRadius`  | `double`  | Track corner radius.                               | `50`                |
| `iconSize`      | `double`  | Size of the icon inside the call button.           | `35`                |
| `iconRadius`    | `double`  | Radius of the round call button.                   | `30`                |
| `dragThreshold` | `double`  | Distance (logical px) needed to accept or decline. | `80.0`              |

---

## ♿ Accessibility

The slider is exposed to screen readers as a single element with two custom
actions named after your `acceptText` and `declineText`:

- **VoiceOver (iOS):** select the slider, swipe up/down to pick **Accept** or
  **Decline**, then double-tap.
- **TalkBack (Android):** select the slider, open the TalkBack menu →
  **Actions**, then choose **Accept** or **Decline**.

No extra code is needed — the actions call your `onAccept` / `onDecline`.

---

## ⬆️ Upgrading from 2.x

3.0.0 moves the package to Flutter's standalone
[`material_ui`](https://pub.dev/packages/material_ui) library. The widget API
is unchanged — just make sure your project is on **Flutter 3.47 or newer**,
then bump the version:

```yaml
dependencies:
  call_slider_button: ^3.0.0
```

To migrate your own app to `material_ui` as well, run:

```bash
dart fix --apply --code=migrate_design_widgets
```

---

## 📂 Example

A complete Android & iOS demo app lives in the
[`example`](https://github.com/OmerJahangir/call_slider_button/tree/main/example)
folder:

```bash
cd example
flutter run
```

---

## 🐞 Issues & contributions

Found a bug or have an idea? Please open an issue on
[GitHub](https://github.com/OmerJahangir/call_slider_button/issues) —
pull requests are welcome.

## 📄 License

MIT — see the [LICENSE](https://github.com/OmerJahangir/call_slider_button/blob/main/LICENSE) file.

## 🔗 Author

Built with ❤️ by [Omer Jahangir](https://github.com/OmerJahangir)

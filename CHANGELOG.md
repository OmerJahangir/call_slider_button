## [3.0.0] - 2026-10-15

### Breaking
- Migrated from the SDK's `package:flutter/material.dart` to the standalone
  [`material_ui`](https://pub.dev/packages/material_ui) package (Flutter's
  decoupled Material library), using `dart fix --code=migrate_design_widgets`.
- Minimum versions raised to Flutter `>=3.47.0` / Dart `^3.13.0`, as required
  by `material_ui`.

The public API is unchanged and exposes no Material types, so the widget works
in both migrated (`material_ui`) apps and apps still on the SDK Material
library.

### Added
- Screen-reader support: the slider is exposed as a single semantics node with
  **Accept** / **Decline** custom actions, so TalkBack and VoiceOver users can
  answer or reject without dragging.
- Full Android & iOS example app (`example/`) generated from the latest Flutter
  templates (AGP 9, Kotlin 2, Java 17, iOS 15 + UIScene lifecycle) using a
  Material 3 `ColorScheme.fromSeed` theme.

### Changed
- Verified against Flutter 3.47 / Dart 3.13 with Material 3 (the default).
- Example moved to `example/lib/main.dart`.

### Fixed
- Removed the incorrect `>=3.0.0` Flutter constraint from 2.0.x: the widget
  uses `Color.withValues` (Flutter 3.27+), so older projects could install a
  version that failed to compile.
- Starting a new drag while the reset animation is running no longer snaps the
  button back to center.
- Reset animation now uses a single persistent listener (no per-drag listener
  registration).
- `backgroundColor` documentation now states the real default (`0x33FFFFFF`).

## [2.0.1]

### Changed
- Package now supports `Flutter 3.0.0` and all later versions.
- Ensures wider support across older Flutter 3.x projects.

## [2.0.0] - 2026-04-23

### Added
- `width` parameter — set a fixed slider width instead of the default 80 % screen width.
- `dragThreshold` parameter — configure the minimum drag distance to trigger accept/decline.
- 100 % dartdoc coverage on all public API members.
- Comprehensive widget tests.
- Stricter analysis with `flutter_lints` and additional lint rules.

### Changed
- Minimum SDK constraint raised to Dart between `>=3.0.0 <4.0.0` / Flutter `>=3.41.0`.
- Switched from `package:lints` to `package:flutter_lints`.
- Haptic feedback is now triggered in the drag handler instead of inside `build()`.
- Removed no-op `AnimatedOpacity` wrappers that were using a hardcoded `opacity: 1.0`.
- Extracted magic numbers into named constants for better readability.
- Refactored widget internals into clean helper methods.
- Improved README with proper markdown formatting, badges, and up-to-date parameter table.

### Fixed
- Animation listener leak — listeners are now properly removed after the reset animation completes.
- `MediaQuery.of(context).size` replaced with `MediaQuery.sizeOf(context)` for better rebuild performance.

## [1.1.1] - 2025-07-17

### Added
- Dartdoc-style comments (using `///`) to public API members.

## [1.1.0] - 2025-07-01

### Added
- Custom widget support for `acceptIcon` and `declineIcon`.
- New color options: `borderColor`, `callBtnBackgroundColor`.
- `backgroundColor` replaces `idleBackgroundColor` for better clarity.
- Improved documentation and code cleanup.

### Fixed
- More consistent animation logic and border handling.

## [1.0.0] - 2025-06-15

- Initial release.
- `CallSliderButton` widget with full customization.

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

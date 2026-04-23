import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable slider button widget for accepting or declining calls.
///
/// The user drags the center button right to accept or left to decline.
/// When the drag exceeds the [dragThreshold], the corresponding callback
/// ([onAccept] or [onDecline]) is invoked and haptic feedback is triggered.
///
/// {@tool snippet}
/// Basic usage:
///
/// ```dart
/// CallSliderButton(
///   onAccept: () => print('Call accepted'),
///   onDecline: () => print('Call declined'),
/// )
/// ```
/// {@end-tool}
///
/// All visual aspects — colors, icons, dimensions, and text — can be
/// customized via constructor parameters.
class CallSliderButton extends StatefulWidget {
  /// Creates a [CallSliderButton].
  ///
  /// The [onAccept] and [onDecline] callbacks are required.
  const CallSliderButton({
    required this.onAccept,
    required this.onDecline,
    super.key,
    this.acceptText = 'Accept',
    this.declineText = 'Decline',
    this.textStyle,
    this.acceptColor = Colors.green,
    this.declineColor = Colors.red,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.iconColor = Colors.green,
    this.borderColor = const Color(0xFFEBEBEB),
    this.callBtnBackgroundColor = Colors.white,
    this.acceptIcon,
    this.declineIcon,
    this.height = 70,
    this.width,
    this.borderRadius = 50,
    this.iconSize = 35,
    this.iconRadius = 30,
    this.dragThreshold = 80.0,
  });

  /// Called when the user drags the button right past the [dragThreshold].
  final VoidCallback onAccept;

  /// Called when the user drags the button left past the [dragThreshold].
  final VoidCallback onDecline;

  /// Label displayed on the right side when idle.
  ///
  /// Defaults to `'Accept'`.
  final String acceptText;

  /// Label displayed on the left side when idle.
  ///
  /// Defaults to `'Decline'`.
  final String declineText;

  /// Text style applied to both [acceptText] and [declineText].
  ///
  /// When `null`, a default white, semi-bold, 20 px style is used.
  final TextStyle? textStyle;

  /// Background glow color when the button is dragged to the right (accept).
  ///
  /// Defaults to [Colors.green].
  final Color acceptColor;

  /// Background glow color when the button is dragged to the left (decline).
  ///
  /// Defaults to [Colors.red].
  final Color declineColor;

  /// Background color of the slider track when idle.
  ///
  /// Defaults to `Color(0xFFF6F6F6)`.
  final Color backgroundColor;

  /// Color of the center icon when idle (used by default accept icon).
  ///
  /// Defaults to [Colors.green].
  final Color iconColor;

  /// Border color of the slider track.
  ///
  /// Defaults to `Color(0xFFEBEBEB)`.
  final Color borderColor;

  /// Background color of the circular call button.
  ///
  /// Defaults to [Colors.white].
  final Color callBtnBackgroundColor;

  /// Custom widget to display when the button is dragged right.
  ///
  /// When `null`, a default [Icons.call] icon is used.
  final Widget? acceptIcon;

  /// Custom widget to display when the button is dragged left.
  ///
  /// When `null`, a default [Icons.call_end] icon is used.
  final Widget? declineIcon;

  /// Height of the slider track.
  ///
  /// Defaults to `70`.
  final double height;

  /// Width of the slider track.
  ///
  /// When `null`, defaults to 80 % of the available width via
  /// [MediaQuery.sizeOf].
  final double? width;

  /// Corner radius of the slider track.
  ///
  /// Defaults to `50`.
  final double borderRadius;

  /// Size of the center icon inside the circular avatar.
  ///
  /// Defaults to `35`.
  final double iconSize;

  /// Radius of the circular avatar around the center icon.
  ///
  /// Defaults to `30`.
  final double iconRadius;

  /// The minimum drag distance (in logical pixels) required to trigger
  /// [onAccept] or [onDecline].
  ///
  /// Defaults to `80.0`.
  final double dragThreshold;

  @override
  State<CallSliderButton> createState() => _CallSliderButtonState();
}

class _CallSliderButtonState extends State<CallSliderButton>
    with TickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _hapticTriggered = false;

  late final AnimationController _resetController;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  // Fraction of container width used as the maximum drag limit.
  static const double _dragLimitFraction = 0.39;

  // Fraction of container width used as label padding inset.
  static const double _labelPaddingFraction = 0.09;

  // Opacity range for the background color glow.
  static const double _minGlowOpacity = 0.2;
  static const double _maxGlowOpacity = 0.8;

  // Extra pixels beyond the threshold before haptic fires.
  static const double _hapticBuffer = 5.0;

  // Default text style for labels.
  static const TextStyle _defaultTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  @override
  void initState() {
    super.initState();

    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _resetController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// Handles horizontal drag updates, clamping the position and triggering
  /// haptic feedback when the drag first passes the threshold.
  void _onDragUpdate(DragUpdateDetails details, double safeDragLimit) {
    setState(() {
      _dragPosition += details.delta.dx;
      _dragPosition = _dragPosition.clamp(-safeDragLimit, safeDragLimit);
    });

    // Trigger haptic feedback once when the drag exceeds the threshold.
    if (!_hapticTriggered &&
        _dragPosition.abs() > widget.dragThreshold + _hapticBuffer) {
      HapticFeedback.mediumImpact();
      _hapticTriggered = true;
    }
  }

  /// Evaluates the final drag position and fires the appropriate callback,
  /// then animates the button back to center.
  void _onDragEnd(DragEndDetails details) {
    if (_dragPosition > widget.dragThreshold) {
      widget.onAccept();
    } else if (_dragPosition < -widget.dragThreshold) {
      widget.onDecline();
    }
    _animateReset();
  }

  /// Smoothly resets the drag position to zero.
  void _animateReset() {
    final Animation<double> resetAnimation = Tween<double>(
      begin: _dragPosition,
      end: 0.0,
    ).animate(_resetController);

    void listener() {
      setState(() {
        _dragPosition = resetAnimation.value;
      });
      if (_resetController.isCompleted) {
        resetAnimation.removeListener(listener);
      }
    }

    resetAnimation.addListener(listener);
    _resetController.forward(from: 0.0);
    _hapticTriggered = false;
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        widget.width ?? MediaQuery.sizeOf(context).width * 0.8;
    final double safeDragLimit = containerWidth * _dragLimitFraction;

    final bool isDragging = _dragPosition != 0;
    final bool isDeclining = _dragPosition < 0;

    final Color bgColor = _resolveBackgroundColor(safeDragLimit);
    final Widget iconWidget = _resolveIcon(isDeclining);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          width: containerWidth,
          height: widget.height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: bgColor.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              // Labels are only visible when idle.
              if (!isDragging) _buildIdleLabels(containerWidth),

              // Draggable call button with pulse animation.
              _buildDraggableButton(safeDragLimit, iconWidget),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Determines the background color based on the current drag direction
  /// and progress.
  Color _resolveBackgroundColor(double safeDragLimit) {
    if (_dragPosition == 0) return widget.backgroundColor;

    final double progress = (_dragPosition.abs() / safeDragLimit).clamp(
      0.0,
      1.0,
    );
    final double alpha =
        _minGlowOpacity + (_maxGlowOpacity - _minGlowOpacity) * progress;

    return _dragPosition > 0
        ? widget.acceptColor.withValues(alpha: alpha)
        : widget.declineColor.withValues(alpha: alpha);
  }

  /// Returns the appropriate icon widget based on drag direction.
  Widget _resolveIcon(bool isDeclining) {
    if (isDeclining) {
      return widget.declineIcon ??
          Icon(
            Icons.call_end,
            color: widget.declineColor,
            size: widget.iconSize,
          );
    }
    return widget.acceptIcon ??
        Icon(Icons.call, color: widget.iconColor, size: widget.iconSize);
  }

  /// Builds the accept / decline labels shown when the button is idle.
  Widget _buildIdleLabels(double containerWidth) {
    final double inset = containerWidth * _labelPaddingFraction;
    final TextStyle style = widget.textStyle ?? _defaultTextStyle;

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: inset),
            child: Text(widget.declineText, style: style),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: inset),
            child: Text(widget.acceptText, style: style),
          ),
        ),
      ],
    );
  }

  /// Builds the draggable center button with a pulsing scale animation.
  Widget _buildDraggableButton(double safeDragLimit, Widget iconWidget) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) =>
          _onDragUpdate(details, safeDragLimit),
      onHorizontalDragEnd: _onDragEnd,
      child: Transform.translate(
        offset: Offset(_dragPosition, 0),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _pulseAnimation.value, child: child);
          },
          child: CircleAvatar(
            backgroundColor: widget.callBtnBackgroundColor,
            radius: widget.iconRadius,
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}

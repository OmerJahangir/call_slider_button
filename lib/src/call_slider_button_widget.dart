import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CallSliderButton extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  // Customizable labels
  final String acceptText;
  final String declineText;

  // Style options
  final TextStyle? textStyle;
  final Color acceptColor;
  final Color declineColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
  final Color callBtnBackgroundColor;

  // Icons can be replaced with custom widgets
  final Widget? acceptIcon;
  final Widget? declineIcon;

  // Dimensions
  final double height;
  final double borderRadius;
  final double iconSize;
  final double iconRadius;

  const CallSliderButton({
    super.key,
    required this.onAccept,
    required this.onDecline,
    this.acceptText = 'Accept',
    this.declineText = 'Decline',
    this.textStyle,
    this.acceptColor = Colors.green,
    this.declineColor = Colors.red,
    this.backgroundColor = const Color(0xffF6F6F6),
    this.iconColor = Colors.green,
    this.borderColor = const Color(0xffEBEBEB),
    this.callBtnBackgroundColor = Colors.white,
    this.acceptIcon,
    this.declineIcon,
    this.height = 70,
    this.borderRadius = 50,
    this.iconSize = 35,
    this.iconRadius = 30,
  });

  @override
  State<CallSliderButton> createState() => _CallSliderButtonState();
}

class _CallSliderButtonState extends State<CallSliderButton>
    with TickerProviderStateMixin {
  double _dragPosition = 0.0;
  final double _dragThreshold = 80.0;
  bool _hapticTriggered = false;

  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  /// Initialize animations
  @override
  void initState() {
    super.initState();

    // Controller to animate back to center after drag ends
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Pulse animation for the call button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  /// Dispose animation controllers
  @override
  void dispose() {
    _resetController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// Handle drag release and trigger actions
  void _handleDragEnd(DragEndDetails details) {
    if (_dragPosition > _dragThreshold) {
      widget.onAccept();
    } else if (_dragPosition < -_dragThreshold) {
      widget.onDecline();
    }
    _animateReset();
  }

  /// Animate the button back to center
  void _animateReset() {
    _resetAnimation = Tween<double>(
      begin: _dragPosition,
      end: 0.0,
    ).animate(_resetController)..addListener(() {
      setState(() {
        _dragPosition = _resetAnimation.value;
      });
    });
    _resetController.forward(from: 0.0);
    _hapticTriggered = false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDragging = _dragPosition != 0;
    final bool isDeclining = _dragPosition < 0;

    final double containerWidth = MediaQuery.of(context).size.width * 0.8;
    final double safeDragLimit = containerWidth * 0.39;

    // Background color based on drag direction
    final double progress = (_dragPosition.abs() / safeDragLimit).clamp(
      0.0,
      1.0,
    );
    final Color bgColor =
        _dragPosition > 0
            ? widget.acceptColor.withValues(alpha: 0.2 + 0.6 * progress)
            : _dragPosition < 0
            ? widget.declineColor.withValues(alpha: 0.2 + 0.6 * progress)
            : widget.backgroundColor;

    // Icon logic: use user-provided widget or fallback icon
    final Widget defaultAcceptIcon = Icon(
      Icons.call,
      color: widget.iconColor,
      size: widget.iconSize,
    );
    final Widget defaultDeclineIcon = Icon(
      Icons.call_end,
      color: widget.declineColor,
      size: widget.iconSize,
    );
    final Widget iconWidget =
        isDeclining
            ? (widget.declineIcon ?? defaultDeclineIcon)
            : (widget.acceptIcon ?? defaultAcceptIcon);

    // Trigger haptic feedback once
    if (!_hapticTriggered && (_dragPosition.abs() > _dragThreshold + 5)) {
      HapticFeedback.mediumImpact();
      _hapticTriggered = true;
    }

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
              // Texts visible only when idle
              if (!isDragging) ...[
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 1.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: containerWidth * 0.09),
                      child: Text(
                        widget.declineText,
                        style:
                            widget.textStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 1.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: containerWidth * 0.09),
                      child: Text(
                        widget.acceptText,
                        style:
                            widget.textStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                ),
              ],

              // The draggable call button with pulse animation
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragPosition += details.delta.dx;
                    _dragPosition = _dragPosition.clamp(
                      -safeDragLimit,
                      safeDragLimit,
                    );
                  });
                },
                onHorizontalDragEnd: _handleDragEnd,
                child: Transform.translate(
                  offset: Offset(_dragPosition, 0),
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: child,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: widget.callBtnBackgroundColor,
                      radius: widget.iconRadius,
                      child: iconWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

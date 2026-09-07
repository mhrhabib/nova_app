import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_durations.dart';
import '../routing/route_names.dart';

class IosBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isOverlay; // Set true for image overlay views like property detail
  final double size;

  const IosBackButton({
    super.key,
    this.onPressed,
    this.isOverlay = false,
    this.size = 40.0,
  });

  @override
  State<IosBackButton> createState() => _IosBackButtonState();
}

class _IosBackButtonState extends State<IosBackButton> {
  bool _isPressed = false;

  void _handleTap() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    } else {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = widget.isOverlay
        ? Colors.black.withValues(alpha: 0.45)
        : (isDark
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.surface);

    final iconColor = widget.isOverlay
        ? Colors.white
        : theme.colorScheme.onSurface;

    final borderColor = widget.isOverlay
        ? Colors.white.withValues(alpha: 0.25)
        : theme.colorScheme.outline.withValues(alpha: 0.4);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _handleTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.90 : 1.0,
        duration: AppDurations.fast,
        curve: Curves.easeOutCubic,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: widget.isOverlay ? 0.25 : 0.08,
                ),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: widget.size * 0.45,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

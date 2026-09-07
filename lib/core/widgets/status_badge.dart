import 'package:flutter/material.dart';

enum StatusBadgeType { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  final String text;
  final StatusBadgeType type;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    this.type = StatusBadgeType.neutral,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color bg;
    Color fg;

    switch (type) {
      case StatusBadgeType.success:
        bg = const Color(0xFF10B981).withValues(alpha: 0.15);
        fg = const Color(0xFF059669);
        break;
      case StatusBadgeType.warning:
        bg = const Color(0xFFF59E0B).withValues(alpha: 0.15);
        fg = const Color(0xFFD97706);
        break;
      case StatusBadgeType.error:
        bg = const Color(0xFFEF4444).withValues(alpha: 0.15);
        fg = const Color(0xFFDC2626);
        break;
      case StatusBadgeType.info:
        bg = theme.colorScheme.primary.withValues(alpha: 0.15);
        fg = theme.colorScheme.primary;
        break;
      case StatusBadgeType.neutral:
        bg = theme.colorScheme.surfaceContainerHighest;
        fg = theme.colorScheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

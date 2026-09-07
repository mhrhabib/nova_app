import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Base Colors (Nova Real-Estate Signature Palette)
  static const Color primaryBlue = Color(0xFF0F52BA); // Sapphire/Navy Accent
  static const Color primaryBlueDark = Color(0xFF3B82F6);
  static const Color secondaryGold = Color(0xFFD97706); // Warm Amber/Gold
  static const Color secondaryGoldDark = Color(0xFFF59E0B);

  // Neutral - Light Theme
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightOnSurface = Color(0xFF0F172A);
  static const Color lightOnSurfaceVariant = Color(0xFF475569);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Neutral - Dark Theme
  static const Color darkBackground = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceVariant = Color(0xFF1F2937);
  static const Color darkOnSurface = Color(0xFFF9FAFB);
  static const Color darkOnSurfaceVariant = Color(0xFF9CA3AF);
  static const Color darkBorder = Color(0xFF374151);

  // Status & Feedback
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Overlay & Shadows
  static const Color overlayLight = Color(0x33000000);
  static const Color overlayDark = Color(0x66000000);
}

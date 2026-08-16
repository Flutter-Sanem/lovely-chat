import 'package:flutter/material.dart';

/// Autumn Chat design color tokens.
///
/// Prefer [Theme.of] / [ColorScheme] in UI — avoid raw hex in widgets.
abstract final class AppColors {
  static const Color primary = Color(0xFFD97745);
  static const Color secondary = Color(0xFFC97878);
  static const Color tertiary = Color(0xFFD6A34A);

  static const Color backgroundLight = Color(0xFFFFF8F1);
  static const Color surfaceLight = Color(0xFFFFFDF9);
  static const Color surfaceVariantLight = Color(0xFFF5EDE4);

  static const Color backgroundDark = Color(0xFF1E1916);
  static const Color surfaceDark = Color(0xFF29221E);
  static const Color surfaceVariantDark = Color(0xFF342B26);

  static const Color textDeepBrown = Color(0xFF392E29);
  static const Color textMuted = Color(0xFF85736B);
  static const Color textOnPrimary = Color(0xFFFFFDF9);

  static const Color success = Color(0xFF5F7D5A);
  static const Color error = Color(0xFFB54A3F);
  static const Color outlineLight = Color(0xFFE5D6C8);
  static const Color outlineDark = Color(0xFF4A3F38);
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Material 3 [TextTheme] built on Plus Jakarta Sans.
abstract final class AppTypography {
  static TextTheme textTheme({required Brightness brightness}) {
    final Color bodyColor = brightness == Brightness.light
        ? AppColors.textDeepBrown
        : const Color(0xFFF3E9E1);
    final Color mutedColor = AppColors.textMuted;

    final TextTheme base = GoogleFonts.plusJakartaSansTextTheme();

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: bodyColor,
        height: 1.45,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: bodyColor,
        height: 1.4,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: mutedColor,
        height: 1.35,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: mutedColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: mutedColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Soft, wide-blur shadows — never heavy drop shadows.
abstract final class AppShadows {
  static List<BoxShadow> soft({bool dark = false}) => [
        BoxShadow(
          color: (dark ? Colors.black : AppColors.textDeepBrown)
              .withValues(alpha: dark ? 0.35 : 0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> subtle({bool dark = false}) => [
        BoxShadow(
          color: (dark ? Colors.black : AppColors.textDeepBrown)
              .withValues(alpha: dark ? 0.25 : 0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}

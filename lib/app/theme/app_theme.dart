import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

/// Material 3 Autumn themes (light + dark).
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isLight = brightness == Brightness.light;

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: isLight
          ? const Color(0xFFF3D5C0)
          : const Color(0xFF5C3A28),
      onPrimaryContainer:
          isLight ? AppColors.textDeepBrown : const Color(0xFFF8E8DC),
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: isLight
          ? const Color(0xFFF0D4D4)
          : const Color(0xFF5A3535),
      onSecondaryContainer:
          isLight ? AppColors.textDeepBrown : const Color(0xFFF8E4E4),
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.textDeepBrown,
      tertiaryContainer: isLight
          ? const Color(0xFFF3E2C0)
          : const Color(0xFF5A4724),
      onTertiaryContainer:
          isLight ? AppColors.textDeepBrown : const Color(0xFFF8EDD4),
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      errorContainer: isLight
          ? const Color(0xFFF5D4CF)
          : const Color(0xFF5C2A24),
      onErrorContainer:
          isLight ? AppColors.textDeepBrown : const Color(0xFFF8E0DC),
      surface: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      onSurface: isLight ? AppColors.textDeepBrown : const Color(0xFFF3E9E1),
      surfaceContainerHighest: isLight
          ? AppColors.surfaceVariantLight
          : AppColors.surfaceVariantDark,
      onSurfaceVariant: AppColors.textMuted,
      outline: isLight ? AppColors.outlineLight : AppColors.outlineDark,
      outlineVariant: isLight
          ? const Color(0xFFEDDFD2)
          : const Color(0xFF3F352F),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface:
          isLight ? AppColors.textDeepBrown : AppColors.surfaceLight,
      onInverseSurface:
          isLight ? AppColors.surfaceLight : AppColors.textDeepBrown,
      inversePrimary: isLight
          ? const Color(0xFFE8A882)
          : AppColors.primary,
    );

    final TextTheme textTheme = AppTypography.textTheme(brightness: brightness);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isLight ? AppColors.backgroundLight : AppColors.backgroundDark,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        backgroundColor:
            isLight ? AppColors.backgroundLight : AppColors.backgroundDark,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.largeAll),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 68,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mediumAll,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumAll,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mediumAll,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.largeAll),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        backgroundColor: colorScheme.surface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

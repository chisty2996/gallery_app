import 'package:flutter/material.dart';
import 'package:umbrella_listing/core/constants/app_colors.dart';
import 'package:umbrella_listing/core/constants/radius_constants.dart';
import 'package:umbrella_listing/core/config/theme/theme_constants.dart';

/// Dark theme configuration
ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
    ),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: ThemeConstants.elevation0,
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      iconTheme: IconThemeData(color: AppColors.darkOnSurface),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: ThemeConstants.elevation2,
      shape: RoundedRectangleBorder(
        borderRadius: RadiusConstants.largeRadius,
      ),
      color: AppColors.darkSurface,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(
        borderRadius: RadiusConstants.mediumRadius,
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: RadiusConstants.mediumRadius,
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: RadiusConstants.mediumRadius,
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: RadiusConstants.mediumRadius,
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: ThemeConstants.elevation2,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: RadiusConstants.mediumRadius,
        ),
        minimumSize: const Size(double.infinity, ThemeConstants.buttonHeightLarge),
        textStyle: const TextStyle(
          fontSize: ThemeConstants.fontSizeLabelLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontSize: ThemeConstants.fontSizeLabelLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: RadiusConstants.mediumRadius,
        ),
        minimumSize: const Size(double.infinity, ThemeConstants.buttonHeightLarge),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.darkOnSurface,
      size: ThemeConstants.iconSizeMedium,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: ThemeConstants.elevation8,
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: ThemeConstants.fontSizeDisplayLarge,
        fontWeight: FontWeight.w700,
        color: AppColors.darkOnSurface,
      ),
      displayMedium: TextStyle(
        fontSize: ThemeConstants.fontSizeDisplayMedium,
        fontWeight: FontWeight.w700,
        color: AppColors.darkOnSurface,
      ),
      displaySmall: TextStyle(
        fontSize: ThemeConstants.fontSizeDisplaySmall,
        fontWeight: FontWeight.w700,
        color: AppColors.darkOnSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: ThemeConstants.fontSizeHeadlineLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.darkOnSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: ThemeConstants.fontSizeHeadlineMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.darkOnSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: ThemeConstants.fontSizeHeadlineSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.darkOnSurface,
      ),
      titleLarge: TextStyle(
        fontSize: ThemeConstants.fontSizeTitleLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.darkOnSurface,
      ),
      titleMedium: TextStyle(
        fontSize: ThemeConstants.fontSizeTitleMedium,
        fontWeight: FontWeight.w500,
        color: AppColors.darkOnSurface,
      ),
      titleSmall: TextStyle(
        fontSize: ThemeConstants.fontSizeTitleSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.darkOnSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: ThemeConstants.fontSizeBodyLarge,
        fontWeight: FontWeight.w400,
        color: AppColors.darkOnSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: ThemeConstants.fontSizeBodyMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.darkOnSurface,
      ),
      bodySmall: TextStyle(
        fontSize: ThemeConstants.fontSizeBodySmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: ThemeConstants.fontSizeLabelLarge,
        fontWeight: FontWeight.w500,
        color: AppColors.darkOnSurface,
      ),
      labelMedium: TextStyle(
        fontSize: ThemeConstants.fontSizeLabelMedium,
        fontWeight: FontWeight.w500,
        color: AppColors.darkOnSurface,
      ),
      labelSmall: TextStyle(
        fontSize: ThemeConstants.fontSizeLabelSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:umbrella_listing/core/config/theme/light_theme.dart';
import 'package:umbrella_listing/core/config/theme/dark_theme.dart';

/// App theme manager
class AppTheme {
  AppTheme._();

  /// Get light theme
  static ThemeData get light => lightTheme();

  /// Get dark theme
  static ThemeData get dark => darkTheme();

  /// Check if current theme is dark
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

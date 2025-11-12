import 'package:flutter/material.dart';

/// Padding constants for consistent padding throughout the app
class PaddingConstants {
  PaddingConstants._();

  /// Screen padding - 16.0
  static const double screenPadding = 16.0;

  /// Card padding - 12.0
  static const double cardPadding = 12.0;

  /// Screen padding as EdgeInsets
  static const EdgeInsets screenPaddingAll = EdgeInsets.all(screenPadding);

  /// Horizontal screen padding
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: screenPadding);

  /// Vertical screen padding
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: screenPadding);

  /// Card padding as EdgeInsets
  static const EdgeInsets cardPaddingAll = EdgeInsets.all(cardPadding);

  /// Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  /// Small padding
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);

  /// Medium padding
  static const EdgeInsets mediumPadding = EdgeInsets.all(16.0);

  /// Large padding
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);
}

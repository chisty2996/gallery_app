import 'package:flutter/material.dart';

/// Border radius constants for consistent border radius throughout the app
class RadiusConstants {
  RadiusConstants._();

  /// Small radius - 4.0
  static const double small = 4.0;

  /// Medium radius - 8.0
  static const double medium = 8.0;

  /// Large radius - 12.0
  static const double large = 12.0;

  /// Extra large radius - 16.0
  static const double xLarge = 16.0;

  /// Circular radius - 100.0
  static const double circular = 100.0;

  /// Small border radius
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(small));

  /// Medium border radius
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(medium));

  /// Large border radius
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(large));

  /// Extra large border radius
  static const BorderRadius xLargeRadius = BorderRadius.all(Radius.circular(xLarge));

  /// Circular border radius
  static const BorderRadius circularRadius = BorderRadius.all(Radius.circular(circular));
}

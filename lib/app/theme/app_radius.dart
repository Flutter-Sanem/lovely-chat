import 'package:flutter/material.dart';

/// Corner radius tokens.
abstract final class AppRadius {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 18;
  static const double xl = 24;

  /// Characterful chat bubble corners (incoming / outgoing can swap).
  static const double bubble = 18;
  static const double bubbleTail = 4;

  static final BorderRadius smallAll = BorderRadius.circular(small);
  static final BorderRadius mediumAll = BorderRadius.circular(medium);
  static final BorderRadius largeAll = BorderRadius.circular(large);
  static final BorderRadius xlAll = BorderRadius.circular(xl);
}

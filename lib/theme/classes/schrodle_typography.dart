import 'package:flutter/material.dart';

/// {@template SchrodleTypography}
/// The collection of typographical layouts used by [Text] widgets in Schrodle.
/// {@endtemplate}
abstract final class SchrodleTypography {
  /// The layout of a heading.
  static const TextStyle heading = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );

  /// The layout of a subheading.
  static const TextStyle subheading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}

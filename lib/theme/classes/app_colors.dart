import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color none = Colors.transparent;
  static const Color light = Colors.white;
  static const Color highlight = Color.fromARGB(255, 80, 80, 80);
  static const Color shade = Colors.black;
  static const Color background = Color(0xFF1E1E1E);
  static const Color unevaluated = none;
  static const Color absent = highlight;
  static const Color present = Color(0xFFF2B829); // Jake the Dog
  static const Color correct = Color(0xFF39a024); // Finn the Human (backpack)
  static const Color guessed = Color(0xFFFF00CD); // Princess Bubblegum
  static const Color normal = Color(0xFF66BB6A);
  static const Color hard = Colors.red;
  static const Color button = Colors.blue;
}

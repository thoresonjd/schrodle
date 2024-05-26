import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template confetti}
/// Renders a confetti animation
/// {@endtemplate}
class Confetti extends StatefulWidget {
  /// {@macro confetti}
  const Confetti({super.key});

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  /// Controls the confetti animation.
  final ConfettiController _confettiController = ConfettiController();

  /// The colors for the confetti.
  final List<Color> _confettiColors = [
    SchrodleColors.present,
    SchrodleColors.correct,
    SchrodleColors.guessed,
    SchrodleColors.normal,
    SchrodleColors.probabilistic,
    SchrodleColors.hard,
    SchrodleColors.button,
  ];

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const numParticles = 15;
    const emissionFrequency = 0.025;
    const minBlastForce = 10.0;
    const maxBlastForce = 30.0;
    const gravity = 0.02;
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      numberOfParticles: numParticles,
      emissionFrequency: emissionFrequency,
      minBlastForce: minBlastForce,
      maxBlastForce: maxBlastForce,
      gravity: gravity,
      colors: _confettiColors,
      shouldLoop: true,
    );
  }
}

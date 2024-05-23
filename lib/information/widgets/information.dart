import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_grid.dart';
import 'package:schrodle/theme/theme.dart';

/// {@template information}
/// Renders the information dialog, which describes the game.
/// {@endtemplate}
class Information extends StatelessWidget {
  /// {@macro information}
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    const sectionSpacing = 25.0;
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Schrodle',
            style: SchrodleTypography.heading,
          ),
        ),
        Text(
          'Premise',
          style: SchrodleTypography.subheading,
        ),
        Text(
          'Schrodle is a game that is inspired by Wordle and the '
          "Schrödinger's Cat thought experiment. The game works exactly "
          'like Wordle, but with a twist. Like Wordle, the player is '
          'tasked with guessing the daily word, which we call the '
          '"target." However, in addition to the target, there is a '
          'secondary word, called the "impostor."', 
        ),
        SizedBox(height: sectionSpacing),
        Text(
          'Normal mode',
          style: SchrodleTypography.subheading,
        ),
        Text(
          'Whenever a guess is made, there is a 50/50 chance that the ' 
          'guess will be validated against either the target or the '
          'impostor. Therefore, if the impostor is selected to validate '
          'the guess, letters can be marked as present in the target word '
          'when, in fact, they are absent (or in the incorrect position). '
          'It follows that letters may be simultaneously market correctly '
          'and incorrectly with respect to the target. Thus, the '
          "Schrödinger's Cat thought experiment is, in essence, upheld.",
        ),
        SizedBox(height: sectionSpacing),
        Text(
          'Probabilistic mode',
          style: SchrodleTypography.subheading,
        ),
        Text(
          'When the target is selected, the probability to select it in a '
          'subsequent guess decreases. Conversely, the probability to '
          'select the target word will increase if it is not selected. '
          'The impostor has an inverse probability as the target, where '
          'the total selection probability for both equates to 100%.',
        ),
        SizedBox(height: sectionSpacing),
        Text(
          'Hard mode',
          style: SchrodleTypography.subheading,
        ),
        Text(
          'The guess is validated against a constructed word where each '
          'individual letter has a 50/50 chance of being derived from the '
          'corresponding index in either the target or the impostor. '
          'To compensate, the player is allotted additional guesses.',
        ),
        SizedBox(height: sectionSpacing),
        Text(
          'Example',
          style: SchrodleTypography.subheading,
        ),
        Text('Mode: Normal'),
        Text('Target: AXIOM'),
        Text('Impostor: LOGIC'),
        ExampleGrid(),
        SizedBox(height: sectionSpacing),
        Text(
          'Credit',
          style: SchrodleTypography.subheading,
        ),
        Text('Created by Justin Thoreson and Ana Mendes.'),
        Text('Inspired by Wordle, developed by Josh Wardle.'),
        Text(
          "Inspired by the Schrödinger's Cat thought experiment, "
          'devised by Erwin Schrödinger.',
        ),
      ],
    );
  }
}

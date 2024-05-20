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
    final size = MediaQuery.of(context).size;
    final paddingHorizontal = size.width * 0.1;
    final paddingVertical = size.height * 0.1;
    const sectionSpacing = 25.0;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        paddingHorizontal,
        paddingVertical,
        paddingHorizontal,
        paddingVertical,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.clear),
              ),
            ),
            const Center(
              child: Text(
                'Schrodle',
                style: SchrodleTypography.heading,
              ),
            ),
            const Text(
              'Premise',
              style: SchrodleTypography.subheading,
            ),
            const Text(
              'Schrodle is a game that is inspired by Wordle and the '
              "Schrödinger's Cat thought experiment. The game works exactly "
              'like Wordle, but with a twist. Like Wordle, the player is '
              'tasked with guessing the daily word, which we call the '
              '"target." However, in addition to the target, there is a '
              'secondary word, called the "impostor."', 
            ),
            const SizedBox(height: sectionSpacing),
            const Text(
              'Normal mode',
              style: SchrodleTypography.subheading,
            ),
            const Text(
              'Whenever a guess is made, there is a 50/50 chance that the ' 
              'guess will be validated against either the target or the '
              'impostor. Therefore, if the impostor is selected to validate '
              'the guess, letters can be marked as present in the target word '
              'when, in fact, they are absent (or in the incorrect position). '
              'It follows that letters may be simultaneously market correctly '
              'and incorrectly with respect to the target. Thus, the '
              "Schrödinger's Cat thought experiment is, in essence, upheld.",
            ),
            const SizedBox(height: sectionSpacing),
            const Text(
              'Probabilistic mode',
              style: SchrodleTypography.subheading,
            ),
            const Text(
              'When the target is selected, the probability to select it in a '
              'subsequent guess decreases. Conversely, the probability to '
              'select the target word will increase if it is not selected. '
              'The impostor has an inverse probability as the target, where '
              'the total selection probability for both equates to 100%.',
            ),
            const SizedBox(height: sectionSpacing),
            const Text(
              'Hard mode',
              style: SchrodleTypography.subheading,
            ),
            const Text(
              'The guess is validated against a constructed word where each '
              'individual letter has a 50/50 chance of being derived from the '
              'corresponding index in either the target or the impostor. '
              'To compensate, the player is allotted additional guesses.',
            ),
            const SizedBox(height: sectionSpacing),
            const Text(
              'Example',
              style: SchrodleTypography.subheading,
            ),
            const Text('Mode: Normal'),
            const Text('Target: AXIOM'),
            const Text('Impostor: LOGIC'),
            const ExampleGrid(),
            const SizedBox(height: sectionSpacing),
            const Text(
              'Credit',
              style: SchrodleTypography.subheading,
            ),
            const Text('Created by Justin Thoreson and Ana Mendes.'),
            const Text('Inspired by Wordle, developed by Josh Wardle.'),
            const Text(
              "Inspired by the Schrödinger's Cat thought experiment, "
              'devised by Erwin Schrödinger.',
            ),
          ],
        ),
      ),
    );
  }
}

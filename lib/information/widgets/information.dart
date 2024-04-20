import 'package:flutter/material.dart';
import 'package:schrodle/information/widgets/example_grid.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingHorizontal = size.width * 0.1;
    final paddingVertical = size.height * 0.1;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(
        paddingHorizontal,
        paddingVertical,
        paddingHorizontal,
        paddingVertical,
      ),
      content: Column(
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
          const Text('About the Game'),
          const Text('Schrodle is a Wordle-based game inspired by the '
            "Schrödinger's Cat thought experiment."),
          const Text('The game works exactly like Wordle, but with a twist.'),
          const Text(
            'Like Wordle, the player is tasked with guessing the daily word, '
            'which we call the "target." However, in addition to the target, '
            'there is a secondary word, called the "impostor." Whenever a '
            'guess is made, the guess has a 50% chance of being validated '
            'against either the target or the impostor. Therefore, if the '
            'impostor is used to validate the guess, letters can be marked as '
            'present in the target word when, in fact, the are absent. Letters '
            'may be simultaneously market present and not present. Thus, the '
            "Schrödinger's Cat thought experiment is, in essence, upheld."
          ),
          const Text('Example'),
          const ExampleGrid(),
        ],
      ),
    );
  }
}

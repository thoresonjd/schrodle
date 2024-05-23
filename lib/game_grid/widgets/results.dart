import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template results}
/// Displays the results dialog when the game ends.
/// {@endtemplate}
class Results extends StatelessWidget {
  /// {@macro results}
  const Results({required this.results, super.key});

  /// The results of the completed game as a [String].
  final String results;

  @override
  Widget build(BuildContext context) {
    const logoSize = 150.0;
    const sectionSpacing = 10.0;
    const textSize = 17.5;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          width: logoSize,
          height: logoSize,
          image: AssetImage('assets/images/schrodle-light.png'),
        ),
        const SizedBox(height: sectionSpacing),
        const Text(
          'Thank you for playing Schrodle!',
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
        const SizedBox(height: sectionSpacing),
        TextButton.icon(
          label: const Text('Copy results'),
          icon: const Icon(Icons.copy),
          onPressed: () => Clipboard.setData(ClipboardData(text: results)),
        ),
      ],
    );
  }
}

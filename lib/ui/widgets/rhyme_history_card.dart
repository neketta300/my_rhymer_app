import 'package:flutter/material.dart';
import 'package:my_rhymer/ui/ui.dart' show BaseContainer;

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({super.key, required this.rhymes, required this.word});

  final List<String> rhymes;
  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      padding: const EdgeInsets.all(16),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            word,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(
            child: Text(
              rhymes.join(', '),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: theme.hintColor.withValues(alpha: 0.4),
              ),
            ),
          ),
          // Wrap(
          //   children:
          //       rhymes
          //           .map(
          //             (e) => Padding(
          //               padding: const EdgeInsets.only(right: 8),
          //               child: Text(e),
          //             ),
          //           )
          //           .toList(),
          // ),
        ],
      ),
    );
  }
}

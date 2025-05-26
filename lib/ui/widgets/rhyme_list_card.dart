import 'package:flutter/material.dart';
import 'package:my_rhymer/ui/ui.dart';

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({
    super.key,
    this.isFavorite = false,
    required this.rhyme,
    this.sourceWord,
  });

  final String rhyme;
  final String? sourceWord;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,

      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (sourceWord != null) ...[
                Text(sourceWord!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: theme.hintColor.withValues(alpha: 0.4),
                  ),
                ),
              ],
              Text(
                rhyme,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // добавление листа виджедов в список видждетов с помощью ...
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color:
                  isFavorite
                      ? theme.primaryColor
                      : theme.hintColor.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

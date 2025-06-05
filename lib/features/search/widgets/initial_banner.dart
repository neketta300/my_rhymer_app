import 'package:flutter/material.dart';
import 'package:my_rhymer/generated/l10n.dart';

class RhymesListInitialBanner extends StatelessWidget {
  const RhymesListInitialBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).startLooking,
            style: theme.textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              S.of(context).typeInTheSearchBarToFindRhymes,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

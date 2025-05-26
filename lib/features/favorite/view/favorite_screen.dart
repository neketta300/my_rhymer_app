import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:my_rhymer/ui/ui.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          pinned: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text('Избранное'),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList.builder(
          itemBuilder:
              (context, index) => const RhymeListCard(
                isFavorite: true,
                rhyme: 'Рифма',
                sourceWord: 'Слово',
              ),
        ),
      ],
    );
  }
}

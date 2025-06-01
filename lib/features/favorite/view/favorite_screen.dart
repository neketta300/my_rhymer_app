import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/ui.dart';
import '../bloc/favorite_rhymes_bloc.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteRhymesBloc>(context).add(LoadFavoriteRhymes());
    super.initState();
  }

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
        BlocBuilder<FavoriteRhymesBloc, FavoriteRhymesState>(
          builder: (context, state) {
            if (state is FavoriteRhymesLoaded) {
              final rhymeModel = state.rhymes;
              return SliverList.builder(
                itemCount: state.rhymes.length,
                itemBuilder: (context, index) {
                  final rhyme = rhymeModel[index];
                  final favoriteRhyme = rhyme.favoriteWord;
                  final sourceWord = rhyme.queryWord;
                  return RhymeListCard(
                    isFavorite: true,
                    rhyme: favoriteRhyme,
                    sourceWord: sourceWord,
                    onTap: () {
                      BlocProvider.of<FavoriteRhymesBloc>(
                        context,
                      ).add(ToggleFavoriteRhyme(rhyme));
                    },
                  );
                },
              );
            }
            return const SliverToBoxAdapter(child: SizedBox());
          },
        ),
      ],
    );
  }
}

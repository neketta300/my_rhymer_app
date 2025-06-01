import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/api/models/rhymes.dart';
import 'package:my_rhymer/features/favorite/bloc/favorite_rhymes_bloc.dart';
import 'package:my_rhymer/features/search/bloc/rhymes_list_bloc.dart';

import '../../../ui/ui.dart';
import '../../history/bloc/history_rhymes_bloc.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          pinned: true,
          title: const Text('My Rhymer'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: SearchButton(
              onTap: () {
                _showSearchBottomSheet();
              },
              controller: _searchTextEditingController,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: BlocConsumer<HistoryRhymesBloc, HistoryRhymesState>(
            listener: (context, state) {
              _handleRhymesListState(state, context);
            },
            builder: (context, state) {
              if (state is! HistoryRhymesLoaded) return const SizedBox();
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: state.rhymes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return RhymeHistoryCard(
                      rhymes: state.rhymes[index].rhymes,
                      word: state.rhymes[index].word,
                    );
                  },
                  separatorBuilder:
                      (BuildContext context, int index) =>
                          const SizedBox(width: 16),
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocBuilder<RhymesListBloc, RhymesListState>(
          builder: (context, state) {
            if (state is RhymesListLoaded) {
              final rhymesModel = state.rhymes;
              final rhymes = rhymesModel.rhymes;
              return SliverList.builder(
                itemCount: rhymes.length,
                itemBuilder: (context, index) {
                  final rhyme = rhymes[index];
                  return RhymeListCard(
                    rhyme: rhyme,
                    isFavorite: state.isFavorite(rhyme),
                    onTap: () {
                      _toggleFavorite(
                        context,
                        state,
                        rhymes,
                        index,
                        rhymesModel,
                      );
                    },
                  );
                },
              );
            }
            if (state is RhymesListLoading) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SliverFillRemaining(child: InitialBanner());
            }
          },
        ),
      ],
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    RhymesListLoaded state,
    List<String> rhymes,
    int index,
    Rhymes rhymesModel,
  ) async {
    final rhymesListBloc = BlocProvider.of<RhymesListBloc>(context);
    final favoriteRhtmesBloc = BlocProvider.of<FavoriteRhymesBloc>(context);
    final completer = Completer();
    rhymesListBloc.add(
      ToggleFavoriteRhymes(
        queryWord: state.queryWord,
        favoriteWord: rhymes[index],
        rhymes: rhymesModel,
        completer: completer,
      ),
    );
    // ждет когда будет вызван complete() в блоке
    await completer.future;
    favoriteRhtmesBloc.add(LoadFavoriteRhymes());
  }

  void _handleRhymesListState(HistoryRhymesState state, BuildContext context) {
    if (state is RhymesListLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  Future<void> _showSearchBottomSheet() async {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = await showModalBottomSheet<String>(
      // позволяет полностью открыть ботомшит
      isScrollControlled: true,

      backgroundColor: Colors.transparent,
      context: context,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.only(top: 60),
            child: SearchRhymesBottomSheet(
              controller: _searchTextEditingController,
            ),
          ),
    );
    // проверка на пустоту и null
    if (query?.isNotEmpty ?? false) {
      bloc.add(SearchRhymes(query: query!));
    }
  }
}

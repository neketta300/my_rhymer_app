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
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          centerTitle: true,
          title: const Text('My Rhymer'),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.hintColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Начни вводить слово...',
                          hintStyle: TextStyle(
                            color: theme.hintColor.withValues(alpha: 0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _onTapSearch(context),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // child: SearchButton(
            //   onTap: () {
            //     _showSearchBottomSheet();
            //   },
            //   controller: _searchTextEditingController,
            // ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
            builder: (context, state) {
              if (state is! HistoryRhymesLoaded) return const SizedBox();
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.rhymes.length,
                  itemBuilder: (context, index) {
                    final rhymes = state.rhymes[index];
                    return RhymeHistoryCard(
                      rhymes: rhymes.rhymes,
                      word: rhymes.word,
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
        BlocConsumer<RhymesListBloc, RhymesListState>(
          listener: _handleRhymesListState,
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
            if (state is RhymesListInitial) {
              return const SliverFillRemaining(
                child: RhymesListInitialBanner(),
              );
            }
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
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

  void _handleRhymesListState(BuildContext context, RhymesListState state) {
    if (state is RhymesListLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  void _onTapSearch(BuildContext context) {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = _searchTextEditingController.text;
    if (query.isNotEmpty) {
      bloc.add(SearchRhymes(query: query));
    }
  }

  //   Future<void> _showSearchBottomSheet() async {
  //     final bloc = BlocProvider.of<RhymesListBloc>(context);
  //     final query = await showModalBottomSheet<String>(
  //       // позволяет полностью открыть ботомшит
  //       isScrollControlled: true,

  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder:
  //           (context) => Padding(
  //             padding: const EdgeInsets.only(top: 60),
  //             child: SearchRhymesBottomSheet(
  //               controller: _searchTextEditingController,
  //             ),
  //           ),
  //     );
  //     // проверка на пустоту и null
  //     if (query?.isNotEmpty ?? false) {
  //       bloc.add(SearchRhymes(query: query!));
  //     }
  //   }
  // }
}

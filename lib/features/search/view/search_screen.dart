import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/features/search/bloc/rhymes_list_bloc.dart';

import '../../../ui/ui.dart';
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
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
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
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final rhymes = List.generate(4, (index) => ('Рифма $index'));
                return RhymeHistoryCard(rhymes: rhymes);
              },
              separatorBuilder:
                  (BuildContext context, int index) =>
                      const SizedBox(width: 16),
              itemCount: 10,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocBuilder<RhymesListBloc, RhymesListState>(
          builder: (context, state) {
            if (state is RhymesListLoaded) {
              final rhymes = state.rhymes.rhymes;
              return SliverList.builder(
                itemCount: rhymes.length,
                itemBuilder:
                    (context, index) => RhymeListCard(rhyme: rhymes[index]),
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

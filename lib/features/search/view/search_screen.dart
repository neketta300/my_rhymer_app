import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../ui/ui.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          pinned: true,
          title: Text('My Rhymer'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SearchButton(),
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
        SliverList.builder(
          itemBuilder: (context, index) => const RhymeListCard(rhyme: 'рифма'),
        ),
      ],
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:my_rhymer/features/home/view/home_screen.dart';

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
          itemBuilder: (context, index) => const RhymeListCard(),
        ),
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded),
          const SizedBox(width: 12),
          Text(
            'Поиск рифмы...',
            style: TextStyle(
              fontSize: 18,
              color: theme.hintColor.withValues(alpha: 0.5),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,

      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Рифма', style: theme.textTheme.bodyLarge),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: theme.hintColor.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({super.key, required this.rhymes});

  final List<String> rhymes;

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
            'Слово',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Wrap(
            children:
                rhymes
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(e),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

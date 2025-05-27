import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../ui/ui.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          title: Text('История'),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              // меняет сооношение ширины и высоту
              childAspectRatio: 1.6,
            ),
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return const RhymeHistoryCard(
                rhymes: ['asdas', 'asdas', 'asdas', 'asdas', 'asdasd'],
              );
            }, childCount: 20),
          ),
        ),
      ],
    );
  }
}

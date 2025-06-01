import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/ui.dart';
import '../bloc/history_rhymes_bloc.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
      builder: (context, state) {
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
            if (state is HistoryRhymesLoaded)
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
                    return RhymeHistoryCard(
                      rhymes: state.rhymes[index].rhymes,
                      word: state.rhymes[index].word,
                    );
                  }, childCount: state.rhymes.length),
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:my_rhymer/ui/ui.dart';

import '../widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          title: Text('Настройки'),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: 'Темная тема',
            value: true,
            onChanged: (value) {},
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: 'Уведомления',
            value: true,
            onChanged: (value) {},
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: 'Разрешить аналитику',
            value: false,
            onChanged: (value) {},
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SettingsActionCard(
            title: 'Очистить историю',
            icon: Icons.delete_sweep_outlined,
            color: Colors.red,
            onTap: () {
              _clearHistory(context);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsActionCard(
            title: 'Поддержка',
            icon: Icons.message_outlined,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 8),
        child: BaseContainer(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  icon,
                  color: color ?? theme.hintColor.withValues(alpha: 0.4),
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

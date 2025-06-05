import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/ui/ui.dart';

import '../../../bloc/cubit/theme_cubit.dart';
import '../../../generated/l10n.dart';
import '../../history/bloc/history_rhymes_bloc.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          pinned: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(S.of(context).settings),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: S.of(context).darkTheme,
            value: isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().setThemeBrightness(
                value ? Brightness.dark : Brightness.light,
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: S.of(context).notifications,
            value: true,
            onChanged: (value) {},
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: S.of(context).allowAnalytics,
            value: false,
            onChanged: (value) {},
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SettingsActionCard(
            title: S.of(context).clearHistory,
            icon: Icons.delete_sweep_outlined,
            color: Colors.red,
            onTap: () {
              _showClearHistoryDialog(context);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsActionCard(
            title: S.of(context).support,
            icon: Icons.message_outlined,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SupportBottomSheet(),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    if (Theme.of(context).isAndroid) {
      showDialog(
        context: context,
        builder:
            (context) =>
                ConfirmationDialog(onConfirm: () => _clearHistory(context)),
      );
    } else {
      showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => ConfirmationDialog(onConfirm: () {}),
      );
    }
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      return Padding(
        padding: const EdgeInsets.all(24.0).copyWith(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => _close(context),
                  icon: Icon(Icons.close, color: theme.colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.telegram),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                label: const Text('Написать в Telegram'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                icon: const Icon(Icons.email),
                onPressed: () {},
                label: const Text('Отправить Email'),
              ),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Поддержка'),
        message: const Text('Ответим вам быстро!'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Написать в Telegram',
              style: TextStyle(color: theme.cupertinoActionColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Отправить Email',
              style: TextStyle(color: theme.cupertinoActionColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return AlertDialog(
        surfaceTintColor: theme.cardColor,
        backgroundColor: theme.cardColor,
        content: const _DialogContent(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        actions: [
          TextButton(
            onPressed: () => _confirm(context),
            child: Text('Да', style: TextStyle(color: theme.hintColor)),
          ),
          TextButton(onPressed: () => _close, child: const Text('Нет')),
        ],
      );
    } else {
      return CupertinoAlertDialog(
        content: const _DialogContent(
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(
              'Да',
              style: TextStyle(color: theme.cupertinoAlertColor),
            ),
            onPressed: () => _confirm(context),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => _close,
            child: Text(
              'Нет',
              style: TextStyle(color: theme.cupertinoActionColor),
            ),
          ),
        ],
      );
    }
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirm(BuildContext context) {
    onConfirm.call();
    Navigator.of(context).pop();
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({required this.crossAxisAlignment});

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Вы уверены?', style: theme.textTheme.headlineSmall),
        Text(
          'История будет удалена навсегда',
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ],
    );
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_rhymer/router/router.dart';

import '../../../generated/l10n.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AutoTabsRouter(
        routes: const [
          SearchRoute(),
          FavoritesRoute(),
          HistoryRoute(),
          SettingsRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) => _openPage(index, tabsRouter),
              unselectedItemColor: theme.hintColor,
              selectedItemColor: theme.primaryColor,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: S.of(context).search,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: S.of(context).favorite,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.history),
                  label: S.of(context).history,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: S.of(context).settings,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    setState(() {});
    tabsRouter.setActiveIndex(index);
  }
}

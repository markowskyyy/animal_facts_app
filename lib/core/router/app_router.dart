import 'package:animal_facts_app/core/design.dart';
import 'package:animal_facts_app/presentation/pages/catalog_screen.dart';
import 'package:animal_facts_app/presentation/pages/collection_screen.dart';
import 'package:animal_facts_app/presentation/pages/detail_screen.dart';
import 'package:animal_facts_app/presentation/pages/quiz_screen.dart';
import 'package:animal_facts_app/presentation/pages/settings_screen.dart';
import 'package:animal_facts_app/presentation/pages/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


// Ключи для StatefulShellRoute
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/catalog',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true, // для отладки, в релизе убрать
  routes: [
    // Главная навигация с BottomNavigationBar
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          key: state.pageKey,
          child: ScaffoldWithNavBar(navigationShell: navigationShell),
        );
      },
      branches: [
        // Вкладка 1: Каталог
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              name: 'catalog',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CatalogScreen(),
              ),
              routes: [
                // Детали животного
                GoRoute(
                  path: 'detail/:animalId',
                  name: 'detail',
                  pageBuilder: (context, state) {
                    final animalId = state.pathParameters['animalId']!;
                    return MaterialPage(
                      child: DetailScreen(animalId: animalId),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // Вкладка 2: Викторина
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/quiz',
              name: 'quiz',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: QuizScreen(),
              ),
              routes: [
                // Викторина с конкретным животным
                GoRoute(
                  path: 'animal/:animalId',
                  name: 'quizAnimal',
                  pageBuilder: (context, state) {
                    final animalId = state.pathParameters['animalId']!;
                    return MaterialPage(
                      child: QuizScreen(animalId: animalId),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // Вкладка 3: Статистика
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistics',
              name: 'statistics',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StatisticsScreen(),
              ),
            ),
          ],
        ),

        // Вкладка 4: Коллекция
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              name: 'collection',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CollectionScreen(),
              ),
            ),
          ],
        ),

        // Вкладка 5: Настройки/Еще
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Виджет с BottomNavigationBar
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.grey,
        backgroundColor: AppColors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            activeIcon: Icon(Icons.help),
            label: 'Викторина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Статистика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark_outlined),
            activeIcon: Icon(Icons.collections_bookmark),
            label: 'Коллекция',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Еще',
          ),
        ],
      ),
    );
  }
}
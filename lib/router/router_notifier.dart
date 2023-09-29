import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/screens/profile/profile_screen.dart';
import 'package:semaphore/screens/project/environment_screen.dart';
import 'package:semaphore/screens/project/dashboard_screen.dart';
import 'package:semaphore/screens/project/inventory_screen.dart';
import 'package:semaphore/screens/project/keystore_screen.dart';
import 'package:semaphore/screens/project/repository_screen.dart';
import 'package:semaphore/screens/project/team_screen.dart';
import 'package:semaphore/screens/project/template_screen.dart';
import 'package:semaphore/screens/project/template_task_screen.dart';
import 'package:semaphore/screens/setting/setting_screen.dart';

import 'package:semaphore/screens/splash/splash_screen.dart';
import 'package:semaphore/screens/home/home_screen.dart';

part 'router_notifier.g.dart';

@riverpod
class RouterNotifier extends _$RouterNotifier implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false;

  @override
  Future<void> build() async {
    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.path == SplashScreen.path;

    if (isSplash) {
      // return isAuth ? HomeScreen.path : SettingsScreen.path;
    }
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          name: SplashScreen.name,
          path: SplashScreen.path,
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: const SplashScreen(),
            );
          },
        ),
        GoRoute(
          name: SettingsScreen.name,
          path: SettingsScreen.path,
          pageBuilder: (context, state) {
            final name = state.pathParameters['module'];
            final module = SettingsScreenModule.values.firstWhere(
                (m) => m.name == name,
                orElse: () => SettingsScreenModule.values.first);

            return MaterialPage<void>(
              key: state.pageKey,
              child: SettingsScreen(module: module),
            );
          },
          redirect: (context, state) => isAuth ? SettingsScreen.path : null,
        ),
        GoRoute(
          name: ProfileScreen.name,
          path: ProfileScreen.path,
          pageBuilder: (context, state) {
            final name = state.pathParameters['module'];
            final module = ProfileScreenModule.values.firstWhere(
                (m) => m.name == name,
                orElse: () => ProfileScreenModule.values.first);

            return MaterialPage<void>(
              key: state.pageKey,
              child: ProfileScreen(module: module),
            );
          },
          redirect: (context, state) => isAuth ? ProfileScreen.path : null,
        ),
        GoRoute(
            name: HomeScreen.name,
            path: HomeScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: DashboardScreen.name,
            path: DashboardScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const DashboardScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: TemplateScreen.name,
            path: TemplateScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const TemplateScreen(),
              );
            },
            routes: [
              GoRoute(
                  name: TemplateTaskScreen.name,
                  path: TemplateTaskScreen.path,
                  pageBuilder: (context, state) {
                    final templateId = int.parse(state.pathParameters['tid']!);
                    return NoTransitionPage<void>(
                      key: state.pageKey,
                      child: TemplateTaskScreen(templateId: templateId),
                    );
                  },
                  routes: const []),
            ]),
        GoRoute(
            name: InventoryScreen.name,
            path: InventoryScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const InventoryScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: EnvironmentScreen.name,
            path: EnvironmentScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const EnvironmentScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: KeyStoreScreen.name,
            path: KeyStoreScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const KeyStoreScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: RepositoryScreen.name,
            path: RepositoryScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const RepositoryScreen(),
              );
            },
            routes: const []),
        GoRoute(
            name: TeamScreen.name,
            path: TeamScreen.path,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const TeamScreen(),
              );
            },
            routes: const []),
      ];

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

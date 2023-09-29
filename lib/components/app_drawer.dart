import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/profile/profile_screen.dart';
import 'package:semaphore/screens/project/environment_screen.dart';
import 'package:semaphore/screens/project/dashboard_screen.dart';
import 'package:semaphore/screens/project/inventory_screen.dart';
import 'package:semaphore/screens/project/keystore_screen.dart';
import 'package:semaphore/screens/project/repository_screen.dart';
import 'package:semaphore/screens/project/team_screen.dart';
import 'package:semaphore/screens/project/template_screen.dart';
import 'package:semaphore/screens/setting/setting_screen.dart';
import 'package:semaphore/state/auth.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/theme.dart';

class LocalDrawer extends ConsumerWidget {
  final String title;

  const LocalDrawer({Key? key, String? title})
      : title = title ?? 'Neumporphic Example',
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);

    final router = ref.read(routerProvider);

    final projects = ref.watch(projectsProvider);
    final currentProject = ref.watch(currentProjectProvider);

    final user = ref.watch(currentUserProvider);

    return Drawer(
      child: NeumorphicBackground(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              margin: const EdgeInsets.only(bottom: 1.0),
              padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 1.0),
              child: Center(
                child: ListTile(
                  leading:
                      Icon(Icons.rocket, color: theme.colorScheme.onPrimary),
                  title: Text(
                    'Project',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                  subtitle: currentProject.when(
                      error: (error, stackTrace) => SizedBox(
                            child: Text(error.toString()),
                          ),
                      loading: () => const NeumorphicProgressIndeterminate(),
                      data: (current) {
                        return Text(
                          current?.name ?? '--',
                          style: theme.textTheme.titleLarge?.copyWith(
                              color:
                                  theme.colorScheme.onPrimary.withOpacity(0.7)),
                        );
                      }),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Dashboard'),
                    selected: false,
                    onTap: () {
                      router.goNamed(DashboardScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.done_all),
                    title: const Text('Task Templates'),
                    selected: false,
                    onTap: () {
                      router.goNamed(TemplateScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.inventory),
                    title: const Text('Inventory'),
                    selected: false,
                    onTap: () {
                      router.goNamed(InventoryScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.monitor),
                    title: const Text('Environment'),
                    selected: false,
                    onTap: () {
                      router.goNamed(EnvironmentScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.key),
                    title: const Text('Key Store'),
                    selected: false,
                    onTap: () {
                      router.goNamed(KeyStoreScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.gite),
                    title: const Text('Repositories'),
                    selected: false,
                    onTap: () {
                      router.goNamed(RepositoryScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_work),
                    title: const Text('Team'),
                    selected: false,
                    onTap: () {
                      router.goNamed(TeamScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
                child: Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Setting'),
                  subtitle: const Text('Theming, Server or Project'),
                  selected: false,
                  onTap: () {
                    router.goNamed(SettingsScreen.name, pathParameters: {
                      'module': SettingsScreenModule.theme.name
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_box),
                  title: const Text('Profile'),
                  subtitle: user.when(
                    error: (error, stackTrace) => SizedBox(
                      child: Text(error.toString()),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    data: (user) => Text(user?.name ?? '--'),
                  ),
                  selected: false,
                  onTap: () {
                    router.goNamed(ProfileScreen.name, pathParameters: {
                      'module': ProfileScreenModule.info.name
                    });
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

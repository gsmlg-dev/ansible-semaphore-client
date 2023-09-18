import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/project/environment_screen.dart';
import 'package:semaphore/screens/project/history_screen.dart';
import 'package:semaphore/screens/project/inventory_screen.dart';
import 'package:semaphore/screens/project/keystore_screen.dart';
import 'package:semaphore/screens/project/repository_screen.dart';
import 'package:semaphore/screens/project/team_screen.dart';
import 'package:semaphore/screens/project/template_screen.dart';
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

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(
            //   color: theme.colorScheme.primary,
            // ),
            child: Center(
                child: projects.when(
              data: (data) {
                return currentProject.when(
                    error: (error, stackTrace) => SizedBox(
                          child: Text(error.toString()),
                        ),
                    loading: () => const NeumorphicProgressIndeterminate(),
                    data: (current) {
                      return DropdownButtonFormField<Project?>(
                        isExpanded: true,
                        value: current,
                        icon: Icon(Icons.expand_more,
                            color: theme.colorScheme.onPrimary),
                        onChanged: (Project? value) {
                          ref
                              .read(currentProjectProvider.notifier)
                              .setCurrent(value);
                        },
                        items: data
                            .map<DropdownMenuItem<Project>>((Project value) {
                          return DropdownMenuItem<Project>(
                            value: value,
                            child: Text(
                              value.name ?? '--',
                            ),
                          );
                        }).toList(),
                      );
                    });
              },
              error: (error, stackTrace) => SizedBox(
                child: Text(error.toString()),
              ),
              loading: () => const NeumorphicProgressIndeterminate(),
            )),
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
                    router.goNamed(HistoryScreen.name, pathParameters: {
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
        ],
      ),
    );
  }
}

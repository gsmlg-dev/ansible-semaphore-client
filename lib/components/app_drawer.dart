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
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final themeMode = ref.watch(themeModeProvider);

    final router = ref.read(routerProvider);

    final projects = ref.watch(projectsProvider);
    final currentProject = ref.watch(currentProjectProvider);

    return Drawer(
      child: NeumorphicBackground(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Center(
                  child: projects.when(
                data: (data) {
                  return currentProject.when(
                      error: (error, stackTrace) => SizedBox(
                            child: Text(error.toString()),
                          ),
                      loading: () => const NeumorphicProgressIndeterminate(),
                      data: (current) {
                        return Neumorphic(
                          style: neumorphicTheme
                              .getNeumorphicStyle()
                              .copyWith(color: theme.colorScheme.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: DropdownButtonFormField<Project?>(
                            isExpanded: true,
                            dropdownColor: theme.colorScheme.primary,
                            style: theme.textTheme.titleMedium!
                                .copyWith(color: theme.colorScheme.onPrimary),
                            value: current,
                            icon: Icon(Icons.expand_more,
                                color: theme.colorScheme.onPrimary),
                            onChanged: (Project? value) {
                              ref
                                  .read(currentProjectProvider.notifier)
                                  .setCurrent(value);
                            },
                            items: data.map<DropdownMenuItem<Project>>(
                                (Project value) {
                              return DropdownMenuItem<Project>(
                                value: value,
                                child: Text(value.name ?? '--',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color:
                                                theme.colorScheme.onPrimary)),
                              );
                            }).toList(),
                          ),
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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
                      Navigator.pop(context);
                      router.goNamed(TeamScreen.name, pathParameters: {
                        'pid': '${currentProject.value?.id ?? 1}'
                      });
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                  margin: const EdgeInsets.all(24),
                  child: NeumorphicToggle(
                    height: 48,
                    selectedIndex: themeMode.index,
                    displayForegroundOnlyIfSelected: true,
                    thumb: Neumorphic(
                        style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          const BorderRadius.all(Radius.circular(12))),
                    )),
                    children: ThemeMode.values
                        .map<ToggleElement>((t) => ToggleElement(
                              background: Center(child: t.icon),
                              foreground: Center(child: t.icon),
                            ))
                        .toList(),
                    onChanged: (i) {
                      ref
                          .read(themeModeProvider.notifier)
                          .changeThemeMode(ThemeMode.values[i]);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

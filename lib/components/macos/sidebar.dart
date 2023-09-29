import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
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

Sidebar buildSidebar(BuildContext context) {
  return Sidebar(
      minWidth: 220,
      top: MacosListTile(
        leading: const MacosIcon(
          CupertinoIcons.rocket,
          color: MacosColors.systemGrayColor,
        ),
        title: Text(
          'Project',
          style: MacosTypography.of(context).title2,
        ),
        subtitle: Consumer(builder: (context, ref, _) {
          final currentProject = ref.watch(currentProjectProvider);

          return currentProject.when(
              error: (error, stackTrace) => SizedBox(
                    child: Text(error.toString()),
                  ),
              loading: () => const ProgressCircle(),
              data: (current) {
                return Text(
                  current?.name ?? '--',
                  style: MacosTypography.of(context)
                      .title2
                      .copyWith(color: MacosColors.systemGrayColor),
                );
              });
        }),
      ),
      builder: (context, scrollController) {
        return Consumer(builder: (context, ref, _) {
          final router = ref.read(routerProvider);
          final currentProject = ref.watch(currentProjectProvider);
          final currnetName = GoRouterState.of(context).name;

          int idx = 0;
          switch (currnetName) {
            case 'templates':
            case 'template_tasks':
              idx = 1;
              break;
            case 'projectInventory':
              idx = 2;
              break;
            case 'projectEnvironment':
              idx = 3;
              break;
            case 'projectKeyStore':
              idx = 4;
              break;
            case 'projectRepository':
              idx = 5;
              break;
            case 'projectTeam':
              idx = 6;
              break;
            default:
              idx = 0;
          }
          return SidebarItems(
            currentIndex: idx,
            onChanged: (i) {
              switch (i) {
                case 0:
                  router.goNamed(DashboardScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 1:
                  router.goNamed(TemplateScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 2:
                  router.goNamed(InventoryScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 3:
                  router.goNamed(EnvironmentScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 4:
                  router.goNamed(KeyStoreScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 5:
                  router.goNamed(RepositoryScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
                case 6:
                  router.goNamed(TeamScreen.name, pathParameters: {
                    'pid': '${currentProject.value?.id ?? 1}'
                  });
                  break;
              }
            },
            scrollController: scrollController,
            itemSize: SidebarItemSize.large,
            items: const [
              SidebarItem(
                leading: MacosIcon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.done_all),
                label: Text('Task Templates'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.inventory),
                label: Text('Inventory'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.monitor),
                label: Text('Environment'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.key),
                label: Text('Key Store'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.gite),
                label: Text('Repositories'),
              ),
              SidebarItem(
                leading: MacosIcon(Icons.group_work),
                label: Text('Team'),
              ),
            ],
          );
        });
      },
      bottom: Consumer(builder: (context, ref, _) {
        final router = ref.watch(routerProvider);
        final user = ref.watch(currentUserProvider);

        return user.when(
            error: (error, stackTrace) => SizedBox(
                  child: Text(error.toString()),
                ),
            loading: () => const ProgressCircle(),
            data: (user) {
              return Column(
                children: [
                  MacosListTile(
                    leading: const MacosIcon(
                      CupertinoIcons.settings,
                      color: MacosColors.systemGrayColor,
                    ),
                    title: const Text('Setting'),
                    subtitle: const Text('Theming, Server or Project'),
                    onClick: () {
                      router.goNamed(SettingsScreen.name, pathParameters: {
                        'module': SettingsScreenModule.theme.name
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  MacosListTile(
                    leading: const MacosIcon(
                      Icons.person,
                      color: MacosColors.systemGrayColor,
                    ),
                    title: const Text('Profile'),
                    subtitle: Text(
                      user?.name ?? '--',
                    ),
                    onClick: () {
                      router.goNamed(ProfileScreen.name, pathParameters: {
                        'module': ProfileScreenModule.info.name
                      });
                    },
                  ),
                ],
              );
            });
      }));
}

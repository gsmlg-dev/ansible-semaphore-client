import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/adaptive/tab_view.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/home/home_screen.dart';
import 'package:semaphore/screens/setting/setting_project.dart';
import 'package:semaphore/screens/setting/setting_server.dart';
import 'package:semaphore/screens/setting/setting_theme.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/server.dart';

enum SettingsScreenModule { theme, server, project }

extension SettingsScreenModuleWidget on SettingsScreenModule {
  Widget get wiget {
    switch (this) {
      case SettingsScreenModule.theme:
        return const ThemeSetting();
      case SettingsScreenModule.server:
        return const ServerSetting();
      case SettingsScreenModule.project:
        return const ProjectSetting();
    }
  }
}

class SettingsScreen extends ConsumerWidget {
  final SettingsScreenModule module;

  const SettingsScreen({super.key, required this.module});

  static const name = 'settings';
  static const path = '/settings/:module';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentServer = ref.watch(serversProvider.notifier).currentServer();
    final currentProject = ref.watch(currentProjectProvider);

    return AdaptiveScaffold(
        appBar: LocalAppBar(
            title: 'Settings',
            leading: currentServer == null
                ? const SizedBox()
                : currentProject.when(
                    data: (currentProject) => currentProject == null
                        ? const SizedBox()
                        : AdaptiveIconButton(
                            icon: const AdaptiveIcon(Icons.arrow_back_ios),
                            onPressed: () {
                              ref.read(routerProvider).goNamed(HomeScreen.name);
                            },
                          ),
                    loading: () => const SizedBox(),
                    error: (error, stack) => const SizedBox(),
                  )),
        body: SafeArea(
          child: AdaptiveTabView(
            initialIndex: SettingsScreenModule.values.indexOf(module),
            tabs:
                SettingsScreenModule.values.map<String>((m) => m.name).toList(),
            children: SettingsScreenModule.values
                .map<Widget>((m) => m.wiget)
                .toList(),
          ),
        ));
  }
}

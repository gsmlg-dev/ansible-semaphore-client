import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/floatingAction.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/components/environment/form.dart';
import 'package:semaphore/state/projects/environment.dart';

class EnvironmentScreen extends ConsumerWidget {
  const EnvironmentScreen({super.key});
  static const name = 'projectEnvironment';
  static const path = '/projects/:pid/environment';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // final currentProject = ref.watch(currentProjectProvider);
    final environmentList = ref.watch(environmentListProvider);

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Environment'),
      floatingAction: AdaptiveFloatingAction(
        icon: const AdaptiveIcon(Icons.add),
        label: 'Add',
        onPressed: () {
          adaptiveDialog(
            context: context,
            child: const EnvironmentForm(),
          );
        },
      ),
      body: SafeArea(
        child: PlutoGrid(
          mode: PlutoGridMode.readOnly,
          columns: environmentList.columns,
          rows: environmentList.rows,
          noRowsWidget: null,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            ref
                .read(environmentListProvider.notifier)
                .setStateManager(event.stateManager);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          configuration: environmentList.configurationWithTheme(context),
        ),
      ),
    );
  }
}

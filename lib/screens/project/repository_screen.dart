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
import 'package:semaphore/components/repository/form.dart';
import 'package:semaphore/state/projects/repository.dart';

class RepositoryScreen extends ConsumerWidget {
  const RepositoryScreen({super.key});
  static const name = 'projectRepository';
  static const path = '/projects/:pid/repository';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryList = ref.watch(repositoryListProvider);

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Repository'),
      floatingAction: AdaptiveFloatingAction(
        icon: const AdaptiveIcon(Icons.add),
        onPressed: () {
          adaptiveDialog(
            context: context,
            child: const RepositoryForm(),
          );
        },
      ),
      body: SafeArea(
        child: PlutoGrid(
          mode: PlutoGridMode.readOnly,
          columns: repositoryList.columns,
          rows: repositoryList.rows,
          noRowsWidget: null,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            ref
                .read(repositoryListProvider.notifier)
                .setStateManager(event.stateManager);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          configuration: repositoryList.configurationWithTheme(context),
        ),
      ),
    );
  }
}

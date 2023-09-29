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
import 'package:semaphore/components/user/form.dart';
import 'package:semaphore/state/projects/user.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});
  static const name = 'projectTeam';
  static const path = '/projects/:pid/team';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // final currentProject = ref.watch(currentProjectProvider);
    final userList = ref.watch(userListProvider);

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Team'),
      floatingAction: AdaptiveFloatingAction(
        icon: const AdaptiveIcon(Icons.add),
        onPressed: () {
          adaptiveDialog(context: context, child: const ProjectUserForm());
        },
      ),
      body: SafeArea(
        child: PlutoGrid(
          mode: PlutoGridMode.readOnly,
          columns: userList.columns,
          rows: userList.rows,
          noRowsWidget: null,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            ref
                .read(userListProvider.notifier)
                .setStateManager(event.stateManager);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          configuration: userList.configurationWithTheme(context),
        ),
      ),
    );
  }
}

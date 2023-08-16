import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/components/access_key/form.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/state/projects/access_key.dart';

class KeyStoreScreen extends ConsumerWidget {
  const KeyStoreScreen({super.key});
  static const name = 'projectKeyStore';
  static const path = '/projects/:pid/keyStore';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;

    // final currentProject = ref.watch(currentProjectProvider);
    final accessKeyList = ref.watch(accessKeyListProvider);

    return Scaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Key Store'),
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog.fullscreen(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: const AccessKeyForm(),
                );
              });
        },
      ),
      body: NeumorphicBackground(
        child: SafeArea(
          child: PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: accessKeyList.columns,
            rows: accessKeyList.rows,
            noRowsWidget: null,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              ref
                  .read(accessKeyListProvider.notifier)
                  .setStateManager(event.stateManager);
            },
            onChanged: (PlutoGridOnChangedEvent event) {},
            configuration: accessKeyList.configurationWithTheme(theme),
          ),
        ),
      ),
    );
  }
}

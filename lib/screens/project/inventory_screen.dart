import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/components/inventory/form.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});
  static const name = 'projectInventory';
  static const path = '/projects/:pid/inventory';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    // final neumorphicTheme = theme.extension<NeumorphicTheme>()!;

    // final currentProject = ref.watch(currentProjectProvider);
    final inventoryList = ref.watch(inventoryListProvider);

    return Scaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Inventory'),
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog.fullscreen(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: const InventoryForm(),
                );
              });
        },
      ),
      body: NeumorphicBackground(
        child: SafeArea(
          child: PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: inventoryList.columns,
            rows: inventoryList.rows,
            noRowsWidget: null,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              ref
                  .read(inventoryListProvider.notifier)
                  .setStateManager(event.stateManager);
            },
            onChanged: (PlutoGridOnChangedEvent event) {},
            configuration: inventoryList.configurationWithTheme(theme),
          ),
        ),
      ),
    );
  }
}

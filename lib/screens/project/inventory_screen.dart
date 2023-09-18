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
import 'package:semaphore/components/inventory/form.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});
  static const name = 'projectInventory';
  static const path = '/projects/:pid/inventory';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryList = ref.watch(inventoryListProvider);

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(title: 'Inventory'),
      floatingAction: AdaptiveFloatingAction(
        icon: const AdaptiveIcon(Icons.add),
        onPressed: () {
          adaptiveDialog(
            context: context,
            child: const InventoryForm(),
          );
        },
      ),
      body: SafeArea(
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
          configuration: inventoryList.configurationWithTheme(context),
        ),
      ),
    );
  }
}

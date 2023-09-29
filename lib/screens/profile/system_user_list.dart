import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/user/system_form.dart';
import 'package:semaphore/state/user.dart';

class SystemUserList extends ConsumerWidget {
  const SystemUserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemUserList = ref.watch(systemUserListProvider);
    return SizedBox.expand(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PlutoGrid(
              mode: PlutoGridMode.readOnly,
              createHeader: (PlutoGridStateManager stateManager) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptiveIconButton(
                      onPressed: () {
                        adaptiveDialog(
                            context: context,
                            child: const SystemUserForm(userId: null));
                      },
                      icon: const AdaptiveIcon(Icons.add),
                    ),
                  ],
                );
              },
              columns: systemUserList.columns,
              rows: systemUserList.rows,
              noRowsWidget: null,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                ref
                    .read(systemUserListProvider.notifier)
                    .setStateManager(event.stateManager);
              },
              onChanged: (PlutoGridOnChangedEvent event) {},
              configuration: systemUserList.configurationWithTheme(context),
            )));
  }
}

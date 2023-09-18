import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/adaptive/floatingAction.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/components/environment_name.dart';
import 'package:semaphore/components/inventory_name.dart';
import 'package:semaphore/components/repository.dart';
import 'package:semaphore/state/projects/template.dart';
import 'package:semaphore/state/projects/template_task.dart';

class TemplateTaskScreen extends ConsumerWidget {
  static const name = 'template_tasks';
  static const path = ':tid/tasks';

  final int templateId;
  const TemplateTaskScreen({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);

    // final currentProject = ref.watch(currentProjectProvider);
    final template = ref.watch(templateFamilyProvider(templateId));
    final taskList =
        ref.watch(templateTaskListProvider(templateId: templateId));

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.title2
        : theme.textTheme.titleMedium;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: template.when(
        data: (template) =>
            LocalAppBar(title: 'Task Template -> ${template.name}'),
        loading: () => const LocalAppBar(title: 'Task Template Loading'),
        error: (error, stack) => const LocalAppBar(title: 'Task Error'),
      ),
      floatingAction: AdaptiveFloatingAction(
        icon: const AdaptiveIcon(Icons.play_arrow),
        onPressed: () {
          ref
              .read(templateTaskListProvider(templateId: templateId).notifier)
              .prepareRunTask(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PlutoGrid(
                createHeader: (stateManager) {
                  return template.when(
                    data: (template) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Playbook', style: textTitleStyle),
                              Text(template.playbook ?? '--',
                                  style: textBodyStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type', style: textTitleStyle),
                              Text('Task', style: textBodyStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Inventory', style: textTitleStyle),
                              InventoryName(id: template.inventoryId),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Environment', style: textTitleStyle),
                              EnvironmentName(id: template.environmentId),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Repository', style: textTitleStyle),
                              RepositoryName(id: template.repositoryId),
                            ],
                          ),
                        ],
                      ),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                },
                mode: PlutoGridMode.readOnly,
                columns: taskList.columns,
                rows: taskList.rows,
                noRowsWidget: null,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  ref
                      .read(templateTaskListProvider(templateId: templateId)
                          .notifier)
                      .setStateManager(event.stateManager);
                },
                configuration: taskList.configurationWithTheme(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
